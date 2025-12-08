#!/bin/bash

set -e

# Show help
show_help() {
    echo "GitHub Artifact Attestation Verification Script"
    echo ""
    echo "Usage: $0 [OPTIONS] [VERSION]"
    echo ""
    echo "Arguments:"
    echo "  VERSION    Container version to verify (e.g., main-abc123)"
    echo "             If not provided, will search for latest 'main-*' version"
    echo ""
    echo "Options:"
    echo "  --debug    Show detailed debug information during checks"
    echo "  --help     Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                    # Find and verify latest main-* version"
    echo "  $0 main-abc123       # Verify specific version"
    echo "  $0 --debug           # Show debug info while finding latest"
    echo "  $0 --debug main-xyz  # Show debug info for specific version"
    echo ""
    echo "This script will:"
    echo "1. Detect your GitHub repository"
    echo "2. Verify GitHub CLI setup and permissions"
    echo "3. Find the specified container version (or latest 'main-*')"
    echo "4. Verify the artifact attestation using GitHub CLI"
}

# Parse command line arguments
DEBUG_MODE=false
SPECIFIED_VERSION=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --debug)
            DEBUG_MODE=true
            shift
            ;;
        --help)
            show_help
            exit 0
            ;;
        --*)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
        *)
            # This should be the version
            if [[ -n "$SPECIFIED_VERSION" ]]; then
                echo "Error: Multiple versions specified"
                show_help
                exit 1
            fi
            SPECIFIED_VERSION="$1"
            shift
            ;;
    esac
