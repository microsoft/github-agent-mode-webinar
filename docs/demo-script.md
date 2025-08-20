# **GitHub Copilot Agent Mode & MCP Demo**

This demo app can be used to show a number of Copilot features:

- **Agent Mode and Vision**: generate a fairly complex UI updated (add the Cart functionality to the site) all with a natural language prompt and an image
- **Unit Testing**: run and generate unit tests to improve coverage
- **MCP Server**: 
  - generate a `.feature` file (Behaviour Driven Development/Testing file)and use Playwright to launch a browser and test the scenario
  - Interact with GitHub via the GitHub MCP server
- **Custom instructions**: personalize how Copilot responds by pointing to a fictional private observability framework that Copilot can work with, even though it is not a public library
- **Security**: 
  - Enable GHAS scans on the repo, and after finding a vulnerability, generate an autofix
  - Ask GitHub to find vulnerabilities in the code, then explain and fix them
- **Actions**: generate Actions workflows for deploy/publish
- **Infrastructure as Code**: generate Bicep or Terraform files for publishing
- **Padawan (SWE Agent)**: You can also ask Copilot to code via Padawan for some of the above scenarios by logging issues and assigning them to Copilot

> Note: For the most basic "What can Copilot do?" scenario, use the `demo-unit-test-coverage` prompt to have Agent Mode add some unit tests.

### **About Up the Demo**

- **About the App:** This is a modern TypeScript web-app with separate API and Frontend (React) projects that you will enhance with Copilot Agent Mode, Vision, MCP Servers and GHAS/Actions.
- **Why:** Demonstrate how Copilot can analyze and enhance existing code automatically, understand images, vulnerabilities and testing and how you can extend Copilot's capabilities with MCP server.
- **Demos**: You don't have to do all these demos, or do them in order. Get comfortable with the scenarios and practice them and then mix/match according to your audience.
- **MCP Servers**: The GitHub MCP server runs via Docker. You will need to install Docker locally to run it (it should work fine in a Codespace automatically). I use Podman for my Mac. Install this _before_ you attempt this demo! You'll also need a PAT that has enough permissions for your demos. Details below.
- **Padawan**: If you want to use Padawan, you have to ensure that it is enabled on the repo, that Actions are enabled and that you have a branch protection rule for `main`. I recommend creating a PR required for changes to Default branch with 1 required reviewer.
- **Local vs Codespaces:**  
  - This demo can work in a Codespace - but some scenarios (like running Playwright tests) require that you work in a local VSCode (clone the repo locally)
  - The visibility of the API port (3000) must be set to `public`. I have set this in the port attributes of the devcontainer file, but it seems that this config setting isn't always obeyed. Check before the demo! If you forget this, you will see CORS errors when the frontend tries to reach the API.
  - Make sure you **PRACTICE** this demo _before_ trying it in front of customers
  - Remember, Copilot is non-deterministic so you can't always predict exact behavior. Make sure you are comfortable with this environment so you can pivot quicky!
  - You don't have to use **VS Code Insiders** Version unless you want to demo features that you know are in preview.
    - If you want to access the Insiders Version in the web-version of a Codespace, click on the gear-icon on the bottom-left and select `Switch to Insiders Version...`

  ![Switch to Insiders](./vscode-switch-to-insiders.png)

### **Building, Running and Debugging the code**

Refer to [the build docs](./build.md).

### **Full end-to-end Azure Deplyment Demo (optional)**

This demo requires the following:
- `az cli` and `gh cli` for configuring the Azure environment as well as the repo (Environments and vars, as well as OIDC config)
- You will need an Azure Subscription, of which you have owner permissions
- To configure the environment, run `az login` and make sure you have selected the correct subscription.
- Run the following command: `./infra/configure-deployment.sh <repo-name>` and make sure that it completes successfully. If it does, you will have:
  - An Azure Service Principal, correctly configured for deployment
  - 2 Azure Resource Groups (one for Prod and one for Staging)
  - an Azure Container Registry (in the prod resource group)
  - 2 Environments in the Repo (Staging, Prod) with manual approval configured on Prod
  - Actions Variables - all the vars that are needed to run the workflows
  - OIDC configuration - the script configures OIDC connection for the repo/environments so you don't have to store any secrets in GitHub!

