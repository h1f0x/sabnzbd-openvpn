#!/usr/bin/env bash

# Restarting Services if dead
systemctl is-active --quiet openvpn-own-client.service || systemctl restart openvpn-own-client.service
systemctl is-active --quiet sabnzbd.service || systemctl restart sabnzbd.service