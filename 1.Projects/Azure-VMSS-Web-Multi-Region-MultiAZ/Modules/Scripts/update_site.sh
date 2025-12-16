#!/bin/bash
set -e

# Config
REPO_URL="https://github.com/Jammy-1/Mastering-Cloud.git"
BRANCH="main"
SITE_PATH="/opt/myrepo"
WEB_ROOT="/var/www/html"
PROJECT_PATH="1.Projects/Azure-VMSS-Web-Multi-Region-MultiAZ/Static Site"

# Logging
LOG_DIR="/var/log/site_update"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/update_$(hostname)_$(date +'%Y%m%d_%H%M%S').log"

exec > "$LOG_FILE" 2>&1

# Deployment Start
echo "=== Update started on $(hostname) at $(date) ==="

# Update Packages
apt-get update -y
apt-get install -y apache2 git

# Update Repo
if [ -d "$SITE_PATH/.git" ]; then
    cd "$SITE_PATH"
    git fetch origin
    git reset --hard origin/$BRANCH
else
    rm -rf "$SITE_PATH"
    git clone --branch "$BRANCH" --depth 1 "$REPO_URL" "$SITE_PATH"
fi

# Deploy Site Files
rm -rf "$WEB_ROOT"/*
cp "$SITE_PATH/$PROJECT_PATH/index.html" "$WEB_ROOT/"
cp "$SITE_PATH/$PROJECT_PATH/styles.css" "$WEB_ROOT/"

# Set Permissons
chown -R www-data:www-data "$WEB_ROOT"
chmod -R 755 "$WEB_ROOT"

# Restart Apache
systemctl restart apache2

echo "=== Update complete on $(hostname) at $(date) ==="
echo "Log saved to $LOG_FILE"
