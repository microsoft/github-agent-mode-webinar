# Code Injection Vulnerability Demo

This prompt demonstrates how to introduce a Code injection vulnerability into the Delivery API for demonstration purposes. **WARNING: This creates an intentional security vulnerability that should NEVER be used in production code.**

## Overview

We are going to add a new logic block that is supposed to show how a command can be exected when updating the status of a delivery. This execution will be vulnerable to exploitation, allowing an attacker to inject arbitrary code into the application.

### New Branch

First create a new branch for the vulnerable implementation, called `code-injection-demo`. If this branch exists, create a new one with a different name like `code-injection-demo-1` or similar.

```bash
git checkout -b <branch_name>
```

### Create a Vulnerable Block

Update the 

```typescript
// Update api/src/routes/delivery.ts, replacing the existing router.put('/:id/status') method

router.put('/:id/status', async (req, res, next) => {
  try {
    const { status, notifyCommand } = req.body;
    const repo = await getDeliveriesRepository();
    const delivery = await repo.findById(parseInt(req.params.id));

    if (delivery) {
      const updatedDelivery = await repo.updateStatus(parseInt(req.params.id), status);

      if (notifyCommand) {
        exec(notifyCommand, (error, stdout, stderr) => {
          if (error) {
            console.error(`Error executing command: ${error}`);
            return res.status(500).json({ error: error.message });
          }
          res.json({ delivery: updatedDelivery, commandOutput: stdout });
        });
      } else {
        res.json(updatedDelivery);
      }
    } else {
      res.status(404).send('Delivery not found');
    }
  } catch (error) {
    if (error instanceof NotFoundError) {
      res.status(404).send('Delivery not found');
    } else {
      next(error);
    }
  }
});
```

**This vulnerability is for educational purposes only. Never deploy code with Code injection vulnerabilities to production.**

### Push and Create a PR

```bash
git add .
git commit -m "Add Code injection vulnerability for demo"
git push origin <branch_name>
```

Then, create a pull request (PR) from the `<branch_name>` branch to the main branch in the GitHub repository.