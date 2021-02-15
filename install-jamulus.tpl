#!/bin/bash

sudo adduser --system jamulus

sudo cat <<EOF > /etc/systemd/system/jamulus@.service
[Unit]
Description=Jamulus-Server%i
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
ExecStart=/usr/local/bin/start_jamulus.sh %i

Restart=on-failure
RestartSec=30
StandardOutput=journal
StandardError=inherit
SyslogIdentifier=jamulus

[Install]
WantedBy=multi-user.target
EOF

sudo cat <<EOF2 > /usr/local/bin/start_jamulus.sh
#!/bin/bash

number=\$${1}

if [ \$${number} == 1 ]; then
    JAMULUS_CENTRAL="localhost"
else
   JAMULUS_CENTRAL=`curl -s http://169.254.169.254/latest/meta-data/public-hostname`
fi

PUBLIC_IP=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`

JAMULUS_PORT=\`expr \$${number} + 22123\`

/usr/local/bin/Jamulus --server --nogui --fastupdate --multithreading --norecord \
    --port \$${JAMULUS_PORT} \
    --numchannels ${jamulus_max_users} \
    --welcomemessage "${jamulus_hello_text} \$${number}" \
    --centralserver "\$${JAMULUS_CENTRAL}" \
    --serverpublicip "\$${PUBLIC_IP}" \
    --serverinfo "${jamulus_hello_text} \$${number};${jamulus_city};${jamulus_country}"
EOF2



sudo apt-get update
sudo apt-get install -y build-essential qt5-qmake qtdeclarative5-dev qt5-default qttools5-dev-tools linux-lowlatency-hwe-20.04

cd /tmp

wget https://github.com/corrados/jamulus/tarball/${jamulus_version} -O ${jamulus_version}.tar.gz
tar -xvf ${jamulus_version}.tar.gz
cd jamulussoftware-jamulus-${jamulus_version}

qmake "CONFIG+=nosound headless" Jamulus.pro
make clean
make

sudo make install



sudo systemctl daemon-reload

sudo chmod 644 /etc/systemd/system/jamulus@.service
sudo chmod a+rx /usr/local/bin/start_jamulus.sh


for number in {1..${jamulus_rooms}}
do
    sudo systemctl enable jamulus@$number
done

sudo reboot 0
