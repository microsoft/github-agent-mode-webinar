# Contributing to OctoCAT Supply Demo

Thank you for your interest in contributing to the OctoCAT Supply Chain Management demo! This demo is designed to showcase GitHub Platform capabilities including GitHub Copilot, GitHub Advanced Security (GHAS), GitHub Actions, and other enterprise features.

## 🎯 About This Demo

**Important:** This is a demonstration application, not a production system. The primary objective is to effectively showcase GitHub Platform capabilities to customers and prospects. All contributions should keep this goal in mind.

The main repository for this demo is: **[octodemo-framework/demo_octocat_supply](https://github.com/octodemo-framework/demo_octocat_supply)**

## 🤝 How to Contribute

We welcome contributions in several areas:

### 1. Demo Application Code (TypeScript/React)

Contributions to the actual application code (frontend and API) should:

- Be realistic and representative of typical enterprise applications
- Support existing or new demo scenarios
- Follow existing patterns and coding standards
- Include tests where appropriate

### 2. Demo Scripts and Walkthroughs

Demo narrative scripts live in the [`demo/walkthroughs/`](./demo/walkthroughs/) directory:

- **[copilot.md](./demo/walkthroughs/copilot.md)** - GitHub Copilot demonstrations
- **[ghas.md](./demo/walkthroughs/ghas.md)** - GitHub Advanced Security demonstrations
- **[actions.md](./demo/walkthroughs/actions.md)** - GitHub Actions and CI/CD
- **[governance.md](./demo/walkthroughs/governance.md)** - Repository governance features
- **[issues-and-projects.md](./demo/walkthroughs/issues-and-projects.md)** - Issues and project management

When contributing to demo scripts:

- Keep scenarios realistic and relevant to enterprise customers
- Ensure steps are clear and reproducible
- Update related documentation if you change application behavior
- Test your walkthrough end-to-end before submitting

### 3. Demo Configuration (Octodemo Framework)

The `.octodemo/` directory contains configuration for the Octodemo Framework deployment system. Changes here should align with the [Demo Creator Guide](https://github.com/octodemo-framework/docs/blob/main/demo-creators/README.md).

### 4. Documentation

Documentation improvements are always welcome:

- Architecture documentation in [`docs/`](./docs/)
- Setup and configuration instructions
- Troubleshooting guides
- Demo best practices

## 🚀 Getting Started

### Prerequisites

- **Node.js** 18 or higher
- **npm** (comes with Node.js)
- **Git**
- **(Optional)** Docker for containerized development
- **(Optional)** GitHub Personal Access Token (PAT) for MCP server demos

### Initial Setup

1. **Clone the repository** (or your fork if you're an external contributor):

   ```bash
   # For octodemo-framework organization members:
   git clone https://github.com/octodemo-framework/demo_octocat_supply.git
   cd demo_octocat_supply
   
   # For external contributors (fork first, then):
   git clone https://github.com/YOUR-USERNAME/demo_octocat_supply.git
   cd demo_octocat_supply
   ```

2. **Install dependencies:**

   ```bash
   npm install
   ```

3. **Build the projects:**

   ```bash
   npm run build
   ```

4. **Initialize the database:**

   ```bash
   npm run db:seed
   ```

5. **Start the development servers:**

   ```bash
   npm run dev
   ```

   This starts both the API (port 3000) and frontend (port 5173).

### Development Workflow

1. **Create a feature branch:**

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** following the guidelines below

3. **Test your changes:**

   ```bash
   # Run all tests
   npm test
   
   # Run API tests only
   npm run test:api
   
   # Run frontend tests only
   npm run test:frontend
   
   # Lint frontend code
   npm run lint
   ```

4. **Build to ensure no errors:**

   ```bash
   npm run build
   ```

5. **Commit your changes** with a clear, descriptive commit message:

   ```bash
   git add .
   git commit -m "feat: Add shopping cart demo scenario"
   ```

6. **Push to your fork and create a Pull Request:**

   ```bash
   git push origin feature/your-feature-name
   ```

## 📋 Code Standards

### TypeScript/JavaScript

- Use TypeScript for type safety (avoid `any` unless absolutely necessary)
- Follow existing patterns in the codebase
- Use meaningful variable and function names
- Write tests for new features and bug fixes
- Run Prettier to format code: `npm run prettify`

### React/Frontend

- Use functional components with hooks
- Follow existing component structure patterns
- Use Tailwind CSS for styling (avoid custom CSS when possible)
- Ensure responsive design (test at mobile, tablet, and desktop sizes)
- Follow accessibility best practices (semantic HTML, ARIA labels when needed)

### API/Backend

- Follow RESTful conventions
- Use the repository pattern for data access
- Validate inputs and handle errors appropriately
- Update Swagger/OpenAPI documentation for new endpoints
- Use parameterized SQL queries (never build raw query strings with user input)

### Database

- Add migrations for schema changes in `api/sql/migrations/`
- Never modify existing migration files - always create a new sequential file
- Update seed data in `api/sql/seed/` if needed
- Test migrations with: `npm run db:migrate --workspace=api`

## 🧪 Testing Guidelines

All code changes should include appropriate tests:

- **Unit tests** for business logic and utilities
- **Integration tests** for API endpoints
- **Component tests** for complex React components
- Ensure tests are deterministic and don't depend on external services

Run tests before submitting:

```bash
npm test
```

## 📝 Commit Message Guidelines

Use conventional commit format:

- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `test:` - Test additions or updates
- `refactor:` - Code refactoring
- `chore:` - Build process or auxiliary tool changes

Example:

```
feat: Add product filtering to catalog page

- Implement filter by category
- Add price range slider
- Update API endpoint to support filtering
```

## 🌐 Access and Alternative Contribution Paths

### For Octodemo Framework Organization Members

If you have access to the `octodemo-framework` organization:

1. Create a branch in the main repository
2. Make your changes following the guidelines above
3. Submit a pull request for review

### For External Contributors (Without Octodemo Access)

We recognize that some deployments of this demo exist in environments where contributors may not have access to the `octodemo-framework` GitHub organization. If this applies to you:

1. **Fork the repository** if you have access to this instance
2. **Document your changes thoroughly** in your pull request description
3. **Include testing evidence** (screenshots, test output, etc.)
4. **Contact demo maintainers** if you need help submitting changes:
   - Open an issue describing your proposed contribution
   - Provide a detailed description and any code samples
   - Maintainers can help integrate your contribution

### Contributing to Your Local Demo Instance

If you're working in a closed environment:

1. Make changes to your local instance following these guidelines
2. Document your changes thoroughly
3. Share your improvements with your organization's demo maintainers
4. Consider whether the changes would benefit the broader demo community

## 🔍 Review Process

All contributions go through a review process:

1. **Automated checks** - Linting, tests, and builds must pass
2. **Code review** - At least one maintainer will review your changes
3. **Demo validation** - Changes that affect demo scenarios will be tested
4. **Documentation review** - Ensure docs are updated for behavioral changes

## ❓ Questions or Issues?

- **General questions**: Open a [GitHub Discussion](https://github.com/octodemo-framework/demo_octocat_supply/discussions)
- **Bug reports**: Open an [Issue](https://github.com/octodemo-framework/demo_octocat_supply/issues) with details
- **Feature proposals**: Open an [Issue](https://github.com/octodemo-framework/demo_octocat_supply/issues) describing the demo scenario

## 📚 Additional Resources

- [Main README](./README.md) - Project overview and setup
- [Demo Walkthroughs](./demo/walkthroughs/README.md) - Complete demo scenarios
- [Architecture Documentation](./docs/architecture.md) - System design details
- [Demo Creator Guide](https://github.com/octodemo-framework/docs/blob/main/demo-creators/README.md) - Octodemo Framework documentation
- [Custom Instructions](./.github/copilot-instructions.md) - Copilot configuration for this repo

## 🙏 Thank You

Your contributions help make this demo better for everyone using it to showcase GitHub's capabilities. We appreciate your time and effort!

---

**Remember:** This is a demo application designed to showcase GitHub Platform features. Keep the demo experience and effectiveness as your primary consideration when contributing.
