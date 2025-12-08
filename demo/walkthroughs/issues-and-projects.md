# Issue & Projects

## Issues

This repository comes with a number of pre-created issues that you can use to demo various features of GitHub Issues, like:

- **Link PRs to issues**: The issue `Allow downloading our terms and conditions` is linked to the pre-created PR `Feature: Add ToS Download`
- **Sub-Issues**: The Issue `Add terms acceptance to checkout process` is a sub-issue of `Compliance Requirements`, so you can easily navigate from there to the parent issue
- **Issue Types**: In the `Compliance Requirements` issue, you can see the `Epic` issue type and compare it to the `Feature` and `Task` of other sub-issues there
- **Issue Dependencies**: In the `Compliance Requirements` issue, you can see that the `Add terms acceptance to checkout process` issue is blocked by the `Allow downloading our terms and conditions` issue

## Projects

All issues are also placed on a project board which is linked to the repository itself. It's designed to reflect a realistic project board of an agile project with a bunch of features.

> [!NOTE]
> We believe most of these are self-explanatory, and demoing a project board is usually mostly clicking and showing as you go, so there is no concrete step-by-step guide here. However, if you want to prepare for a demo, here are some of the key aspects to highlight:

### Project Fields

- **Status** (`Single Select`): Showcases Single Select fields with pre-defined values
- **Priority** (`Single Select`): Another use-case for single-selects
- **Sprint** (`Iteration`): Showcases a date-bound selection
- **Estimate** (`Number`): Used for estimating Story points (1, 2, 3, 5, 8)
- **Squad** (`Single Select`): Showcases how issues can be assigned to different teams easily

### Views

- **Team backlog:** A Backlog grouped by Squads (aka `Teams`), showing the Status, Priority and Sub-Issue Progress of Issues
- **Sprint Board:** A board view of the current sprint, showing the Status and Priority of issues
- **Roadmap:** A timeline view of the next 2 Sprints
- **PRs in review:** Showcases the pre-created PR `Feature: Add ToS Download`, allows to demo how PRs can be part of planning as well
- **Copilot Tasks:** If you've previously added an Issue to Copilot, it will appear here
- **My items:** Should show the issues assigned to the current user
- **Needs triage:** Shows how issues can be filtered by `Status`

### Workflows

Projects come with a set of default workflows that can be enabled or disabled on a project, in addition to custom automations powered by APIs or Actions. Some of these include:

- **Auto-add to project:** Automatically add items from repositories that match a filter criteria, such as `is:issue state:open type:bug`.
- **Auto-add sub-issues to project:** When an item is added to a project that has sub-issues, add the sub-issues as well.
- **Auto-archive items:** Automatically archive items from a project if they are no longer needed, such as closed items updated more than 30 days ago.
- **Item added to project:** Set the `Status` for an item once it is added to a project, such as "Backlog" or "Triage".
- **Auto-close issue:** Close an issue once the `Status` is changed to "Done" or another value.
- **Item closed** and **Pull request merged**: Set the `Status` to "Done" when an issue is closed or a pull request is merged.

### Insights

> [!WARNING]
> As we can't create demos "back in time", time-based insights (like `Burn up`) will not show a lot of data. Make the customer aware that, in a real project, these insights will be much more useful.

- **Bugs per sprint**: Bar-chart to visualize the number of bugs introduced per sprint
- **Priority Breakdown**: Priority grouped by Status, showcases how we can see wether the top priority items are being worked on
- **Sprint capacity**: Showcases how many story points are placed in the different sprints
- **Team priority breakdown**: Showcases the distribution of priorities per team
