import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

const numberOfHourlyForecastCardsToBeDisplayed = 5;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Hyderabad,IN';
      final result = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'),
      );

      final data = jsonDecode(result.body);

      if (data['cod'] != '200') throw 'An unexpected error occured';
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];

          //main card entries
          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];

          //additional info entries
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentPressure = currentWeatherData['main']['pressure'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp K',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                currentSky,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                //weather forecast cards
                const Text(
                  'Hourly Forecast',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: numberOfHourlyForecastCardsToBeDisplayed,
                    itemBuilder: (context, index) {
                      final hourlyForecast = data['list'][index + 1];

                      final hourlyTime = hourlyForecast['dt'];
                      final hourlySky = hourlyForecast['weather'][0]['main'];
                      final hourlyTemp = hourlyForecast['main']['temp'];

                      return HourlyForecastItem(
                        timestamp: '$hourlyTime',
                        icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                            ? Icons.cloud
                            : Icons.sunny,
                        value: '$hourlyTemp',
                      );
                    },
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                //additionl info
                const Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: '$currentHumidity',
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: '$currentWindSpeed',
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: '$currentPressure',
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
