#!/bin/sh

price() {
    coin=$1
    price=$(curl -s rate.sx/"$coin" | awk '/end/ {print $8}')
    echo "$price"
}

echo "💲 BTC: $(price btc)"

case $BLOCK_BUTTON in
    1) "$BROWSER" 'http://rate.sx/btc' ;;
esac
