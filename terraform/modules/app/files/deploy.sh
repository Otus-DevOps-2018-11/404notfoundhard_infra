#!/bin/bash
set -e

url_database=$1

cat << EOF > /tmp/puma.service
[Unit]
Description=Puma HTTP Server
After=network.target

[Service]
Type=simple
Environment="DATABASE_URL=${url_database}"
User=gcp_appUser
WorkingDirectory=/home/gcp_appUser/reddit
ExecStart=/bin/bash -lc 'puma'
Restart=always

[Install]
WantedBy=multi-user.target
EOF

APP_DIR=$HOME

git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install

sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