> **Note**: as an alternative, you can just generate the Bicep and Workflow files without actually executing them.

### **MCP Server install and config (optional)**

> You can skip the MCP Server demos if you want to, so this is optional. Also, you can run the GitHub MCP Server demo just fine in a Codespace, but will need Docker (or Podman or equivalent) to run the GitHub MCP Server locally. Also, the Playwright MCP Server demo will not work in a Codespace since it has to open a browser.

If you are wanting to show MCP server integration, you will need to set up and configure the MCP servers _prior_ to the demo. I have included the necessary `mcp` config in the [mcp.json](../.vscode/mcp.json) file. Open the file and use the HUD display above the servers to start them:

![](./mcp.png)

You can also use the Command Palette to start the MCP servers.

> Note: there are 2 GitHub MCP server: `github-local` and `github-remote`. The local server runs off `docker` (you may want to change this to `podman` if you have Podman installed). This will prompt for a PAT. The remote server connects to the Remote MCP server and uses OAuth to authenticate. **Start one or the other, not both**!

#### Start the Playwright MCP Server

- Use the cmd palette `Cmd/Ctrl + Shift + P` -> `MCP: List servers` -> `playwright` -> `Start server`

##### Start the GitHub MCP Server

> Generate a fine-grained PAT that has permissions to read/write Issues and PRs, context and whatever other features you want to demo. You can create this at the org/repo level. I suggest creating a PAT and storing it in a key vault (or 1Password) so that you have it handy.

- This server runs via Docker image, so you will need Docker to be installed and running before starting this server. I use Podman on my Mac.
- Use the cmd palette `Cmd/Ctrl + Shift + P` -> `MCP: List servers` -> `github` -> `Start server`. The first time you run this, you will have to supply a PAT.

> **Pro tip:** If you want to change the PAT, open the Settings json file. You will see `"id": "github_token" = ****` in the `input` section. Right-click on the `***` section to edit or clear the cached token. (The `***` is a GUI feature - the value is not actually stored in the json file)

### **Demo: Custom Prompt Files and Reusable Workflows**
- **What to show:** Reusing custom prompts to streamline AI-native workflow and demonstrate prompt engineering best practices
- **Why:** Demonstrate how Copilot and VSCode use custom prompts to help streamline AI-native workflows, keep developers in the flow, and provide consistent, repeatable results.
- **How:**  
  1. **Model Comparison Prompt**: Show the [model-compare.prompt.md](../.github/prompts/model-compare.prompt.md) file in the prompts directory. Explain the YAML frontmatter (mode: 'agent', description, tools). Click the Run button in the top (or use Command Palette → "Prompts: Run Prompt") and show how it automatically selects Agent mode, fetches live documentation, and updates the comparison markdown file.
  1. **Quick Demo Prompts**: Show the available demo prompts in the `.github/prompts/` directory:
     - `demo-cart-page.prompt.md` - Complete cart implementation with vision
     - `demo-unit-test-coverage.prompt.md` - Automated test generation and coverage analysis
  1. **Custom Chat Modes**: Show `Plan`, `ModelSelection` and `BDD` modes - each outlined below.
  1. **Live Demo**: Run one of the demo prompts (e.g., `demo-unit-test-coverage.prompt.md`) to show Agent mode automatically executing a complex workflow.
  1. **Note:** Explain that custom prompts provide consistency, reduce cognitive load, and can be shared across teams for standardized workflows.

### **Demo: Using Vision and Agent to Generate Cart Functionality**  

