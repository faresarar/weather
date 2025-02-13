import 'package:flutter/material.dart';

import '../widgets/weather_data_tile.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/haze.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Entre city Name",
                      suffixIcon: Icon(
                        Icons.search,
                      ),
                      filled: true,
                      fillColor: Colors.black26,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on),
              Text(
                "Pune",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 50),
              Text(
                "30.9°c",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 90,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Haze',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/haze.png',
                    height: 180,
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.arrow_upward,
                  ),
                  Text(
                    '35°c',
                    style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_downward,
                  ),
                  Text(
                    '25°c',
                    style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Card(
                elevation: 5,
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      spacing: 15,
                      children: [
                        WeatherDataTile(
                          index1: 'Sunrise',
                          index2: 'Sunset',
                          value1: '6:15 AM',
                          value2: '6:30 PM',
                        ),
                        WeatherDataTile(
                          index1: 'Humidity',
                          index2: 'Visiblity',
                          value1: '4',
                          value2: '1000',
                        ),
                        WeatherDataTile(
                          index1: 'Precipitation',
                          index2: 'Wind speed',
                          value1: '6',
                          value2: '45',
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
