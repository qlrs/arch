#!/usr/bin/env python
import json
import requests

url = "https://api.weather.gov/gridpoints/ILM/55,39/forecast/hourly"
forecast = requests.get(url).json()


def get_emoji(short_forecast):
    if short_forecast == "Mostly Sunny":
        emoji = "⛅"
    elif short_forecast in ["Sunny", "Clear"]:
        emoji = "☀️"
    elif short_forecast == "Mostly Cloudy":
        emoji = "☁️"
    elif short_forecast == "Cloudy":
        emoji = "🌥️"
    elif short_forecast == "Partly Cloudy":
        emoji = "⛅"
    elif short_forecast == "Mostly Clear":
        emoji = "🌤️  "
    elif short_forecast == "Chance Rain Showers" or short_forecast == "Rain Showers":
        emoji = "🌧️ "
    elif "Thunderstorms" in short_forecast:
        emoji = "⛈️  "
    else:
        emoji = "😎 "
    return emoji


temp = forecast["properties"]["periods"][0]["temperature"]
short = forecast["properties"]["periods"][0]["shortForecast"]
emoji = get_emoji(short)
print(f"{emoji}{temp}°F")
