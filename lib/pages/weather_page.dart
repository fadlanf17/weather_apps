import 'package:flutter/material.dart';
import 'package:weather_apps/models/weather_model.dart';
import 'package:weather_apps/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('6a3b7a439c8108a3ebd66f2be86489c4');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    //get current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  // weather animation

  // init state
  @override
  void initState() {
    super.initState();
    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // city name
              Text(_weather?.cityName ?? "loading city..."),
              // temperature
              Text('${_weather?.temperature.round()}°C')
            ],
          ),
        ),
      ),
    );
  }
}
