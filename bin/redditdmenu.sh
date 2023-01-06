#!/bin/sh

selection=$(printf 'bash
commandline
thinkpad
cyberpunk
privacyguides
privacy
linux
archlinux
openbsd
tor
voidlinux' | dmenu -i -l 20)

url="https://libreddit.de/r/$selection"

[ -z "$selection" ] && { notify-send "Nothing selected..." ; exit ;}

#torornot=$(printf "Yes\nNo" | dmenu -i -l 2 -p "Would you like to use tor browser?")

#if [ "$torornot" = "Yes" ]; then
#    /home/dan/.local/share/torbrowser/tbb/x86_64/tor-browser_en-US/Browser/start-tor-browser "$url" &
#elif [ "$(pgrep $BROWSER)" ]; then
#    $BROWSER "$url" &
#else
#    qutebrowser "$url" &
#fi
"$BROWSER" "$url"
