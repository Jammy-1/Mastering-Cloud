#!/bin/bash
set -e

# Log Setup
LOG_FILE="/var/log/update_site.log"
exec > "$LOG_FILE" 2>&1

log() {
  echo "$(date --iso-8601=seconds) | update_site | $1"
}

log "Starting web content update"

# Config
REPO_DIR="/opt/myrepo"
WEB_ROOT="/var/www/html"
PROJECT_PATH="1.Projects/Azure-VMSS-Web-Multi-Region-MultiAZ/Static Site"

# Repo Sync
if [ ! -d "$REPO_DIR" ]; then
  log "Repository not found, cloning from GitHub"
  git clone "${GITHUB_REPO}" "$REPO_DIR"
else
  log "Repository exists, pulling latest changes"
fi

cd "$REPO_DIR"

git fetch origin "${GITHUB_BRANCH}"
git reset --hard "origin/${GITHUB_BRANCH}"

log "Repository synced to latest commit"

# Deploy Site
cp "$REPO_DIR/$PROJECT_PATH/index.html" "$WEB_ROOT/"
cp "$REPO_DIR/$PROJECT_PATH/styles.css" "$WEB_ROOT/"

log "Static files copied to web root"

chown -R www-data:www-data "$WEB_ROOT"
chmod -R 755 "$WEB_ROOT"

# Service Restart 
systemctl restart apache2
log "Apache restarted successfully"

log "Web content update completed successfully"
