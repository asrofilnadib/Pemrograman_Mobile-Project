import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_api/model/weather_model.dart';
import 'package:weather_api/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('ec88ae5c90cbe744566c941903bcc677');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await "London";

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/cerah.json';

    switch (mainCondition.toLowerCase()) {
      case 'cloud':
      case 'mist':
        return 'assets/cerah berawan.json';
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'rain':
      case 'drizzle':
      case 'sunny rain':
        return 'assets/cerah hujan.json';
      case 'drizzle':
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      default:
        return 'assets/cerah.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _weather == null
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 55),
            Text(
              _weather!.cityName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Lottie.asset(
                  getWeatherAnimation(_weather!.mainCondition),
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Text(
              _weather!.mainCondition,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${_weather!.temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}