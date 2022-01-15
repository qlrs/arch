#!/bin/sh

price() {
    coin=$1
    price=$(curl -s rate.sx/"$coin" | awk '/end/ {print $8}')
    echo "$price"
}

echo "💲 ETH: $(price eth) 💲 BTC: $(price btc)"

case $BLOCK_BUTTON in
    1) firefox 'http://rate.sx/eth' 'http://rate.sx/btc' ;;
esac
