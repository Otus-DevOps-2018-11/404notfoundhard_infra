#!/bin/bash
git clone -b monolith https://github.com/express42/reddit.git /opt/reddit
cd /opt/reddit/
bundle install


cat <<EOF> /etc/systemd/system/puma.service
[Unit]
Description=Simple HTTP service
Requires=mongod.service
After=mongod.service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/puma -d --dir /opt/reddit
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

systemctl enable puma.service
systemctl start puma.service