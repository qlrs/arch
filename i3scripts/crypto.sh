#!/bin/sh


price() {
    coin="$1"
    price="$(curl -s rate.sx/$coin | awk '/end/ {print $8}')"
    echo $price
}


echo "💲 $(price eth) 💲 $(price btc)"
