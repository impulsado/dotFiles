#!/bin/bash

if [ $(dpkg-query -W -f='${Status}' nano 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install openssh-server;
fi

systemctl enable ssh
systemctl stop ssh

cat <<EOF > /etc/ssh/sshd_config
# === NEW SSH CONFIGURATION ===
# Protocolo 1 is older and less secure
Protocol 2
# Limit passwords attempts
MaxAuthTries 3
# Disable root login
PermitRootLogin no
# Disable empty passwords to login
PermitEmptyPasswords no
# Disable X11 Forwarding
X11Forwarding no
# Period of time before client gets disconnected (Seconds)
ClientAliveInterval 15
# Server waiting time after a connection request is made (Seconds)
LoginGraceTime 20
EOF

systemctl start ssh