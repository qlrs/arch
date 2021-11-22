#!/bin/sh

vpn=$(nmcli device status | grep -i "tun0")

[ -z "$vpn" ] && echo "⚠️ no VPN" || echo "✅ VPN"
