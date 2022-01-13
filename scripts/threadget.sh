#!/bin/sh

for i in $(curl "$1" | grep -o 'i\.4cdn\.org\/wg\/[[:digit:]]*\.\(jpg\|png\|jpeg\)'); do
    wget -nc "$i" -P "$HOME/threadwalls"
done
