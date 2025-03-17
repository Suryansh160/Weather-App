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
          city.toUpperCase(),
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
                Padding(padding: EdgeInsets.only(top: screenHeight * 0.15)),
                Center(
                  child: Text(
                    "${fullResponse != null ? fullResponse![0]['main']['temp'].toInt().toString() : 'N/A'}°",
                    style: TextStyle(
                        fontSize: 55,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        "${fullResponse != null ? fullResponse![0]['weather'][0]['main'] : 'N/A'}"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
