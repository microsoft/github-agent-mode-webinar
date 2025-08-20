---
mode: agent
description: 'Scans the current chat history, strips noise, writes a concise GitHub Issue for GitHub Copilot Coding Agent'
tools: ['changes', 'githubRepo', 'problems', 'search', 'usages', 'github', 'github-remote','add_issue_comment', 'assign_copilot_to_issue', 'create_issue']
---

<!--
INTERNAL THOUGHTS – not shown to the user.
1. Parse the entire chat transcript supplied by VS Code.
2. Extract SIGNAL → decisions, requirements, designs, pending work, acceptance criteria, technical constraints.
   Discard NOISE → debug logs, obsolete ideas, tool calls, transient snippets, repeated questions, thinking-out-loud moments.
3. Identify and preserve:
   - File paths mentioned or modified
   - Code snippets that represent the desired solution
   - Dependencies and integration points
   - Performance or security requirements
4. Categorize findings into:
   A. Task overview (business value & user story)
   B. Technical Requirements
   C. In-Flight Work
   D. Known Issues / Risks
   E. Next Actions
   F. Success Criteria
   G. Resource Links
5. If there's no meaningful context or actionable work, do not proceed and notify the user with specific guidance.
6. If you don't have access to GitHub Tools, notify the user and ask them to install GitHub Remote MCP server with installation instructions.
7. Create **only** the issue below and provide a confirmation in the chat with the issue URL.
8. Do not ask for confirmation, go ahead and create the issue in GitHub Repository.
9. Use appropriate GitHub labels if available (e.g., 'enhancement', 'bug', 'documentation').
-->

## Process

1. Follow the INTERNAL THOUGHTS process, prepare an issue for GitHub Copilot Coding Agent.
   - Use the provided issue template.
   - Ensure the issue is concise and actionable.
   - Include all relevant details from the chat history.
   - Add context about the current codebase state if relevant.
2. Use GitHub tools to create an issue in the current repository
3. Assign the issue to Copilot Coding Agent
4. Add appropriate labels based on the work type
5. Provide the user with the confirmation and issue link

# Issue Template

```markdown
## 1. Task Overview
<!-- Business value, user story, and expected outcome. Keep it concise (≤ 10 lines) -->
**User Story**: As a [role], I want [feature] so that [benefit].
**Business Value**: 

## 2. Technical Requirements
<!-- Specific technical constraints, APIs to use, patterns to follow -->
- [ ] Must comply with existing architecture patterns
- [ ] Performance requirements: 
- [ ] Security considerations:
- [ ] Integration points:

## 3. In-Flight Work
<!-- Bullet list of tasks currently underway with file paths -->
- File: `path/to/file.ts` - [description of changes]
- Component: `ComponentName` - [status]

## 4. Known Issues / Risks
<!-- Bugs, blockers, design concerns, technical debt -->
- **Issue**: [description] | **Impact**: [high/medium/low] | **Mitigation**: [approach]

## 5. Next Actions (Immediate TODOs)
<!-- Checklist tasks. Be specific with file paths and methods when possible -->
- [ ] Update `src/api/controller.ts` to handle new endpoint
- [ ] Add unit tests for [specific functionality]
- [ ] Update documentation in `docs/api.md`

## 6. Success Criteria
<!-- How do we know when this task is complete? -->
- [ ] All unit tests pass (`npm run test:api`)
- [ ] Code builds without errors (`npm run build`)
- [ ] Feature works as described in acceptance criteria
- [ ] Documentation is updated

## 7. Documentation & Resources
<!-- Links to specs, diagrams, prior PRs, related issues -->
- Architecture: [Architecture Document](../docs/architecture.md)
- Related PR: #
- Design mockup: 
- API documentation:

## 8. Code Context
<!-- Key code snippets or patterns from the discussion -->
```typescript
// Example of the agreed implementation approach
```
```