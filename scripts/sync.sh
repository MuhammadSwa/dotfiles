#!/bin/bash

# Define the path to your Git repository
REPO_PATH="/media/Maind/MyVault"
# Define the path for the log file
LOG_FILE="/var/log/auto_git_sync.log"
# Get the current date and time for commit messages and logs
DATE=$(date +"%Y-%m-%d %H:%M:%S")

# Redirect all standard output and standard error to the log file,
# and also display it on the console if run manually (using tee).
exec > >(tee -a "$LOG_FILE") 2>&1

echo "--- Git Sync Started at $DATE ---"

# Navigate to the repository directory
cd "$REPO_PATH" || {
  echo "Error: Could not change directory to $REPO_PATH. Exiting."
  exit 1
}

# Check if there are any changes (staged or unstaged)
# git diff --quiet checks unstaged changes
# git diff --cached --quiet checks staged changes
if git diff --quiet && git diff --cached --quiet; then
  echo "No changes detected. Nothing to commit."
else
  echo "Changes detected. Adding, committing, and pushing..."

  # Add all changes (new files, modified files, deleted files)
  git add .
  if [ $? -ne 0 ]; then
    echo "Error: git add failed."
    exit 1
  fi

  # Commit the changes with a timestamped message
  # The --allow-empty-message and --no-verify flags are generally not recommended
  # for production, but can be used if you want to force a commit even if there are
  # no changes after 'git add' or bypass pre-commit hooks.
  # For this automated script, we assume 'git add .' will stage relevant changes.
  git commit -m "Automated commit on $DATE"
  if [ $? -ne 0 ]; then
    echo "Error: git commit failed. This might happen if there were no actual changes to commit after 'git add'."
    # In some cases, 'git add .' might not stage anything new if only untracked files were added.
    # If you want to ensure a commit happens even if nothing changed, you might add --allow-empty.
    # For now, we'll exit on commit failure.
    exit 1
  fi

  # Push the committed changes to the 'main' branch of the 'origin' remote
  # Ensure your Git credentials (e.g., SSH keys) are properly set up for passwordless push.
  git push origin main
  if [ $? -ne 0 ]; then
    echo "Error: git push failed. Check network connectivity, remote repository status, or Git credentials."
    exit 1
  fi
  echo "Git operations completed successfully."
fi

echo "--- Git Sync Finished at $DATE ---"
echo "" # Add a blank line for better log readability
