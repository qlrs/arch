#!/bin/sh

price=$(curl -s https://query1.finance.yahoo.com/v7/finance/quote\?symbols\=amd | sed 's/,/\n/g' | grep "regularMarketPrice" | cut -d ':' -f2)
printf "💲AMD: %.05s\n" "$price"

# case $BLOCK_BUTTON in
#     1) "$TERMINAL" -e mop ;;
# esac
