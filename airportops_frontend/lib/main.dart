import 'dart:html';

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print, non_constant_identifier_names

import 'package:airportops_frontend/admin/admin_profile.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/events.dart';
import 'package:airportops_frontend/passenger.dart';
import 'package:airportops_frontend/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/extensions.dart';
import 'package:airportops_frontend/baggage.dart';

/*void main() {
  runApp(PassengerProfileApp());
}*/
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeRoute(),
      '/passenger': (context) => PassengerProfileApp(),
      '/baggage': (context) => const BaggageRoute(),
      '/admin': (context) => AdminRoute(),
      '/newPassenger': (context) => const NewPassenger(),
      '/bars': (context) => ProgressBarRoute()
    },
  ));
}

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Passenger Check-in'),
              onPressed: () {
                Navigator.pushNamed(context, '/passenger');
              },
            ),
            SizedBox(height: 8),
            ElevatedButton(
                child: const Text('Baggage Information'),
                onPressed: () {
                  Navigator.pushNamed(context, '/baggage');
                }),
            SizedBox(height: 8),
            ElevatedButton(
                child: const Text('Admin Panel'),
                onPressed: () {
                  Navigator.pushNamed(context, '/admin');
                }),
            ElevatedButton(
              child: const Text('New Passenger'),
              onPressed: () {
                Navigator.pushNamed(context, '/newPassenger');
              },
            ),
            SizedBox(height: 8),
            ElevatedButton(
                child: const Text('Progress Bar Demo'),
                onPressed: () {
                  Navigator.pushNamed(context, '/bars');
                }),
            SizedBox(height: 8),
          ],
        )));
  }
}

class NewPassenger extends StatefulWidget {
  const NewPassenger({Key? key}) : super(key: key);

  @override
  State<NewPassenger> createState() => _NewPassengerState();
}

class _NewPassengerState extends State<NewPassenger> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("New Passenger Page")),
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter First Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter Last Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text.';
                    }
                    return null;
                  },
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process data
                        }
                      },
                      child: const Text('Submit'),
                    ))
              ],
            )));
  }
}

class BaggageRoute extends StatelessWidget {
  const BaggageRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Baggage Page"),
      ),
    );
  }
}

class PassengerProfileApp extends StatelessWidget {
  PassengerProfileApp({super.key});

  final Passenger testP = Passenger(
      nameFirst: "Ethan",
      nameLast: "Malzone",
      birthday: DateTime(2001, 1, 4),
      flightSource: "DTW",
      flightSourceDate: DateTime(2023, 2, 2),
      flightDestination: "IAH",
      flightDestinationDate: DateTime(2023, 2, 3),
      citizenship: "United States",
      seat: "21A");

  @override
  Widget build(BuildContext context) {
    testP.status = Status.boarded;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Profile'),
      ),
      body: Center(
          child:
              PassengerProfile(title: 'Passenger Profile', passenger: testP)),
    );
  }
}

class ProgressBarRoute extends StatelessWidget {
  const ProgressBarRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var barA = ProgressBar(size: Size(200, 120))..setCurrentProgress(0.2);
    var barB = ProgressBar(size: Size(200, 120))..setCurrentProgress(0.5);
    var barC = ProgressBar(size: Size(200, 120))..setCurrentProgress(0.8);
    var barD = ProgressBar(size: Size(200, 120))..setCurrentProgress(1.0);

    return Scaffold(
        appBar: AppBar(title: const Text('Progress Bars Demo')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              <Widget>[barA, barB, barC, barD].withSpaceBetween(height: 8),
        )));
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
      /*appBar: AppBar(
        title: Text(title, textAlign: TextAlign.center),
      ),*/
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(children: <Widget>[
                            Text(passenger.fullName,
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 24)),
                            Text(
                              '${passenger.birthday.toString().split(' ')[0]} | ${passenger.citizenship}',
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontSize: 12),
                            )
                          ]),
                          Text(passenger.status.name.titleCase(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 36, color: passenger.status.color))
                        ]))),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(color: Colors.black12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text('Reservation Number',
                              style: TextStyle(fontSize: 14)),
                          const Text('R-1234',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(passenger.flightSource,
                                style: TextStyle(fontSize: 12)),
                            Text(passenger.flightDestination,
                                style: TextStyle(fontSize: 12)),
                          ]),
                      SizedBox(height: 4),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                passenger.flightSourceDate
                                    .toLocal()
                                    .toIso8601String(),
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                            Expanded(child: Text('. ' * 1000, maxLines: 1)),
                            Text(
                                passenger.flightDestinationDate
                                    .toLocal()
                                    .toIso8601String(),
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                          ]),
                      SizedBox(height: 80),
                      Text('Special Requests:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('    ${passenger.requestsString}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ]))
          ],
        ),
      ),
    );
  }
}
