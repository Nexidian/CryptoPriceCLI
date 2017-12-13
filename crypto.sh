#!/bin/bash

# Add full ticker name here if you want to add more
declare -a tickers=("bitcoin" "iota" "ethereum" "litecoin" "electroneum")

function fprint {
    INFO="$(wget -qO- https://api.coinmarketcap.com/v1/ticker/${1}/ | jq -r '.[0].price_usd +" "+ .[0].percent_change_24h')"
    arr=($INFO)
    if [[ ${arr[1]} =~ ^- ]] ; then
         printf "${1^}: \$${arr[0]} \x1b[31m${arr[1]}%%\x1b[0m \n"
    else
         printf "${1^}: \$${arr[0]} \x1b[32m${arr[1]}%%\x1b[0m \n"
    fi
}

printf "\n"
for ticker in "${tickers[@]}"
do
    fprint "$ticker"
done
printf "\n"
