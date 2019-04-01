#!/usr/bin/env bash

mkdir -p /output/incomplete
mkdir -p /output/complete
mkdir -p /config/sabnzbd/watch
mkdir -p /config/sabnzbd/admin
mkdir -p /config/sabnzbd/nzb_backup
mkdir -p /config/sabnzbd/email
mkdir -p /config/sabnzbd/scripts
mkdir -p /config/vpn

# OpenVPN
if [ ! -f /config/vpn/client.conf ]; then
    cp -r /defaults/config/vpn/client.conf /config/vpn/client.conf
fi

if [ ! -f /config/vpn/vpn.auth ]; then
    cp -r /defaults/config/vpn/vpn.auth /config/vpn/vpn.auth
fi

# sabnzbd
if [ ! -f /config/sabnzbd/config.ini ]; then
    cp -r /defaults/config/sabnzbd/config.ini /config/sabnzbd/config.ini
fi


chown -R sabnzbd:sabnzbd /output
chown -R sabnzbd:sabnzbd /config/sabnzbd

chmod -R 755 /config/sabnzbd

systemctl restart sabnzbd.service