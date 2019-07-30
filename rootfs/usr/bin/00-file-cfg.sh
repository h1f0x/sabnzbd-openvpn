#!/usr/bin/env bash

# OpenVPN
mkdir -p /config/vpn
if [ ! -f /config/vpn/client.conf ]; then
    cp -r /defaults/config/vpn/client.conf /config/vpn/client.conf
fi

if [ ! -f /config/vpn/vpn.auth ]; then
    cp -r /defaults/config/vpn/vpn.auth /config/vpn/vpn.auth
fi

# sabnzbd
mkdir -p /config/sabnzbd
if [ ! -f /config/sabnzbd/config.ini ]; then
    cp -r /defaults/config/sabnzbd/config.ini /config/sabnzbd/config.ini
fi
