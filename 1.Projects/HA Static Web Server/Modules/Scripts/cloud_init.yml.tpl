package_update: true
packages:
  - apache2
  - git

runcmd:
  # Update
  - [bash, -c, "apt-get update -y && apt-get upgrade -y"]
  # Start Apache
  - [bash, -c, "systemctl enable apache2 && systemctl start apache2"]

  - [
      bash,
      -c,
      "mkdir -p /var/www/html && cd /var/www/html && \
      git clone --depth 1 '${GITHUB_REPO}' site || \
      (cd site && git pull origin '${GITHUB_BRANCH}')",
    ]

  - [
      bash,
      -c,
      "cp -r /var/www/html/site/* /var/www/html/ && systemctl restart apache2",
    ]

final_message: "Web server is configured and running!"
