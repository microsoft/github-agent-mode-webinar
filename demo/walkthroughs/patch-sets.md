# Patch Sets: A way to be fake-live Coding Demos

There are a bunch of "live-coding-demos" included in this platform demo. Most of them work by applying what we call a "patch-set" - essentially, that is just a zipped up file that will get extracted to a certain location, so you can just fast-forward changes easily without having to actually live-code them.

## Applying a Patch-Set

1. In VSCode, open the Command Palette
2. Search for `Task: Run Task` and hit Enter
3. Select the patch you want to apply from the presented list
4. The Patch-Set will ask you wether to create the new files in a new Branch:
    1. `Yes`: It will create a branch using `git checkout -b` - great if you want or need to quickly create a PR
    2. `No`: It will just unwrap it in the current branch. Great if you already have a branch created in your demo flow

> [!WARNING]
> Patch sets are just tar-gzipped files of this repository. Once unwrapped, they will just overwrite the included files, so any changes you might have done during your demo to targeted files will be lost. This won't be an issue in most cases, as you usually wouldn't have changed those files anyways, but something to be aware of.

## Creating a new Patch-Set

If you want to contribute to the demo and add a new patch-set, follow these steps:

1. Make the changes or create the files you want to have as part of the Patch-Set
2. From the root-directory, do `tar -czf <path-to-file-1> <path-to-file-2>`, for example `tar -czf .github/copilot-instructions.md ./frontend/index.html`
3. In [demo/resources], create a new folder with a good name of your patch set (look at the existing ones for inspiration)
4. Place the generated `patch.tgz` in there
5. Navigate to [.vscode/tasks.json](../../.vscode/tasks.json) and copy one of the existing tasks into a new one into the array
6. Overwrite the `label` with the name of your demoed feature
7. Overwrite the `args` in the following order:
    1. First argument: `Folder-Name`: This is the name of the folder you've selected in Step 3
    2. Second argument: `Branch-Name`: If you want a new branch to be created if the user selected `Yes`, this is where the default branch name goes. You can leave this empty if you place `No` into the third argument
    3. Third argument: If you want the user to be prompted wether to create a new branch for those changes, then put in `${input:NEW_BRANCH}` here. Else, set it to `No`
