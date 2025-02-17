#!/bin/sh

if nmcli connection show --active | grep -q 'tun'; then
  echo "⬆️ VPN"
else
  echo "⚠️ no VPN"
fi
