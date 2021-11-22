#!/bin/sh
# TODO 
# Add all possible conditions

curl -s https://wttr.in/Myrtle_Beach\?format=j1 > /tmp/weather_forecast

getforecast() {
    temp="$(jq -r ."current_condition[0].temp_F" /tmp/weather_forecast)"
    condition="$(jq -r ."current_condition[0]|.weatherDesc[0]|.value" /tmp/weather_forecast)"
    curl "http://wttr.in/Myrtle_Beach?u" > "$HOME/.cache/weatherforcast"
}

displayforecast () {
    case $condition in
        "Partly cloudy") icon="⛅";;
        Sunny) icon="☀️";;
        Cloudy) icon="☁️";;
        Rainy) icon="🌧️";;
        *) icon="☀️";;
    esac
    echo "$icon $temp℉ "
}

case $BLOCK_BUTTON in
    1) "$BROWSER" "https://forecast.weather.gov/MapClick.php?CityName=Myrtle+Beach&state=SC&site=ILM&textField1=33.6988&textField2=-78.8922" ;;
    3) "$TERMINAL" --hold -e cat "$HOME/.cache/weatherforcast" ;;
esac

getforecast
displayforecast
