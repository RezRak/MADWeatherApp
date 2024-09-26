import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weather Information'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  String userCity = '';
  int temperature = 0;
  String weatherCondition = '';
  final List<String> wConditions = ["Sunny", "Cloudy", "Rainy"];
  List<Map<String, dynamic>> forecast = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateInfo(String userCity) {
    setState(() {
      this.userCity = userCity;
      temperature = Random().nextInt(15) + 15;
      weatherCondition = wConditions[Random().nextInt(wConditions.length)];
    });
  }

  void generate7DayForecast() {
    List<Map<String, dynamic>> generatedForecast = [];
    for (int i = 1; i <= 7; i++) {
      generatedForecast.add({
        "day": "Day $i",
        "temperature": Random().nextInt(15) + 15,
        "condition": wConditions[Random().nextInt(wConditions.length)]
      });
    }
    setState(() {
      forecast = generatedForecast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  children: [
                    TextSpan(text: 'City: $userCity\n'),
                    TextSpan(text: 'Temperature: $temperature°C\n'),
                    TextSpan(text: 'Weather Condition: $weatherCondition\n'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Enter City Name',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => updateInfo(_controller.text),
                child: const Text('Submit'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: generate7DayForecast,
                child: const Text('7-Day Forecast'),
              ),
              const SizedBox(height: 16),
              forecast.isNotEmpty
                  ? Column(
                      children: [
                        const Text(
                          '7-Day Forecast',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...forecast.map((day) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: ListTile(
                              title: Text(day['day']),
                              subtitle: Text(
                                  'Temperature: ${day['temperature']}°C\nCondition: ${day['condition']}'),
                            ),
                          );
                        }).toList(),
                      ],
                    )
                  : const Text('No forecast available'),
            ],
          ),
        ),
      ),
    );
  }
}
