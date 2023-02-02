import 'package:airportops_frontend/passenger.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/baggage.dart';

void main() {
  runApp(const PassengerProfileApp());
}

class PassengerProfileApp extends StatelessWidget {
  const PassengerProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passenger Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PassengerProfile(
          title: 'Passenger Profile',
          passenger: Passenger(
              "Ethan",
              "Malzone",
              DateTime(2001, 1, 4),
              "DTW",
              DateTime(2023, 2, 2),
              "IAH",
              DateTime(2023, 2, 3),
              "United States",
              "21A")),
    );
  }
}

class PassengerProfile extends StatelessWidget {
  const PassengerProfile(
      {super.key, required this.title, required this.passenger});

  final String title;
  final Passenger passenger;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(passenger.fullName,
                textAlign: TextAlign.left, style: const TextStyle(fontSize: 32))
          ],
        ),
      ),
    );
  }
}
