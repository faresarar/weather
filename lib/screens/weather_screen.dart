import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/weather_services.dart';
import '../widgets/weather_data_tile.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController searchController = TextEditingController();
  String bgImg = 'assets/images/clear.jpg';
  String iconImg = 'assets/images/clear.jpg';
  String cityName = '';
  String temperature = '';
  String tempMax = '';
  String tempMin = '';
  String sunrise = '';
  String sunset = '';
  String main = '';
  String pressure = '';
  String humidity = '';
  String visibility = '';
  String windSpeed = '';
  getData({required String cityName}) async {
    final weatherService = WeatherService();
    final weatherData = await weatherService.fetchWeather(cityName: cityName);
    debugPrint(weatherData.toString());
    setState(() {
      cityName = weatherData['name'];
      temperature = weatherData['main']['temp'].toStringAsFixed(1);
      main = weatherData['weather'][0]['main'];
      tempMax = weatherData['main']['temp_max'].toStringAsFixed(1);
      tempMin = weatherData['main']['temp_min'].toStringAsFixed(1);
      sunrise = DateFormat('hh:mm a').format(
          DateTime.fromMillisecondsSinceEpoch(
              weatherData['sys']['sunrise'] * 1000));
      sunset = DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(
          weatherData['sys']['sunset'] * 1000));
      pressure = weatherData['main']['pressure'].toString();
      humidity = weatherData['main']['humidity'].toString();
      visibility = weatherData['visibility'].toString();
      windSpeed = weatherData['wind']['speed'].toString();
      if (main == 'Clear') {
        bgImg = 'assets/images/clear.jpg';
        iconImg = 'assets/icons/Clear.png';
      } else if (main == 'Clouds') {
        bgImg = 'assets/images/clouds.jpg';
        iconImg = 'assets/icons/Clouds.png';
      } else if (main == 'Rain') {
        bgImg = 'assets/images/rain.jpg';
        iconImg = 'assets/icons/Rain.png';
      } else if (main == 'Fog') {
        bgImg = 'assets/images/fog.jpg';
        iconImg = 'assets/icons/Haze.png';
      } else if (main == 'Thunderstorm') {
        bgImg = 'assets/images/thunderstorm.jpg';
        iconImg = 'assets/icons/Thunderstorm.png';
      } else {
        bgImg = 'assets/images/haze.jpg';
        iconImg = 'assets/icons/Haze.png';
      }
    });
  }

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
                    controller: searchController,
                    onChanged: (cityName){
                      getData(cityName: cityName);
                    },
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
                cityName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 50),
              Text(
                "$temperature°c",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 90,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    main,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image.asset(
                    iconImg,
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
                    '$tempMax°c',
                    style: TextStyle(
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_downward,
                  ),
                  Text(
                    '$tempMin°c',
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
                          value1: sunrise,
                          value2: sunset,
                        ),
                        WeatherDataTile(
                          index1: 'Humidity',
                          index2: 'Visibility',
                          value1: humidity,
                          value2: visibility,
                        ),
                        WeatherDataTile(
                          index1: 'Precipitation',
                          index2: 'Wind speed',
                          value1: pressure,
                          value2: windSpeed,
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