> **Quick Start Option**: Use the `demo-cart-page.prompt.md` custom prompt for an automated demo. This prompt will have Agent Mode implement the complete Cart Page functionality automatically with proper context and tools pre-configured.

- **What to show:** "Vibe coding" using Agent Mode and Vision to complete complex tasks, plus demonstrate custom prompt efficiency.
- **Why:** Demonstrate how Copilot Vision can detect design patterns, how Agent can understand a codebase and create complex changes over multiple files, and how custom prompts can streamline complex demos.
- **Approach 1 - Custom Prompt (Recommended for demos):**
  1. Open the [demo-cart-page.prompt.md](../.github/prompts/demo-cart-page.prompt.md) file
  1. Show the prompt structure: mode: 'agent', comprehensive tool list, detailed context about the current state
  1. Attach the [cart image](../docs/design/cart.png) to the prompt
  1. Click "Run" to execute the entire cart implementation automatically
  1. Show how the custom prompt handles the complete workflow with proper context

- **Approach 2 - Manual Chat (For deeper explanation):**
  1. Run the App to show the original code. Once the site starts, click on "Products" in the NavBar and show the Product Page. Add an item to the Cart - note that nothing actually happens, except a message saying, "Added to Cart". Explain that there is no Cart in the frontend app currently.
  1. Open Copilot and switch to "Plan" mode.
  1. Attach the [cart image](../docs/design/cart.png) using the paperclip icon or drag/drop to add it to the chat.
  1. Enter the following prompt:
    ```txt
    I need to implement a simple Cart Page. I also want a Cart icon in the NavBar that shows the number of items in the Cart.
    ```
  1. Highlight that Copilot has suggested changes and planned the components to add/modify.
  1. (OPTIONAL if you have the GitHub MCP Server configured): Ask Copilot to `create an issue in my repo to implement the Cart page and Cart icon`
  1. Show the issue in the repo
  1. Switch to "Agent" mode in Copilot Chat. Switch to `Claude 3.5 Sonnet` (a good implementation model) and enter this prompt:
    ```txt
    Implement the changes.
    ```
  1. Show Copilot's changes and how you can see each one and Keep/reject each one.
  1. Accept Copilot's suggested fixes.
  1. Go back to the Frontend app. Navigate to Products. Show adding items to the cart (note the icon updating). Click on the Cart icon to navigate to the Cart page. Show the total, and adding/removing items from the cart.

- **Key Takeaway**: Custom prompts provide consistency and can encapsulate complex workflows that would otherwise require multiple manual steps.

### **Demo: MCP Servers - Playwright**  

- **What to show:** Launch browser navigation using Playwright MCP server to show functional testing from natural language, plus demonstrate feature file generation with custom prompts.
- **Why:** Demonstrate support for extending Copilot capabilities using MCP server protocol and how custom prompts can standardize testing practices.
- **Part 1 - Custom BDD Mode:**
  1. Switch to `BDD` mode.
  1. Run the prompt `add a feature to test the cart icon and page` to generate comprehensive Gherkin feature files for Cart functionality
  1. Show the generated behavioral test scenarios

- **(Optional) Part 2 - Playwright MCP:**
  1. Ask Copilot to `browse to http://localhost:5137 and execute the test steps`
  1. Accept the Playwright command requests and show Copilot "running" the test.
  1. (Optional): Ask Copilot `to generate headless Playwright tests for the .feature file`

- **Key Takeaway**: MCP servers extend Copilot's capabilities while custom prompts can standardize testing approaches across teams.

### **Demo: MCP Servers - GitHub (Optional)**  

