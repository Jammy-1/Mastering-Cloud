#!/usr/bin/env bash

set -euo pipefail

echo "⚠️  This will DELETE ALL GitHub Actions workflow runs for a repository."
echo

# Ask for repo URL
read -rp "Enter GitHub repo URL (e.g. https://github.com/OWNER/REPO): " REPO_URL

# Extract owner and repo
OWNER=$(echo "$REPO_URL" | awk -F/ '{print $(NF-1)}')
REPO=$(echo "$REPO_URL" | awk -F/ '{print $NF}')

if [[ -z "$OWNER" || -z "$REPO" ]]; then
  echo "❌ Failed to parse OWNER/REPO from URL"
  exit 1
fi

echo
echo "Repository detected:"
echo "  Owner: $OWNER"
echo "  Repo : $REPO"
echo

# Confirm
read -rp "Type 'DELETE' to continue: " CONFIRM
if [[ "$CONFIRM" != "DELETE" ]]; then
  echo "❌ Aborted"
  exit 0
fi

echo
echo "🔍 Fetching workflow runs..."

COUNT=0

gh api --method GET "repos/$OWNER/$REPO/actions/runs" --paginate \
  --jq '.workflow_runs[].id' |
while read -r ID; do
  COUNT=$((COUNT+1))
  echo "🗑️  Deleting workflow run ID: $ID"
  gh api --method DELETE "repos/$OWNER/$REPO/actions/runs/$ID"
done

echo
echo "✅ Cleanup complete"
