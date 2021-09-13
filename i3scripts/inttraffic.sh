#!/bin/bash

#need to change interface you are grepping for
if [ "$(nmcli device status | grep -i "tun0")" ]; then
    nowrec=$(cat /sys/class/net/tun0/statistics/rx_bytes) #change for vpn
    nowtrans=$(cat /sys/class/net/tun0/statistics/tx_bytes)
    sleep 1
    thenrec=$(cat /sys/class/net/tun0/statistics/rx_bytes)
    thentrans=$(cat /sys/class/net/tun0/statistics/tx_bytes)

    rawrec=$(("$thenrec" - "$nowrec"))
    forrec=$(numfmt --to=iec "$rawrec")

    rawtrans=$(("$thentrans" - "$nowtrans"))
    fortrans=$(numfmt --to=iec "$rawtrans")
    echo "🔻 "$forrec" 🔺 "$fortrans""
else
    nowrec=$(cat /sys/class/net/enp0s31f6/statistics/rx_bytes) #change int for no vpn
    nowtrans=$(cat /sys/class/net/enp0s31f6/statistics/tx_bytes)
    sleep 1
    thenrec=$(cat /sys/class/net/enp0s31f6/statistics/rx_bytes)
    thentrans=$(cat /sys/class/net/enp0s31f6/statistics/tx_bytes)

    rawrec=$(("$thenrec" - "$nowrec"))
    forrec=$( numfmt --to=iec "$rawrec")

    rawtrans=$(("$thentrans" - "$nowtrans"))
    fortrans=$(numfmt --to=iec "$rawtrans")
    echo "🔻 "$forrec" 🔺 "$fortrans""
fi

case $BLOCK_BUTTON in
    1) setsid -f "$TERMINAL" -e nmtui ;;
esac