- **What to show:** Interact with GitHub from Chat.
- **Why:** Demonstrate support for extending Copilot capabilities using MCP server protocol as well as the GitHub MCP server.
- **How:**  
  1. Switch to Agent mode
  1. Ask Copilot to `check which issues are assigned to me in the repo`. 
  1. Show how Copilot fetched issues (or shows there are no issues)
  1. Ask Copilot to `create an Issue for enhancing test coverage in the API project and assign it to me`. (Don't forget to check the owner/repo in the args!)
  1. Show how Copilot creates a new Issue with a meaningful description and labels
  1. (Optional): Assign the issue to Copilot to queue off Coding Agent!

### **Demo: Enhancing Unit Tests and Coverage**  

> **Quick Start Option**: Use the `demo-unit-test-coverage.prompt.md` custom prompt for an automated demo. This prompt will have Agent Mode implement comprehensive unit tests for Product and Supplier routes automatically.

> **Coding Agent Option**: If you want to demo Coding Agent, there is an Issue for improving Code Coverage on the repo - it should be Issue #1 (created as part of the demo spinup). Assign this to Copilot - that's it. This takes about 15 mins, so do this ahead of time if necessary!

- **What to show:** Copilot generating multiple tests, executing them, analyzing coverage and self-healing, plus demonstrate efficient use of custom prompts for testing workflows.
- **Why:** Show Copilot's ability to quickly and easily generate tests, validate them, self-heal and analyze coverage. Also demonstrate how custom prompts can standardize testing practices.
- **Approach 1 - Custom Prompt (Recommended for demos):**
  1. Open the [demo-unit-test-coverage.prompt.md](../.github/prompts/demo-unit-test-coverage.prompt.md) file
  1. Show the prompt structure: pre-configured for Agent mode, comprehensive tool list, detailed testing requirements
  1. Explain how it includes specific coverage requirements, CRUD operations, error handling, etc.
  1. Click "Run" to execute the automated test generation
  1. Show how it creates comprehensive test files for both Product and Supplier routes
  1. Demonstrate the self-healing capabilities when tests fail

- **Approach 2 - Manual Chat (For deeper explanation):**
  1. Ask Copilot to `run tests, analyze coverage and add missing Branch tests to include tests for untested scenarios`
  1. Show Agent working on the tests and adding new tests for the API Branch route
  1. Show Copilot "self-healing" (if tests fail)
  1. Accept the changes
  1. Ask Copilot to `add tests for the Product route` to show generation of new tests

- **Key Takeaway**: Custom prompts can encapsulate testing best practices and ensure comprehensive coverage automatically.

### **Demo: Automating Deployment with GitHub Actions, Azure and Bicep**  

- **What to show:** Copilot generating Actions workflows and Infrastructure-as-code.
- **Why:** Show Copilot's ability to automate CI/CD workflows.
- **How:**  
  1. Ensure that you have run the [configure-deployment.sh](../infra/configure-deployment.sh) script to set up the initial infrastructure and configure the environments and vars in the repo.
  1. Add the [deployment.md](../docs/deployment.md) file as context.
  1. Prompt Copilot Agent to `generate bicep files and workflows according to the deployment plan`
  1. Show generated files:  
     - GitHub Actions YAML to build & test
     - GitHub Actions YAML to deploy including an approval step
  1. Accept the changes
  1. Commit and push to see the pipeline execution
  1. Show the deployment

### **Demo: Custom Instructions and Repository Configuration**

- **What to show:** Copilot's **Custom Instructions** feature using the existing `.github/copilot-instructions.md` configuration.
- **Why:** Demonstrate that Copilot can be customized and personalized for internal libraries, coding standards, and team practices that don't exist in the foundational models.
- **How:**  
  1. Show the existing [.github/copilot-instructions.md](../.github/copilot-instructions.md) file in the repository
  1. Explain how this file provides context about:
     - Repository information (owner, repo name)
     - Architecture references
     - Build and testing instructions
  1. **Demo Enhanced Custom Instructions**: Create or update the custom instructions file with additional guidelines:
    ```markdown
    # Additional Guidelines for REST APIs
    
    For REST APIs, use the following guidelines:
    
    * Use descriptive naming
    * Add Swagger docs for all API methods
    * Implement logging and monitoring using [TAO](../docs/tao.md)
      - assume TAO is installed and never add the package
    ```
  1. Show the [TAO](./tao.md) documentation to demonstrate the fictional internal library
  1. Ask Copilot to `add observability to the Supplier route using our internal standards`
  1. Show how Copilot uses the custom instructions to implement TAO observability patterns
  1. **Note**: Explain that this will not compile since TAO doesn't really exist - this demonstrates how custom instructions can reference internal frameworks
  1. **Key Takeaway**: Custom instructions allow teams to encode their specific practices, internal libraries, and coding standards

### **Demo: Copilot and Application Security**

- **What to show:** Copilot's ability to understand and remediate security vulnerabilities
- **Why:** Demonstrate that Copilot can be used to scale AppSec by bringing security expertise to Developers directly.
- **How:**  
  1. Open Copilot Chat and switch to `Ask` mode.
  1. Ask Copilot to `analyze @workspace and check if there are obvious security vulnerabilities`
  1. You should see issues like:
    - Cross-site Scripting (XSS) vulnerability
    - Command Injection Vulnerability
    - Insecure CORS Configuration
    - Missing Security Headers
    - Insecure Authentication Implementation
  1. Chat with Copilot to address one of these issues: `generate a fix for ...`
  1. (Optional with GitHub MCP Server): Ask Copilot to `create an issue to fix ...` and select a vulnerability for Copilot to create an Issue

### **Demo: GHAS and Autofix**

- **What to show:** GHAS Autofix (our first platform AI agent)
- **Why:** Demonstrate that Autofix is built into the platform using Copilot.
- **How:**  
  1. Open the repo, navigate to settings and enable Code scanning
  1. The scan should return at least 1 vulnerability
  1. Show "Generate fix" and how that can auto-generate a fix
  1. Show how you can Chat about this vulnerability and fix in Chat

### **Demo: Using `/handoff` Custom Prompt for Session Management**
- **What to show:** Using the custom `/handoff` prompt to hand off Ask/Agent work to another session with proper context preservation.
- **Why:** Demonstrate how custom prompts can control context, drop unnecessary information, and efficiently hand off work between Chat/Agent sessions or team members.
- **How:**  
  1. Open Copilot Chat and switch to `Plan` mode.
  1. Enter `I want to add Personal Profile page to the app that shows the user profile and their purchases.`
  1. Show the output and ask Copilot to change something in the plan: for example, remove the `purchases` part
  1. **Explain the Context Problem**: Currently the entire conversation is in the context, which over time grows long and can consume too much of the context window. Custom prompts can solve this by creating clean handoffs.
  1. **Show the Custom Prompt**: Open the [handoff.prompt.md](../.github/prompts/handoff.prompt.md) file in the prompts directory. Point out:
     - The YAML frontmatter configuring it as an Agent mode prompt
     - The internal thinking process in HTML comments (not shown to user)
     - The structured template for consistent handoffs
  1. **Run the Prompt**: Click the "Run" button, use Command Palette → "Prompts: Run Prompt" or type `/handoff` in the chat to execute the handoff prompt
  1. **Show Results**: Display the generated `handoff.md` document. It should contain:
     - Clean summary without noise from the conversation
     - Gathered information and requirements
     - The refined plan (without the removed `purchases` part)
     - Next actions for the receiving developer
  1. **Complete the Handoff**: Switch to `Agent` mode, include the handoff document as context, and ask Copilot to `implement the changes according to the handoff document`. You can cancel after a few seconds since you don't need to show the entire implementation.
  1. **Best Practices**: Explain that custom handoff prompts are valuable for:
     - Context size management
     - Clean knowledge transfer between sessions
     - Team collaboration and handoffs
     - Preserving important decisions while removing noise
  1. **Cleanup**: You can revert the changes to the `handoff.md` file after the demo.

### **Demo: Using `/handoff-to-copilot-coding-agent` Custom Prompt for Async Session Continuation**
- **What to show:** Using the custom `/handoff-to-copilot-coding-agent` prompt to hand off current plan work to GitHub Copilot Coding Agent with proper context preservation.
- **Why:** Demonstrate how custom prompts can encapsulate IDE tools and MCP tools calls into a cohesive workflow.

- **How:**  
  1. Make sure that you have Remote GitHub MCP Server running.
  1. Open Copilot Chat and switch to `Plan` Chat Mode.
  1. Enter `I want to add Personal Profile page to the app that shows the user profile and their purchases.`
  1. Show the output and ask Copilot to change something in the plan: for example, remove the `purchases` part
  1. **Explain Time Constraints**: We have a detailed plan now, Copilot Agent can follow it and implement the desired feature, however, in order to use our time efficiently we can hand off the implementation to the Copilot Agent, allowing us to focus on other tasks (or showing other copilot features in this demo).
  1. **Show the Custom Prompt**: Open the [handoff-to-copilot-coding-agent.prompt.md](../.github/prompts/handoff-to-copilot-coding-agent.prompt.md) file in the prompts directory. Point out:
     - The YAML frontmatter configuring it as an Agent mode prompt
     - The internal thinking process in HTML comments (not shown to user)
     - The structured issue template for consistent handoffs
     - Use of tools like `changes`, `create_issue`, and `assign_copilot_to_issue`.
     - Show how to configure the tools (click 'Configure Tools' link above `tools: []` line)
  1. **Run the Prompt**: 
   - *Important* We're in the 'Plan' Chat Mode now, and it has a limited set of tools available. We need to switch to `Agent` mode to use /handoff-to-copilot-coding-agent prompt. At the moment we cannot force switch the mode.
  - Click the "Run" button, use Command Palette → "Prompts: Run Prompt" or type `/handoff-to-copilot-coding-agent` to execute the handoff prompt
  1. **Show Results**: Display the generated output, it should contain a call to GitHub MCP and a short summary with the Issue link.
     - Clean summary without noise from the conversation
     - Gathered information and requirements
     - The refined plan (without the removed `purchases` part)
  
  Open GitHub repository and how the new issue. Demonstate that it's been assigned to GitHub Copilot Coding Agent and it started the session.

  1. **Complete the Handoff**: You can now stop the session if you don't need this implementation for your demo.

  1. **Best Practices**: Explain that custom prompts are valuable for:
   - Codifying repetitive parts of existing workflows
   - Improving the discoverability of available Copilot use cases

### **Demo: Using Coding Agent to Experiment in Parallel**  

- **What to show:** Cerating 3 variations of the Cart page in parallel.
- **Why:** Experimentation can be time-consuming and costly - unless you get coding agent to do it for you - in parallel! Then you can choose the option you like the best.
- **How:**  
  1. Make sure you have the GitHub Remote MCP server running
  2. Run the `demo-cca-parallel` prompt using the Command Palette
  3. **Note**: This takes a couple minutes to create the Issues and then Coding Agent takes about 20 minutes to complete the code changes, so be prepared for other demos or do this before your live demo and just show the results.

## **Key Takeaways for Customers**  

- **Custom Prompts**: Reusable prompts with YAML frontmatter enable consistent, repeatable workflows and can encapsulate complex multi-step processes
- **Agent Mode**: Handles multi-step changes across multiple files — saving time and reducing context switching
- **Vision Integration**: Enables Copilot to understand images, designs, and visual requirements for more intuitive development
- **Command Execution**: Allows Copilot to self-heal by running tests, validating changes, and iterating on solutions
- **MCP Protocol**: Extends Copilot with additional capabilities (gracefully handles credentials without hard-coding tokens!)
- **Custom Instructions**: Repository-level configuration allows teams to encode their specific practices, internal libraries, and coding standards
- **Testing Automation**: Custom prompts can standardize testing practices and ensure comprehensive coverage automatically
- **Security Integration**: Built-in security analysis and remediation capabilities help scale AppSec practices across development teams
