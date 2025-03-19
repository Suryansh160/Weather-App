import 'dart:ui';

import 'package:flutter/material.dart';
import './services/api_service.dart';

class Weatherscreen extends StatefulWidget {
  const Weatherscreen({super.key});

  @override
  State<Weatherscreen> createState() => _WeatherscreenState();
}

class _WeatherscreenState extends State<Weatherscreen> {
  List<dynamic>? fullResponse;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  String city = 'Lucknow';
  Future<void> fetchWeather() async {
    final data = await ApiService().fetchWeather(city);
    setState(() {
      fullResponse = data;
      isLoading = false;
    });
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
            onPressed: () {},
            icon: Icon(Icons.list),
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 5),
          ),
          IconButton(
            onPressed: () {},
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
            "assets/bg.jpg",
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                  // color: Colors.black.withOpacity(0.2),
                  ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: screenHeight * 0.17)),
                Center(
                  child: Text(
                    "${fullResponse != null ? fullResponse![0]['main']['temp'].toInt().toString() : 'N/A'}°",
                    style: TextStyle(
                        fontSize: screenHeight * 0.1,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                        "${fullResponse != null ? fullResponse![0]['weather'][0]['main'] : 'N/A'} ${fullResponse != null ? fullResponse![0]['main']['temp_min'] : 'N/A'}° / ${fullResponse != null ? fullResponse![0]['main']['temp_max'] : 'N/A'}° Humidity ${fullResponse != null ? fullResponse![0]['main']['humidity'] : 'N/A'}"),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.00005,
                ),
                Container(
                  height: screenHeight * 0.4,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.count(
                    childAspectRatio: 1.3,
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                    children: [
                      Container(
                        // height: screenHeight * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.3), // Transparent background
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.water, color: Colors.white),
                            Text('Sea Level',
                                style: TextStyle(color: Colors.white)),
                            Text(
                                '${fullResponse != null ? fullResponse![0]['main']['sea_level'] : 'N/A'}',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.3), // Transparent background
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.thermostat, color: Colors.white),
                            Text('Feels Like',
                                style: TextStyle(color: Colors.white)),
                            Text(
                                '${fullResponse != null ? fullResponse![0]['main']['feels_like'] : 'N/A'} °',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.3), // Transparent background
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.water_drop_outlined,
                                color: Colors.white),
                            Text('Humidity',
                                style: TextStyle(color: Colors.white)),
                            Text(
                                style: TextStyle(color: Colors.white),
                                '${fullResponse != null ? fullResponse![0]['main']['humidity'] : 'N/A'}'),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.3), // Transparent background
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.air, color: Colors.white),
                            Text('WNW wind',
                                style: TextStyle(color: Colors.white)),
                            Text(
                                '${fullResponse != null ? fullResponse![0]['wind']['speed'] : 'N/A'} mph',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.3), // Transparent background
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.compress, color: Colors.white),
                            Text('Air pressure',
                                style: TextStyle(color: Colors.white)),
                            Text(
                                style: TextStyle(color: Colors.white),
                                '${fullResponse != null ? fullResponse![0]['main']['pressure'] : 'N/A'} hPa'),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.3), // Transparent background
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
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                                '${fullResponse != null ? fullResponse![0]['visibility'] : 'N/A'}',
                                style: TextStyle(color: Colors.white)),
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
