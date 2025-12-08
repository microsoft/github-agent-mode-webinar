# Governance Features

## Rulesets & Custom Properties

The repository has an organization ruleset [OD OctoCAT Supply Ruleset](https://github.com/organizations/octodemo/settings/rules/8545588) applied, setting up a few of the standard rules like:

1. Protecting the main branch from deletions, force pushes etc.
2. Requiring a pull-request
3. Requiring a CodeQL Scan
4. Requiring the required workflow [Dependency Review]()

The ruleset is applied through the custom property `od_octocat_supply_risk_tier` with a value of `high`. This custom property is also applied to the demo repositories.

You can use this to showcase how rulesets can be applied dynamically based on metadata on a repository - and how this gives both control and flexibility.

In the demo, there will be a pre-created pr `Feature: Add ToS Download` where some of the rules will be violated. You can demo the effect of rulesets on this PR by showing how the violations are flagged and what the implications are for the development process.
