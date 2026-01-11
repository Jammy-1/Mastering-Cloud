#!/bin/bash
set -e

# Config
REPO_URL="https://github.com/Jammy-1/Azure-VMSS-Web-Multi-Region-MultiAZ.git"
BRANCH="main"
SITE_PATH="/opt/myrepo"
WEB_ROOT="/var/www/html"
PROJECT_PATH="Static-Site"

# Logging
LOG_DIR="/var/log/site_update"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/update_$(hostname)_$(date +'%Y%m%d_%H%M%S').log"

exec > >(tee -a "$LOG_FILE") 2>&1

# Deployment Start
echo "Started on $(hostname) at $(date)"

# Update Packages
apt-get update -y
apt-get install -y apache2 git

# Update Repo
if [ -d "$SITE_PATH/.git" ]; then
    echo "Updating existing repo at $SITE_PATH"
    cd "$SITE_PATH"
    git fetch origin
    git reset --hard origin/$BRANCH
else
    echo "Cloning repo into $SITE_PATH"
    rm -rf "$SITE_PATH"
    git clone --branch "$BRANCH" --depth 1 "$REPO_URL" "$SITE_PATH"
fi

# Deploy Site Files
echo "Deploying site files to $WEB_ROOT"
rm -rf "$WEB_ROOT"/*
cp "$SITE_PATH/$PROJECT_PATH/index.html" "$WEB_ROOT/"
cp "$SITE_PATH/$PROJECT_PATH/styles.css" "$WEB_ROOT/"

# Set Permissons
echo "Setting permissions for $WEB_ROOT"
chown -R www-data:www-data "$WEB_ROOT"
chmod -R 755 "$WEB_ROOT"

# Restart Apache
echo "Restarting Apache..."
systemctl restart apache2

echo "Update complete on $(hostname) at $(date)"
echo "Log saved to $LOG_FILE"
