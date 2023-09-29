#!/bin/sh

vpn=$(nmcli device status | grep -i "tun0")

if [ -z "$vpn" ]; then
  echo "⚠️ no VPN"
  else
    echo "⬆️ VPN"
fi
