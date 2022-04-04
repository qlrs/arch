#!/bin/sh

selection=$(printf 'stallmanwasright
mousereview
livestreamfail
bash
onions
tor
commandline
thinkpad
cyberpunk
privacyguides
privacy
destiny
linux
archlinux
voidlinux' | dmenu -i -l 20)

url="https://teddit.net/r/$selection"

[ -z "$selection" ] && { notify-send "Nothing selected..." ; exit ;}

#torornot=$(printf "Yes\nNo" | dmenu -i -l 2 -p "Would you like to use tor browser?")

#if [ "$torornot" = "Yes" ]; then
#    /home/dan/.local/share/torbrowser/tbb/x86_64/tor-browser_en-US/Browser/start-tor-browser "$url" &
#elif [ "$(pgrep $BROWSER)" ]; then
#    $BROWSER "$url" &
#else
#    qutebrowser "$url" &
#fi
notify-send "Opening r/$selection"
"$BROWSER" "$url"
