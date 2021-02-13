#!/bin/bash
sudo apt-get update
sudo apt-get install -y build-essential qt5-qmake qtdeclarative5-dev qt5-default qttools5-dev-tools linux-lowlatency-hwe-20.04

cd /tmp

wget https://github.com/corrados/jamulus/archive/latest.tar.gz
tar -xvf latest.tar.gz
cd jamulus-latest

qmake "CONFIG+=nosound headless" Jamulus.pro
make clean
make

sudo make install

sudo adduser --system --no-create-home jamulus

cat <<EOF > jamulus.service
[Unit]
Description=Jamulus-Server
After=network.target

[Service]
Type=simple
User=jamulus
Group=nogroup
NoNewPrivileges=true
ProtectSystem=true
ProtectHome=true
Nice=-20
IOSchedulingClass=realtime
IOSchedulingPriority=0

#### Change this to set genre, location and other parameters.
#### See [Command-Line-Options](Command-Line-Options) ####
ExecStart=/usr/local/bin/Jamulus -s -F -T -n --norecord --numchannels ${jamulus_max_users} --welcomemessage "Welcome to KottonKlub"

Restart=on-failure
RestartSec=30
StandardOutput=journal
StandardError=inherit
SyslogIdentifier=jamulus

[Install]
WantedBy=multi-user.target
EOF

sudo mv jamulus.service /etc/systemd/system/jamulus.service

sudo chmod 644 /etc/systemd/system/jamulus.service

sudo systemctl daemon-reload

sudo systemctl enable jamulus

sudo reboot 0
