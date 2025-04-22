import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/Forecast_Model.dart';

class Forecastweather extends StatefulWidget {
  final String location;
  const Forecastweather({super.key, required this.location});

  @override
  State<Forecastweather> createState() => _ForecastweatherState();
}

class _ForecastweatherState extends State<Forecastweather> {
  ForecastModel? forecastModel;
  final ScrollController _scrollController = ScrollController();

  Future<void> getForecast() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=${widget.location}&appid=408a90789686486955da44c9115215fa'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        forecastModel = ForecastModel.fromJson(data);
      });
    } else {
      throw Exception('Failed to load data ');
    }
  }

  void _scrollLeft() {
    _scrollController.animateTo(_scrollController.offset - 200,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _scrollRight() {
    _scrollController.animateTo(_scrollController.offset + 200,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
  // Convert to DateTime

  String formatTime(int? timestamp) {
    if (timestamp == null) return "N/A";
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    return DateFormat('hh:mm a')
        .format(dateTime.toLocal()); // Converts to local time
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hourly Weather report of ${forecastModel?.city?.name}'),
        ),
        body: SafeArea(
          child: Stack(fit: StackFit.expand, children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1614851099511-773084f6911d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Z3JhZGllbnQlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fHww',
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [
                forecastModel == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final weatherData = forecastModel!.list![index];
                              return Row(
                                children: [
                                  Container(
                                    height: 170,
                                    width: 70,
                                    margin: EdgeInsets.all(10),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: Colors.blue)
                                        // color: Colors.lightBlueAccent
                                        ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${((weatherData.main?.temp ?? 273.15) - 273.15).toStringAsFixed(2)} °C',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 10),
                                          ),
                                        ),
                                        Image(
                                          image: NetworkImage(
                                              'https://openweathermap.org/img/wn/${weatherData.weather?[0].icon}@2x.png'),
                                        ),
                                        Text(
                                            '${weatherData.weather?[0].description}',
                                            style: TextStyle(
                                                color: Colors.lightBlueAccent,
                                                fontSize: 12)),
                                        Text(
                                            DateFormat('EEEE').format(
                                                DateTime.parse(
                                                    '${weatherData.dtTxt}')),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10)),
                                        Text(
                                            DateFormat('h:mm a').format(
                                                DateTime.parse(
                                                    '${weatherData.dtTxt}')),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12))
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            })),
                Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.all(5),
                            margin:
                                EdgeInsets.only(top: 5, left: 25, bottom: 25),
                            height: 80,
                            width: 140,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.sunny),
                                    Text('Sunrise')
                                  ],
                                ),
                                Text(
                                  '${formatTime(forecastModel?.city?.sunrise)}',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                    'Sunset: ${formatTime(forecastModel?.city?.sunset)}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.all(5),
                            margin:
                                EdgeInsets.only(top: 10, left: 25, bottom: 25),
                            height: 80,
                            width: 140,
                            child: Column(
                              children: [
                                Row(
                                  children: [Text('Population')],
                                ),
                                Text(
                                  '${forecastModel?.city?.population}',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ]),
        ));
  }
}
