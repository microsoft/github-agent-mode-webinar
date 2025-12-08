#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

feature_name=$1
branch_name=$2
create_branch=$3

if [[ -z $feature_name ]]; then
  echo "Missing feature name from the command line parameters."
  exit 1
fi

feature_pack_tarball=${DIR}/${feature_name}/patches.tgz

# Switch to the new branch if branch name is provided and create_branch is set to Yes
if [[ -n $branch_name && $create_branch == "Yes" ]]; then
  echo "Switching to new branch: ${branch_name}"
  git checkout -b ${branch_name}
fi

# Apply code changes
echo "Applying code changes..."
pushd $DIR/../..
tar -xzf ${feature_pack_tarball}
popd

echo "Completed."
