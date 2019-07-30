#!/usr/bin/env bash

date > /config/current_external_ip.txt
curl ifconfig.co > /config/current_external_ip.txt