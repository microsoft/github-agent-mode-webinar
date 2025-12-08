# OctoCAT Supply Chain Management - Makefile
# Supports both template (api-nodejs, api-python) and promoted (api) folder structures within actually rendered repositories for easier startup.

# Allow overriding backend via environment variable (e.g., BACKEND=python make dev)
BACKEND ?= $(shell \
	if [ -d "api" ]; then \
		if [ -f "api/package.json" ]; then echo "nodejs"; \
		elif [ -f "api/pyproject.toml" ]; then echo "python"; \
		else echo "unknown"; fi \
	elif [ -d "api-nodejs" ] && [ -d "api-python" ]; then echo "nodejs"; \
	elif [ -d "api-nodejs" ]; then echo "nodejs"; \
	elif [ -d "api-python" ]; then echo "python"; \
	else echo "unknown"; fi \
)

# Determine API directory (template vs promoted)
API_DIR := $(shell \
	if [ -d "api" ]; then echo "api"; \
	elif [ -d "api-$(BACKEND)" ]; then echo "api-$(BACKEND)"; \
	else echo "api"; fi \
)

FRONTEND_DIR := frontend

.DEFAULT_GOAL := help

##@ General

.PHONY: help
help: ## Display this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: info
info: ## Show detected backend and directories
	@echo "Detected Backend: $(BACKEND)"
	@echo "API Directory:    $(API_DIR)"
	@echo "Frontend Directory: $(FRONTEND_DIR)"

##@ Installation

.PHONY: install
install: ## Install all dependencies
	@echo "Installing dependencies for $(BACKEND) backend..."
ifeq ($(BACKEND),nodejs)
	cd $(API_DIR) && npm install
	cd $(FRONTEND_DIR) && npm install
else ifeq ($(BACKEND),python)
	cd $(API_DIR) && pip install -e ".[dev]"
	cd $(FRONTEND_DIR) && npm install
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

##@ Development

.PHONY: dev
dev: ## Start development servers (API + Frontend)
	@echo "Starting development environment with $(BACKEND) backend..."
