#!/bin/sh

curl -s https://api.weather.gov/gridpoints/ILM/57,39/forecast > /tmp/weather_forecast

getforecast() {
    temp=$(jq -r ."properties.periods[0].temperature" /tmp/weather_forecast)
    condition=$(jq -r ."properties.periods[0].shortForecast" /tmp/weather_forecast)
}
getforecast
echo "☀️ $temp℉ "

case $BLOCK_BUTTON in
    1) "$BROWSER" "https://forecast.weather.gov/MapClick.php?CityName=Myrtle+Beach&state=SC&site=ILM&textField1=33.6988&textField2=-78.8922" ;;
    3) notify-send $condition ;;
esac

