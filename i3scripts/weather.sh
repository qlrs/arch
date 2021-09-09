#!/bin/sh
# TODO 
# Add all possible conditions

curl -s https://wttr.in/Myrtle_Beach\?format=j1 > /tmp/weather_forecast

temp="$(jq -r ."current_condition[0].temp_F" /tmp/weather_forecast)"
moonphase="$(jq -r ."weather[0]|.astronomy[0]|.moon_phase" /tmp/weather_forecast)"
condition="$(jq -r ."current_condition[0]|.weatherDesc[0]|.value" /tmp/weather_forecast)"

case $condition in
    "Partly cloudy") icon="⛅";;
    Sunny) icon="☀️";;
    Cloudy) icon="☁️";;
    Rainy) icon="🌧️";;
    *) icon="☀️";;
esac

[ "$(echo $moonphase | grep "Full Moon")" ] && echo "🌕 $icon $temp℉ " || echo "$icon $temp℉ "
