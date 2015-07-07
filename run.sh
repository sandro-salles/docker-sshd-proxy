#!/bin/bash

mkdir /var/run/sshd
mkdir -p /root/.ssh
chmod 700 /root/.ssh
mv /app/authorized_keys /root/.ssh/.
chmod 600 /root/.ssh/*
chown -Rf root:root /root/.ssh

# configure sshd to block authentication via password
sed -i.bak 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
rm /etc/ssh/sshd_config.bak



if [ "${AUTHORIZED_KEYS}" != "**None**" ]; then
    echo "=> Found authorized keys"
    IFS=$'\n'
    arr=$(echo ${AUTHORIZED_KEYS} | tr "," "\n")
    for x in $arr
    do
        x=$(echo $x | sed -e 's/^ *//' -e 's/ *$//')
        cat /app/authorized_keys.tmpl | grep "$x" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "=> Adding public key to authorized_keys.tmpl: $x"
            echo "$x" >> /app/authorized_keys.tmpl
        fi
    done
else
    echo "ERROR: No authorized keys found in \$AUTHORIZED_KEYS"
    exit 1
fi

exec supervisord -c /etc/supervisor/conf.d/supervisord.conf -n
