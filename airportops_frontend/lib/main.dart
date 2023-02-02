import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/passenger.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/extensions.dart';

void main() {
  runApp(PassengerProfileApp());
}

class PassengerProfileApp extends StatelessWidget {
  PassengerProfileApp({super.key});

  final Passenger testP = Passenger(
      "Ethan",
      "Malzone",
      DateTime(2001, 1, 4),
      "DTW",
      DateTime(2023, 2, 2),
      "IAH",
      DateTime(2023, 2, 3),
      "United States",
      "21A");

  @override
  Widget build(BuildContext context) {
    testP.status = Status.boarded;
    return MaterialApp(
      title: 'Passenger Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PassengerProfile(
          title: 'Passenger Profile',
          passenger: testP)
    );
  }
}

class PassengerProfile extends StatelessWidget {
  const PassengerProfile({super.key, required this.title, required this.passenger});

  final String title;
  final Passenger passenger;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          textAlign: TextAlign.center),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              child:
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[Text(
                            passenger.fullName,
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 24)
                        ),
                          Text(
                            '${passenger.birthday.toString().split(' ')[0]} | ${passenger.citizenship}',
                            textAlign: TextAlign.justify,
                            style: const TextStyle(fontSize: 12),
                          )
                        ]
                      ),
                      Text(
                          passenger.status.name.titleCase(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 36,
                              color: passenger.status.color
                          )
                      )
                    ]
                  )
              )
            ),
          ],
        ),
      ),
    );
  }
}
