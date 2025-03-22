import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import './services/api_service.dart';

class Weatherscreen extends StatefulWidget {
  const Weatherscreen({super.key});

  @override
  State<Weatherscreen> createState() => _WeatherscreenState();
}

class _WeatherscreenState extends State<Weatherscreen> {
  List<dynamic>? fullResponse;
  bool isLoading = true;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    fetchWeather();

    _controller = VideoPlayerController.asset('assets/vid.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {
          (() {});
        });
      });
  }

  String city = 'Indore';
  Future<void> fetchWeather() async {
    final data = await ApiService().fetchWeather(city);
    setState(() {
      fullResponse = data;
      isLoading = false;
    });
    print(fullResponse![0]);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          city,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return Container(
                    width: screenHeight * 0.4,
                    height: screenHeight * 0.5,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) => setState(() {
                        city = value;
                      }),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusColor: Colors.grey,
                          prefixIcon: Icon(
                            Icons.location_city,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.3),
                          labelText: 'Enter city',
                          labelStyle: TextStyle(color: Colors.white)),
                    ), // Optional: Set a height
                  );
                },
              );
              fetchWeather();
            },
            icon: Icon(Icons.search_sharp),
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 5),
          ),
          IconButton(
            onPressed: fetchWeather,
            icon: Icon(Icons.refresh_outlined),
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 5),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg.jpg',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: screenHeight * 0.15)),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "${fullResponse != null ? fullResponse![0]['main']['temp'].toInt().toString() : 'N/A'}°",
                    style: TextStyle(
                        fontSize: screenHeight * 0.13,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: screenHeight * 0.0215),
                        textAlign: TextAlign.center,
                        "${fullResponse != null ? fullResponse![0]['weather'][0]['main'] : 'N/A'} \n${fullResponse != null ? fullResponse![0]['main']['temp_min'] : 'N/A'}° / ${fullResponse != null ? fullResponse![0]['main']['temp_max'] : 'N/A'}°"),
                  ],
                ),
                Container(
                  height: screenHeight * 0.36,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.3,
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.2), // Transparent background
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.water, color: Colors.white),
                            Text('Sea Level',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: screenHeight * 0.018)),
                            Text(
                                '${fullResponse != null ? fullResponse![0]['main']['sea_level'] : 'N/A'}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight * 0.02)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.2), // Transparent background
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.thermostat, color: Colors.white),
                            Text('Feels Like',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: screenHeight * 0.018)),
                            Text(
                                '${fullResponse != null ? fullResponse![0]['main']['feels_like'] : 'N/A'} °',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight * 0.02)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.2), // Transparent background
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.water_drop_outlined,
                                color: Colors.white),
                            Text('Humidity',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: screenHeight * 0.018)),
                            Text(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight * 0.02),
                                '${fullResponse != null ? fullResponse![0]['main']['humidity'] : 'N/A'}'),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.2), // Transparent background
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.air, color: Colors.white),
                            Text('WNW wind',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: screenHeight * 0.018)),
                            Text(
                                '${fullResponse != null ? fullResponse![0]['wind']['speed'] : 'N/A'} mph',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight * 0.02)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.2), // Transparent background
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.compress, color: Colors.white),
                            Text('Air pressure',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: screenHeight * 0.018)),
                            Text(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight * 0.02),
                                '${fullResponse != null ? fullResponse![0]['main']['pressure'] : 'N/A'} hPa'),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.2), // Transparent background
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.visibility_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              'Visibility',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: screenHeight * 0.018),
                            ),
                            Text(
                                '${fullResponse != null ? fullResponse![0]['visibility'] : 'N/A'}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenHeight * 0.02)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '5-day weather Forecast',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 214, 214, 211),
                      fontSize: screenHeight * 0.023),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: screenHeight * 0.25,
                  width: screenHeight * 0.45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.25),
                      border: Border.all(
                          width: 1, color: Colors.black.withOpacity(0.5))),
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        visualDensity: VisualDensity(vertical: -3),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: fullResponse != null
                                      ? DateTime.parse(
                                              fullResponse![6]['dt_txt'])
                                          .day
                                          .toString()
                                      : 'N/A',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              TextSpan(
                                  text: ' / ',
                                  style: TextStyle(color: Colors.grey)),
                              TextSpan(
                                  text: fullResponse != null
                                      ? DateTime.parse(
                                              fullResponse![6]['dt_txt'])
                                          .month
                                          .toString()
                                      : 'N/A',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white))
                            ])),
                            Icon(
                              Icons.wb_sunny_outlined,
                              color: Colors.yellow,
                            ),
                            Text(
                                style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                '${fullResponse != null ? fullResponse![6]['main']['temp_min'] : 'N/A'} / ${'${fullResponse != null ? fullResponse![6]['main']['temp_max'] : 'N/A'}'}')
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        visualDensity: VisualDensity(vertical: -3),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: fullResponse != null
                                      ? DateTime.parse(
                                              fullResponse![12]['dt_txt'])
                                          .day
                                          .toString()
                                      : 'N/A',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              TextSpan(
                                  text: ' / ',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey)),
                              TextSpan(
                                  text: fullResponse != null
                                      ? DateTime.parse(
                                              fullResponse![12]['dt_txt'])
                                          .month
                                          .toString()
                                      : 'N/A',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white))
                            ])),
                            Icon(
                              Icons.wb_sunny_outlined,
                              color: Colors.yellow,
                            ),
                            Text(
                                style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                '${fullResponse != null ? fullResponse![12]['main']['temp_min'] : 'N/A'} / ${'${fullResponse != null ? fullResponse![12]['main']['temp_max'] : 'N/A'}'}')
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        visualDensity: VisualDensity(vertical: -3),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: fullResponse != null
                                      ? DateTime.parse(
                                              fullResponse![18]['dt_txt'])
                                          .day
                                          .toString()
                                      : 'N/A',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              TextSpan(
                                  text: ' / ',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey)),
                              TextSpan(
                                  text: fullResponse != null
                                      ? DateTime.parse(
                                              fullResponse![18]['dt_txt'])
                                          .month
                                          .toString()
                                      : 'N/A',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white))
                            ])),
                            Icon(
                              Icons.wb_sunny_outlined,
                              color: Colors.yellow,
                            ),
                            Text(
                                style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                '${fullResponse != null ? fullResponse![18]['main']['temp_min'] : 'N/A'} / ${'${fullResponse != null ? fullResponse![18]['main']['temp_max'] : 'N/A'}'}')
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        visualDensity: VisualDensity(vertical: -3),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: fullResponse != null
                                      ? DateTime.parse(
                                              fullResponse![30]['dt_txt'])
                                          .day
                                          .toString()
                                      : 'N/A',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              TextSpan(
                                  text: ' / ',
                                  style: TextStyle(color: Colors.grey)),
                              TextSpan(
                                  text: fullResponse != null
                                      ? DateTime.parse(
                                              fullResponse![30]['dt_txt'])
                                          .month
                                          .toString()
                                      : 'N/A',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white))
                            ])),
                            Icon(
                              Icons.wb_sunny_outlined,
                              color: Colors.yellow,
                            ),
                            Text(
                              '${fullResponse != null ? fullResponse![30]['main']['temp_min'] : 'N/A'} / ${'${fullResponse != null ? fullResponse![30]['main']['temp_max'] : 'N/A'}'}',
                              style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      ListTile(
                        visualDensity: VisualDensity(vertical: -3),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: fullResponse != null
                                      ? DateTime.parse(
                                              fullResponse![35]['dt_txt'])
                                          .day
                                          .toString()
                                      : 'N/A',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white)),
                              TextSpan(
                                  text: ' / ',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey)),
                              TextSpan(
                                  text: fullResponse != null
                                      ? DateTime.parse(
                                              fullResponse![35]['dt_txt'])
                                          .month
                                          .toString()
                                      : 'N/A',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.02,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))
                            ])),
                            Icon(
                              Icons.wb_sunny_outlined,
                              color: Colors.yellow,
                            ),
                            Text(
                              '${fullResponse != null ? fullResponse![35]['main']['temp_min'] : 'N/A'} / ${'${fullResponse != null ? fullResponse![35]['main']['temp_max'] : 'N/A'}'}',
                              style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
