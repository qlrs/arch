#!/bin/sh

# needs 'https://' in front
thread=$(curl "$1" | grep -o 'i\.4cdn\.org\/wg\/[[:digit:]]*\.\(jpg\|png\|jpeg\)')

firefox "https://$thread"
