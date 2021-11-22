#!/bin/sh

gettraffic() {
    oldrec="$(cat /sys/class/net/"$1"/statistics/rx_bytes)"
    oldtrans="$(cat /sys/class/net/"$1"/statistics/tx_bytes)"
    sleep 1
    newrec="$(cat /sys/class/net/"$1"/statistics/rx_bytes)"
    newtrans="$(cat /sys/class/net/"$1"/statistics/tx_bytes)"

    rawrec=$((newrec - oldrec))
    rawtrans=$((newtrans - oldtrans))

    rec="$(echo "$rawrec" | numfmt --to=iec)"
    trans="$(echo "$rawtrans" | numfmt --to=iec)"
    echo "🔻 $rec 🔺 $trans"
}

#[ "$(mcli device status | grep "tun0")" ] && gettraffic "tun0"
nmcli device status | grep -q 'tun0' && gettraffic "tun0" || gettraffic "enp0s31f6"
