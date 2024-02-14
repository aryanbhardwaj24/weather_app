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
      body: Column(
        children: [
          //main card
          Container(
            width: double.infinity,
            child: const Card(
              child: Column(
                children: [
                  Text(
                    '300 K',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
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
    );
  }
}