done

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_debug() {
    if [[ "$DEBUG_MODE" == "true" ]]; then
        echo -e "${BLUE}[DEBUG]${NC} $1"
    fi
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to get repository information
get_repo_info() {
    local github_org=""
    local repository=""
    local github_hostname=""
    
    # Try to get from Codespace environment variable first
    if [[ -n "${GITHUB_REPOSITORY:-}" ]]; then
        github_org=$(echo "$GITHUB_REPOSITORY" | cut -d'/' -f1)
        repository=$(echo "$GITHUB_REPOSITORY" | cut -d'/' -f2)
        # Get hostname from GITHUB_SERVER_URL or default to github.com
        if [[ -n "${GITHUB_SERVER_URL:-}" ]]; then
            github_hostname=$(echo "$GITHUB_SERVER_URL" | sed -E 's|https?://||')
        else
            github_hostname="github.com"
        fi
    else
        # Fallback to git remote
        local git_remote
        git_remote=$(git remote get-url origin 2>/dev/null || echo "")
        
        if [[ -z "$git_remote" ]]; then
            return 1
        fi
        
        # Parse GitHub URL (handles both SSH and HTTPS, and any hostname)
        if [[ "$git_remote" =~ ([a-zA-Z0-9.-]+)[:/]([^/]+)/([^/.]+) ]]; then
            github_hostname="${BASH_REMATCH[1]}"
            github_org="${BASH_REMATCH[2]}"
            repository="${BASH_REMATCH[3]}"
        else
            return 1
        fi
    fi
    
    echo "$github_org/$repository|$github_hostname"
}

# Function to check if GH CLI is installed
check_gh_cli() {
    if ! command -v gh &> /dev/null; then
        log_error "GitHub CLI (gh) is not installed. Please install it first:"
        log_info "https://cli.github.com/manual/installation"
        exit 1
    fi
    
    log_debug "GitHub CLI is installed"
}

# Function to check if user is logged in
check_gh_auth() {
    if ! gh auth status &> /dev/null; then
        log_error "You are not logged in to GitHub CLI. Please run:"
        log_info "gh auth login"
        exit 1
    fi
    
    log_debug "GitHub CLI is authenticated"
}

# Global variable to cache package versions
CACHED_VERSIONS=""

# Function to check scopes
check_gh_scopes() {
    log_debug "Testing access to GitHub Packages..."
    
    local repo_info
    repo_info=$(get_repo_info)
    
    if [[ -z "$repo_info" ]]; then
        log_error "Could not determine repository information"
        exit 1
    fi
    
    local repo_full=$(echo "$repo_info" | cut -d'|' -f1)
    local github_org=$(echo "$repo_full" | cut -d'/' -f1)
    local repository=$(echo "$repo_full" | cut -d'/' -f2)
    
    log_debug "Repository: $repo_full"
    log_debug "Organization: $github_org"
    log_debug "Package name: $repository-api"
    
    # Try to access the specific API container package versions and cache the result
    CACHED_VERSIONS=$(gh api \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "/orgs/$github_org/packages/container/$repository-api/versions" 2>/dev/null)
    
    if [[ -z "$CACHED_VERSIONS" ]]; then
        log_error "Unable to access GitHub Packages for your repository."
        log_info ""
        log_info "Please ensure that:"
        log_info "1. You are logged in to GitHub CLI with the correct account"
        log_info "2. Your GitHub CLI token has the 'read:packages' scope"
        log_info ""
        log_info "To check your current authentication status:"
        log_info "  gh auth status"
        log_info ""
        log_info "To check/refresh your token with the required scope:"
        log_info "  gh auth refresh -s read:packages"
        log_info ""
        log_info "You can also check your token scopes at:"
        log_info "  https://github.com/settings/tokens"
        
        exit 1
    else
        log_debug "Successfully accessed GitHub Packages"
    fi
}

# Function to check container registry login
check_container_registry_auth() {
    local github_org=$1
    
    # Try to check if we can access the registry
    log_debug "Checking GitHub Container Registry (ghcr.io) authentication..."
    
    # Get the token from gh CLI
    local token
    token=$(gh auth token)
    
    # Test authentication with a simple request
    if ! echo "$token" | docker login ghcr.io -u "$(gh api user --jq .login)" --password-stdin &> /dev/null; then
        log_debug "Not logged in to GitHub Container Registry"
        log_debug "Logging in using GitHub CLI token..."
        
        local username
        username=$(gh api user --jq .login)
        
        if echo "$token" | docker login ghcr.io -u "$username" --password-stdin &> /dev/null; then
            log_debug "Successfully logged in to GitHub Container Registry"
        else
            log_error "Failed to log in to GitHub Container Registry"
            exit 1
        fi
    else
        log_debug "Already authenticated with GitHub Container Registry"
    fi
}

# Function to find latest API container
find_latest_container() {
    local repo_full=$1
    local github_org=$(echo "$repo_full" | cut -d'/' -f1)
    local repository=$(echo "$repo_full" | cut -d'/' -f2)
    
    # Use cached versions if available, otherwise fetch them
    local versions_json="$CACHED_VERSIONS"
    if [[ -z "$versions_json" ]]; then
        versions_json=$(gh api \
            -H "Accept: application/vnd.github+json" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
            "/orgs/$github_org/packages/container/$repository-api/versions" 2>/dev/null)
    fi
    
    # Get the latest package version matching main-*
    local latest_version
    latest_version=$(echo "$versions_json" | jq -r '.[] | select(.metadata.container.tags[]? | test("^main-")) | .metadata.container.tags[] | select(test("^main-"))' | head -1)
    
    if [[ -z "$latest_version" ]]; then
        # Send error messages to stderr so they don't get captured in command substitution
        log_error "No container found with version pattern 'main-*'" >&2
        log_info "Available versions:" >&2
        echo "$versions_json" | jq -r '.[] | .metadata.container.tags[]?' | head -10 >&2
        exit 1
    fi
    
    # Only echo the version, no log messages
    echo "$latest_version"
}

# Function to verify attestation
verify_attestation() {
    local repo_full=$1
    local version=$2
    local github_hostname=$3
    local github_org=$(echo "$repo_full" | cut -d'/' -f1)
    local repository=$(echo "$repo_full" | cut -d'/' -f2)
    
    local container_url="oci://ghcr.io/$github_org/$repository-api:$version"
    
    log_info "Verifying attestation for: $container_url"
    log_info "Repository: $repo_full"
    log_info "GitHub Hostname: $github_hostname"
    log_info "Predicate type: https://spdx.dev/Document/v2.3"
    
    echo
    log_info "Running attestation verification..."
    echo "Command: gh attestation verify \"$container_url\" -R \"$repo_full\" --signer-repo \"$github_org/od-octocat-supply-workflows\" --hostname \"$github_hostname\""
    
    # Visual separator before results
    echo
    echo "═══════════════════════════════════════════════════════════════════════════════"
    echo "                           ATTESTATION VERIFICATION RESULTS"
    echo "═══════════════════════════════════════════════════════════════════════════════"
    echo
    
    if gh attestation verify "$container_url" -R "$repo_full" --signer-repo "$github_org/od-octocat-supply-workflows" --hostname "$github_hostname"; then
        echo
        echo "═══════════════════════════════════════════════════════════════════════════════"
        echo -e "                              ${GREEN}✓ VERIFICATION SUCCESSFUL${NC}"
        echo "═══════════════════════════════════════════════════════════════════════════════"
        echo
        echo "The following assumptions about the artifact $container_url were verified:"
        # Updated success details
        echo -e "${GREEN}✓${NC} Verified attestation with predicate-type \"https://slsa.dev/provenance/v1\" exists"
        echo -e "${GREEN}✓${NC} Verified source repository matches this repository: $repo_full"
        echo -e "${GREEN}✓${NC} Verified artifact was built using the reusable workflow: $github_org/od-octocat-supply-workflows"
        echo "═══════════════════════════════════════════════════════════════════════════════"
        echo
        echo "💡 To see the full attestation details in JSON format, run:"
        echo "   gh attestation verify \"$container_url\" -R \"$repo_full\" --signer-repo \"$github_org/od-octocat-supply-workflows\" --hostname \"$github_hostname\" --format json"

        echo "💡 To see the SBOM Attestation, run:"
        echo "   gh attestation verify \"$container_url\" -R \"$repo_full\" --signer-repo \"$github_org/od-octocat-supply-workflows\" --hostname \"$github_hostname\" --predicate-type https://spdx.dev/Document/v2.3"
    else

        echo
        echo "═══════════════════════════════════════════════════════════════════════════════"
        echo -e "                              ${RED}✗ VERIFICATION FAILED${NC}"
        echo "═══════════════════════════════════════════════════════════════════════════════"
        log_error "Attestation verification failed!"
        echo -e "${RED}[ERROR]${NC} Container: $container_url"
        echo -e "${RED}[ERROR]${NC} The artifact could not be verified or has invalid attestations."
        echo "═══════════════════════════════════════════════════════════════════════════════"
        echo
        echo "💡 To see detailed error information, run:"
        echo "   gh attestation verify \"$container_url\" -R \"$repo_full\" --signer-repo \"$github_org/od-octocat-supply-workflows\" --hostname \"$github_hostname\" --format json"
        exit 1
    fi
}

# Main execution
main() {
    log_info "Starting GitHub Artifact Attestation Demo"
    echo
    
    # Get repository information
    log_info "Determining repository information..."
    local repo_info
    repo_info=$(get_repo_info)
    
    if [[ -z "$repo_info" ]]; then
        log_error "Could not determine repository. Not in a git repository or no origin remote found."
        exit 1
    fi
    
    # Parse repository info
    local repo_full=$(echo "$repo_info" | cut -d'|' -f1)
    local github_hostname=$(echo "$repo_info" | cut -d'|' -f2)
    
    # Determine source of repository info
    if [[ -n "${GITHUB_REPOSITORY:-}" ]]; then
        log_info "Using repository from Codespace: $repo_full"
    else
        log_info "Using repository from git remote: $repo_full"
    fi
    log_info "GitHub hostname: $github_hostname"
    echo
    
    # Check GH CLI installation
    log_debug "Checking GitHub CLI installation..."
    check_gh_cli
    if [[ "$DEBUG_MODE" == "true" ]]; then
        echo
    fi
    
    # Check authentication
    log_debug "Checking GitHub CLI authentication..."
    check_gh_auth
    if [[ "$DEBUG_MODE" == "true" ]]; then
        echo
    fi
    
    # Check scopes
    log_debug "Checking GitHub CLI scopes..."
    check_gh_scopes
    if [[ "$DEBUG_MODE" == "true" ]]; then
        echo
    fi
    
    # Check container registry authentication
    log_debug "Checking GitHub Container Registry authentication..."
    check_container_registry_auth "$repo_full"
    if [[ "$DEBUG_MODE" == "true" ]]; then
        echo
    fi
    
    # Determine version to use
    local version_to_verify
    if [[ -n "$SPECIFIED_VERSION" ]]; then
        log_info "Using specified version: $SPECIFIED_VERSION"
        version_to_verify="$SPECIFIED_VERSION"
    else
        # Find latest container
        log_info "Finding latest API container..."
        log_info "Searching for latest API container with version 'main-*'..."
        version_to_verify=$(find_latest_container "$repo_full")
        
        if [[ -n "$version_to_verify" ]]; then
            log_success "Found latest container version: $version_to_verify"
        fi
    fi
    echo
    
    # Verify attestation
    log_info "Verifying attestation..."
    verify_attestation "$repo_full" "$version_to_verify" "$github_hostname"
}

# Run main function
main "$@"