ifeq ($(BACKEND),nodejs)
	@cd $(API_DIR)
	@trap 'kill 0' INT; \
	(cd $(API_DIR) && npm run dev) & \
	(cd $(FRONTEND_DIR) && VITE_API_URL=http://localhost:3000 npm run dev) & \
	wait
else ifeq ($(BACKEND),python)
	@$(MAKE) -C $(API_DIR) db-seed
	@trap 'kill 0' INT; \
	(cd $(API_DIR) && $(MAKE) dev) & \
	(cd $(FRONTEND_DIR) && VITE_API_URL=http://localhost:3000 npm run dev) & \
	wait
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

.PHONY: dev-api
dev-api: ## Start only the API development server
	@echo "Starting API development server ($(BACKEND))..."
ifeq ($(BACKEND),nodejs)
	cd $(API_DIR) && npm run dev
else ifeq ($(BACKEND),python)
	cd $(API_DIR) && $(MAKE) dev
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

.PHONY: dev-frontend
dev-frontend: ## Start only the frontend development server
	@echo "Starting frontend development server..."
	cd $(FRONTEND_DIR) && npm run dev

##@ Database

.PHONY: db-init
db-init: ## Initialize database schema
	@echo "Initializing database ($(BACKEND))..."
ifeq ($(BACKEND),nodejs)
	cd $(API_DIR) && npm run db:init
else ifeq ($(BACKEND),python)
	cd $(API_DIR) && $(MAKE) db-init
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

.PHONY: db-seed
db-seed: ## Initialize and seed database with sample data
	@echo "Seeding database ($(BACKEND))..."
ifeq ($(BACKEND),nodejs)
	cd $(API_DIR) && npm run db:seed
else ifeq ($(BACKEND),python)
	cd $(API_DIR) && $(MAKE) db-seed
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

##@ Building

.PHONY: build
build: ## Build all projects
	@echo "Building projects ($(BACKEND))..."
ifeq ($(BACKEND),nodejs)
	cd $(API_DIR) && npm run build
	cd $(FRONTEND_DIR) && npm run build
else ifeq ($(BACKEND),python)
	cd $(API_DIR) && $(MAKE) build
	cd $(FRONTEND_DIR) && npm run build
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

.PHONY: build-api
build-api: ## Build only the API
	@echo "Building API ($(BACKEND))..."
ifeq ($(BACKEND),nodejs)
	cd $(API_DIR) && npm run build
else ifeq ($(BACKEND),python)
	cd $(API_DIR) && $(MAKE) build
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

.PHONY: build-frontend
build-frontend: ## Build only the frontend
	@echo "Building frontend..."
	cd $(FRONTEND_DIR) && npm run build

##@ Testing

.PHONY: test
test: ## Run all tests
	@echo "Running tests ($(BACKEND))..."
ifeq ($(BACKEND),nodejs)
	cd $(API_DIR) && npm run test
	cd $(FRONTEND_DIR) && npm run test
else ifeq ($(BACKEND),python)
	cd $(API_DIR) && $(MAKE) test
	cd $(FRONTEND_DIR) && npm run test
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

.PHONY: test-api
test-api: ## Run API tests
	@echo "Running API tests ($(BACKEND))..."
ifeq ($(BACKEND),nodejs)
	cd $(API_DIR) && npm run test
else ifeq ($(BACKEND),python)
	cd $(API_DIR) && $(MAKE) test
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

.PHONY: test-frontend
test-frontend: ## Run frontend tests
	@echo "Running frontend tests..."
	cd $(FRONTEND_DIR) && npm run test

.PHONY: test-e2e
test-e2e: ## Run end-to-end tests
	@echo "Running E2E tests..."
	cd $(FRONTEND_DIR) && npm run test:e2e

.PHONY: test-coverage
test-coverage: ## Run tests with coverage
	@echo "Running tests with coverage ($(BACKEND))..."
ifeq ($(BACKEND),nodejs)
	cd $(API_DIR) && npm run test:coverage
else ifeq ($(BACKEND),python)
	cd $(API_DIR) && $(MAKE) test-coverage
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

##@ Linting

.PHONY: lint
lint: ## Lint all code
	@echo "Linting code ($(BACKEND))..."
ifeq ($(BACKEND),nodejs)
	cd $(API_DIR) && npm run lint
	cd $(FRONTEND_DIR) && npm run lint
else ifeq ($(BACKEND),python)
	cd $(API_DIR) && $(MAKE) lint
	cd $(FRONTEND_DIR) && npm run lint
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

.PHONY: lint-fix
lint-fix: ## Lint and auto-fix issues
	@echo "Linting and fixing code ($(BACKEND))..."
ifeq ($(BACKEND),nodejs)
	cd $(API_DIR) && npm run lint:fix
	cd $(FRONTEND_DIR) && npm run lint -- --fix
else ifeq ($(BACKEND),python)
	cd $(API_DIR) && $(MAKE) lint-fix
	cd $(FRONTEND_DIR) && npm run lint -- --fix
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

.PHONY: format
format: ## Format code with prettier/ruff
	@echo "Formatting code ($(BACKEND))..."
ifeq ($(BACKEND),nodejs)
	npx prettier --write "$(API_DIR)/**/*.{ts,tsx}" "$(FRONTEND_DIR)/**/*.{ts,tsx}"
else ifeq ($(BACKEND),python)
	cd $(API_DIR) && $(MAKE) format
	cd $(FRONTEND_DIR) && npx prettier --write "src/**/*.{ts,tsx}"
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

##@ Production

.PHONY: start
start: ## Start production server
	@echo "Starting production server ($(BACKEND))..."
ifeq ($(BACKEND),nodejs)
	cd $(API_DIR) && npm start
else ifeq ($(BACKEND),python)
	cd $(API_DIR) && $(MAKE) start
else
	@echo "Error: Unknown backend '$(BACKEND)'"
	@exit 1
endif

##@ Docker

.PHONY: docker-build
docker-build: ## Build Docker images
	@echo "Building Docker images..."
	docker-compose build

.PHONY: docker-up
docker-up: ## Start Docker containers
	@echo "Starting Docker containers..."
	docker-compose up

.PHONY: docker-down
docker-down: ## Stop Docker containers
	@echo "Stopping Docker containers..."
	docker-compose down

##@ Cleaning

.PHONY: clean
clean: ## Clean build artifacts and dependencies
	@echo "Cleaning build artifacts..."
ifeq ($(BACKEND),nodejs)
	rm -rf node_modules $(API_DIR)/node_modules $(FRONTEND_DIR)/node_modules
	rm -rf $(API_DIR)/dist $(FRONTEND_DIR)/dist
else ifeq ($(BACKEND),python)
	rm -rf $(API_DIR)/.venv $(API_DIR)/__pycache__ $(API_DIR)/src/__pycache__
	rm -rf $(API_DIR)/.pytest_cache $(API_DIR)/htmlcov $(API_DIR)/.coverage
	rm -rf $(FRONTEND_DIR)/node_modules $(FRONTEND_DIR)/dist
else
	@echo "Cleaning common artifacts..."
	rm -rf */node_modules */dist */__pycache__ */.venv
endif
	rm -rf $(API_DIR)/*.db $(API_DIR)/*.db-*
