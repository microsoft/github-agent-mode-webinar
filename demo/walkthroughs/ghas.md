# GitHub Advanced Security Demo Features

## Code Scanning / CodeQL

> [!NOTE]
> Code Scanning is running in `Default Setup` natively in the demo. See the ["Switch to Advanced CodeQL Setup"](#switch-to-advanced-codeql-setup) below if you want to demo CodeQLs advanced setup.

### Main Branch: Past Vulnerabilities

- **What to show:** GHAS Autofix can fix existing alerts once they area detected.
- **Why:** Demonstrate that Autofix is built into the platform using Copilot.
- **How:**  
  1. Navigate to the repository's security page -> Code Scanning
  2. You should see a bunch of alerts, including a SQL injection (`Database query built from user-controlled sources`)
  3. Show "Generate fix" and how that can auto-generate a fix
  4. Show how you can Chat about this vulnerability and fix in Chat

> [!NOTE]
> You will see a bunch of alerts - the only one guaranteed is the SQL Injection one mentioned above. You can use the others to demo if they are there, but don't rely on them as we might fix some of those or change it as we update the demo.

### PR Protection: Introduced Vulnerabilities

- **What to show:** GHAS can detect vulnerabilities introduced in pull requests
- **Why:** Demonstrate that GHAS can help prevent vulnerable code from being mergedin the first place
- **How:**  
  1. Navigate to the repositories Pull Requests
  2. Find the PR `Feature: Add ToS Download`
  3. If the Code-Scanning Scan was alredy done, you'll see two alerts (in any order):
     1. **Uncontrolled data used in path expression**
     2. **Missing rate limiting**
  4. The `Uncontrolled data used in path expression` is a path traversal vulnerability - part of OWASP curent Number 1 vulnerability as part of a `Broken Access Control` (<https://owasp.org/Top10/A01_2021-Broken_Access_Control/>)
  5. Showcase how GHAS does not only showcase the path and data traversal, but also how Copilot Autofix already provides a fix for this vulnerability

#### Demo exploiting the vulnerability

In case you want to demo how this vulnerability can be exploited:

1. Checkout the Branch of the PR in a Codespace
2. After `npm install` ran through, start the app with `npm run dev`
3. Navigate to the application (link should appear in the startup)
4. Scroll to the bottom of the page and click `Terms & Conditions`
5. Hover over one of the buttons, right click and copy the URL
6. Insert it into the browser window, then replace the `&file=` path with `file=../../super-secret.txt`
7. This should trigger a download of the same named file in `.api/documents/super-secret.txt` - something that should not be possible

### Live Code: Introduced Vulnerabilities

If you prefer live-coding a vulnerability, follow these steps:

- **What to show:** GHAS Autofix built into PRs
- **Why:** Demonstrate that Autofix becomes a part of the developer workflow naturally at the PR
- **How:**  
  1. Open the Chat window and enter `/code-injection` to run the code injection prompt.
  2. **Note**: Sometimes a model will refuse since this is "bad" - try another model in this case and show customers how "responsible" Copilot is.
  3. The prompt should create a new branch, change the `delivery.ts` route to add a vulnerability, and push.
  4. Create a PR for the new branch and show how GHAS alerts and suggests a fix inline in the PR.

### Switch to Advanced CodeQL Setup

If you want to demo the more advanced CodeQL setup, you can easily do so with the existing `codeql-advanced.yml` workflow by following these steps:

1. Go to the Repository Settings -> Advanced Security
2. Scroll to `Code scanning -> Tools`
3. Click the three dots on `CodeQL analysis` and select `Switch to advanced`
4. It will tell you that `CodeQL` must be disabled first - this is fine
5. It will redirect you to create a custom `codeql.yml` workflow file, which you can just abort
6. In your repository, navigate to `Actions`
7. On the lefthand side, click on `CodeQL Advanced` and activate the workflow
8. Manually trigger the workflow (it has a `workflow_dispatch` trigger) for the `main` branch
9. Once the workflow is done, advanced setup is complete (you will see a warning in the repo's settings page until then - you can ignore that)

> [!NOTE]
> This is just the first iteration of this demo feature where the `codeql-advanced.yml` basically does the same as the default setup. We will enhance this to an actually more advanced workflow in the future.

## Secret Scanning

### Main Branch: Leaked Secrets

1. Go the Repository -> Security -> Secrets
2. You will see two alerts: One Default and one or two generic (the second is an AI detected - sometimes it can take while for them to show up)
    1. **Default: GitHub PAT** - This got leaked within the `api/.env.example` file - however, another commit removed the secret again. You can showcase how Secret Scanning goes through the entire GitHub history
    2. **Generic: AI Detected Password** - Also leaked in the `api/.env.example` and removed in another commit, this is so called `generic secret` detected by AI. It's supposed to be a project specific password, so you can demo how GitHub is also capable of detecting these.
    3. **Generic: RSA Token** -Leaked in `api/ca.key`, this is a so called `non-provider` pattern secret

### Push Protection: Anthropic API Key

1. Apply the Patch Set `GHAS: Inject Secrets`[^1]
2. This will create a file `logs/debug.log` where you can find a leaked `anthropic` API key.
3. Commit the File
4. Open a terminal and enter `git push`
5. Observe push proection
6. (optional) Navigate to the bypass website contained in the push protection message and demo bypassing push-protection

## Dependabot

### Existing 3rd Party Vulnerabilities

There are two guaranteed vulnerabilities:

1. **Axios v1.8.1**: In the [frontend/package.json](../../frontend/package.json), Axios is installed in a Version that contains the [Advisory "CVE-2025-27152"](https://github.com/advisories/GHSA-jr5f-v2jv-69x6)
    - In the repository, navigate to `Security -> Dependabot` to demo the alert
    - In the alert, you can find an EPSS score, CWE and other information you can point to
2. **Dockerfile Alpine:** In the [frontend/Dockerfile](../../frontend/Dockerfile) and [api/Dockerfile](../../api/Dockerfile), you'll find that we are using an outdated alpine version. While Dependabot does not Support vulnerability alerts for this, it will open a PR with an update.

> [!NOTE]
> Only the above vulnerabilities are guaranteed to exist in a demo. You might see other dependency vulnerabilities naturally, as we won't be able to always keep all packages of this demo up-to-date. It somewhat adds a bit of non-critical non-determinism to the demo you can just use to your advantage ("this is like in a real project")

### Dependency Review: Licensde Violation with a AGPL-3.0 licensed package

1. Search for the PR `feature: Add download of terms and services`
2. The PR was scanned using the required workflow `Dependency Review` (see [actions.md](./actions.md) for more info on that)
3. The review shuld've failed, as the PR tries to add the dependency `ua-parser-js` - a library to read user-agent strings, in this case used to prevent SEO- and AI-Parser to download files to prevent DDoS. `ua-parser-js` is licensed under `AGPL-3.0`, which is specifically denied by the `Dependency Review` Workflow

> [!NOTE]
> `GPL-3.0` is a strong Copy-Left license, meaning any derivative work must also be open-sourced under the same license. This means: Customers cna not use these libraries to work on their private commercialised applications, and it's a common problem for enterprise to prevent their users from spotting and using these. `ua-parser-js`  uses this to only allow other open source projects from using it for free - non-copy-left licenses are available with a $-Tag.

### Live Demo: Add a vulnerable & blocked action

1. Apply the Patch-Set `GHAS: Inject Dependabot Vulnerable Action`[^1] (ideally, select `Yes` for creating a new Branch)
2. Commit the created workflow file (`./github/workflows/aut-label-by-branch.yml`)
3. Create a PR with this Action
4. You can demo two things:
   1. The Action created a dependabot alert, as the used action `tj-actions/branch-names@v8.2.0` has the existing [Advisory "CVE-2025-54416"](https://github.com/advisories/GHSA-gq52-6phf-x2r6)
   2. The Action was blocked, as it was explicitly blocked through the Actions Allow List - you can demo it by navigating to the Repository `Settings -> Actions -> General`
`

---------

[^1]: To learn how to apply a patch-set, see [patch-sets.md](patch-sets.md)
