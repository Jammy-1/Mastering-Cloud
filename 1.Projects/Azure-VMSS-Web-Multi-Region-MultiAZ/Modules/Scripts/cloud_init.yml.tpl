#cloud-config
package_update: true
package_upgrade: true

packages:
  - apache2
  - git

runcmd:
  # Enable and start Apache
  - [bash, -c, "systemctl enable apache2 && systemctl start apache2"]

  # Remove default Apache files
  - [bash, -c, "rm -rf /var/www/html/*"]

  # Create a folder to clone the GitHub repo
  - [bash, -c, "mkdir -p /opt/myrepo"]

  # Clone the full GitHub repo into the new folder
  - [
      bash,
      -c,
      "git clone --branch ${GITHUB_BRANCH} --depth 1 ${GITHUB_REPO} /opt/myrepo",
    ]

  # Copy index.html and style.css to the web root
  - [bash, -c, "cp '/opt/myrepo/Static-Site/index.html' /var/www/html/"]
  - [bash, -c, "cp '/opt/myrepo/Static-Site/styles.css' /var/www/html/"]

  # Set correct permissions for Apache
  - [
      bash,
      -c,
      "chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html",
    ]

final_message: "Web Server Running"
