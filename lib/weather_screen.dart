import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            //main card
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Column(
                  children: [
                    Text(
                      '300 K',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.cloud,
                      size: 64,
                    ),
                    Text(
                      'Rain',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),

            //weather forecast cards
            Placeholder(
              fallbackHeight: 150,
            ),

            SizedBox(
              height: 25,
            ),

            //additionl info
            Placeholder(
              fallbackHeight: 150,
            ),
          ],
        ),
      ),
    );
  }
}
