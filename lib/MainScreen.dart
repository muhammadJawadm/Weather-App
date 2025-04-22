import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:weather_app/Models_name.dart';
import 'package:weather_app/forecastWeather.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  TextEditingController _searchController = SearchController();

  Future<WeatherModel> getWeatherApi(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=408a90789686486955da44c9115215fa'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('failed to load data');
    }
  }

  WeatherModel? weatherData;

  String formatTime(int? timestamp) {
    if (timestamp == null) return "N/A";
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    return DateFormat('hh:mm a')
        .format(dateTime.toLocal()); // Converts to local time
  }

  void fetchWeather() async {
    String city = _searchController.text;
    if (city.isNotEmpty)
      setState(() {
        weatherData = null;
      });

    try {
      WeatherModel data = await getWeatherApi(city);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      print('Error fetching Weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1614851099511-773084f6911d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Z3JhZGllbnQlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fHww'),
                    fit: BoxFit.cover)),
          ),
          Column(
            children: [
              SearchBar(
                constraints: BoxConstraints(minHeight: 50, maxWidth: 350),
                hintText: 'Search the location',
                controller: _searchController,
                trailing: <Widget>[
                  Tooltip(
                    message: 'search the country wise',
                    child: IconButton(
                        onPressed: fetchWeather,
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                        )),
                  )
                ],
              ),
              weatherData == null
                  ? Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            '${((weatherData?.main?.temp ?? 273.15) - 273.15).toStringAsFixed(2)} °C',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Image(
                          image: NetworkImage(
                              'https://openweathermap.org/img/wn/${weatherData?.weather?[0].icon}@2x.png'),
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),

                        Text(
                          '${weatherData?.weather?[0].main}',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        Text(
                          'City: ${weatherData?.name ?? "Unknown"}',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.thermostat,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        ' Min Temp',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                      Text(
                                        '${((weatherData?.main?.tempMin ?? 273.15) - 273.15).toStringAsFixed(2)} °C',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.thermostat_outlined,
                                    color: Colors.red,
                                    size: 35,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        ' Max Temp',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                      Text(
                                        '${((weatherData?.main?.tempMax ?? 273.15) - 273.15).toStringAsFixed(2)} °C',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.sunny,
                                    color: Colors.yellow,
                                    size: 35,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Sunrise',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        '  ${formatTime(weatherData?.sys?.sunrise)}',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidSun,
                                    color: Colors.yellow,
                                    size: 35,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Sunset',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        '   ${formatTime(weatherData?.sys?.sunset)}',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Forecastweather(
                                            location:
                                                weatherData?.name ?? "Unknown",
                                          )));
                            },
                            child: Text('Hourly Forecast'))
                        // Add more weather info display here
                      ],
                    )
            ],
          )
        ],
      ),
    ));
  }
}
