#!/bin/bash

price=$(curl -s https://query1.finance.yahoo.com/v7/finance/quote\?symbols\=amd | sed 's/,/\n/g' | grep "regularMarketPrice" | cut -d ':' -f2)
echo "💲AMD: $price"

case $BLOCK_BUTTON in
    1) "$TERMINAL" -e mop ;;
esac

