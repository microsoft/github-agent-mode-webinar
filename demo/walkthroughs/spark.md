# GitHub Spark Demo Features

This demo walks through how a **Product Manager** can use **GitHub Spark** to go from **idea → prototype → deployed app**, validating ideas early and collaborating seamlessly with engineering — all without leaving GitHub.
The Spark app in this demo is a logistics overview and tracking dashboard for the OctoCat Supplies app.

## Core Values to Highlight

- Ideas to apps without need to worry about the "how"
- Validate ideas early
- Rapid prototyping and seamless deployment  
- Collaboration between product and engineering

> [!WARNING]
> Spark can take a good 3 - 5 minutes to generate your initial app. We recommend you prepare Step 1 ahead of time to ensure a smooth demo experience.

---

## 1. App Creation: From Idea to Live Prototype

**What to show:** Creating a full-stack prototype directly from a natural language prompt. Demonstrates Spark’s speed and accessibility for non-developers or PMs to test and share ideas quickly.  

1. In the Spark interface, enter one of these prompts:

    Short version (less content, but faster):

    ```txt
    Create an app that provides a logistics overview and tracking dashboard for all orders from the Octocat Supplies Store. It should give individual users visibility into where each order stands—from placement to delivery or cancellation.
    ```

    Long version (more detailed content, but takes longer):

    ```txt
    Create an app that provides a logistics overview and tracking dashboard for all orders from the Octocat Supplies Store. It should give individual users visibility into where each order stands—from placement to delivery or cancellation. Integrate location services and a live map view to visualize shipment routes and delivery statuses. Add search order and filtering capabilities.
    ```

2. (optional) Attach the prototype-image in [./docs/design/order-tracking-prototype.png](../../docs/design/order-tracking-prototype.png) - explain this is the design coming from Figma or any other design tool.

3. Submit

> [!TIP]
> Reinforce that Spark eliminates setup friction — no need to manage hosting, environments, or credentials. Everything happens natively within GitHub.

## 2. Real-Time Editing and Component Adjustment

**What to show:** Spark's **point-and-edit** experience. Demonstrates control and flexibility — PMs or engineers can refine UI and logic visually or through conversational edits.  

1. Click **"Select Element to Edit"** (top right, the cursor icon)

    ![Select Element to Edit interface](images/spark-select-element-to-edit.png)

2. Click into the main area - mention that these edits can be manual via theme edit buttons or via Copilot Chat and natural language:

3. Insert the following prompt:

    ```txt
    Add icons to the status badges which represent the current state.
    ```

> [!TIP]
> Show the **mobile preview** toggle — Spark auto-optimizes layouts and lets you test responsive design instantly.

## 3. Export and Open in Codespaces

> [!NOTE]
> If you prefer to not create a repository, you can also just go ahead and show the statically created repository located at https://github.com/octodemo/od-octocat-supply-order-tracking-prototype. Please do not make any changes to this repository as it is a common resource shared by all demo instances.

**What to show:** Transition from prototype to repository. Demonstrates how Spark fits naturally into GitHub’s developer workflow once ideas are validated.

1. Click **"Create Repository.”**
2. Show the full repo structure automatically generated — frontend, backend, schema, and configuration.
3. Click **“Open Codespace”** to open the Spark-generated app in a full dev environment.
4. From here, developers can extend logic, integrate APIs, etc.

> [!TIP]
> Reinforce that Spark isn’t a sandbox — it’s a **real, deployable full-stack app** built on the same GitHub Actions and infra developers already trust.

### Alternative: Use Existing Repository

## 4. Seamless Collaboration and Shareable Link

**What to show:** How Spark prototypes are **instantly shareable** and collaborative. Demonstrates early stakeholder alignment and real-time iteration.

1. Click **Publish** and adjust visibility controls
2. Highlight that Spark runs on secure environments in Azure — nothing to install or maintain.
3. (optional) Use the example published app in the About section of <https://github.com/octodemo-framework/content_octocat_supply_order_tracking_prototype>

> [!NOTE]
> Collaboration stays native to GitHub — PMs, engineers, and designers all iterate together without switching tools.
>

## 5. (optional) Use Prototype to draft a specification for main app, OctoCAT Supply

> [!IMPORTANT]
> You will need an existing OctoCAT Supply demo instance repository to demonstrate this step.

**What to show:** How the Spark-generated repository can be used to draft a detailed specification for implementing it in the main application (OctoCAT Supply), showcasing how Product Managers can also leverage Spark for existing applications.

1. Open Copilot Chat (<https://github.com/copilot>)

2. Use the following prompt to link the prototype to the main app and have Copilot draft a specification issue:

    ```txt
      Generate a plan to integrate the prototype I've built in @octodemo/od-octocat-supply-order-tracking-prototype into our main application at @octodemo/octocat_supply-musical-parakeet

      Capture the main use-cases and requirements from the prototype and create a sophisticated specification in an issue for the target repository that is ready for implementation. 

      Make sure to capture the flow and design of the prototype. Also, add the necessary model-data and required API changes in the target app.

      Finally, put in a link to the prototype repo for the developer who works on it so they have a reference implementation, but make the plan scoped to our main repo.
    ```

    This should automatically include the link to the repositories.  Alternatively, replace the static prototype repo in the prompt with the one you've created out of spark.

3. Create the issue in the main application repository.

> [!TIP]
> **Combine demos:** You can easily combine this last step with a CCA Agent Demo by assigning the issue to it, or switch to VSCode and use the MCP Server to retrieve the issue and let Agent Mode implement it.

---

## Demo Wrap-Up

### Key takeaway

GitHub Spark is the **fastest way to turn ideas into deployed, full-stack applications**, bridging the gap between product vision and engineering execution.  

**GitHub as the AI-native developer platform** — bringing **prototyping, iteration, collaboration, and deployment** into one seamless developer experience.

### Core Value Recap

| Value                     | Impact                                            |
| ------------------------- | ------------------------------------------------- |
| Rapid Iteration           | Edit prompts or components and see changes live   |
| Seamless Deployment       | Infra handled automatically — ready in seconds    |
| Collaborative Development | PMs + engineers co-create in one workflow         |
| Mobile Testing            | Built-in responsiveness and preview tools         |
| Exportability             | Full repo export and Codespaces-ready             |
| Early Validation          | Share instantly, collect feedback, iterate faster |

---
