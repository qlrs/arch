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

url="https://old.reddit.com/r/$selection"

[ -z "$selection" ] && exit

"$BROWSER" "$url"
