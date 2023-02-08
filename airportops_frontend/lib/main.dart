import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/passenger.dart';
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
      '/admin': (context) => const AdminRoute(),
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
          ElevatedButton(
              child: const Text('Baggage Information'),
              onPressed: () {
                Navigator.pushNamed(context, '/baggage');
              }),
          ElevatedButton(
              child: const Text('Admin Panel'),
              onPressed: () {
                Navigator.pushNamed(context, '/admin');
              }),
        ],
      )),
    );
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

class AdminRoute extends StatelessWidget {
  const AdminRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Page"),
      ),
    );
  }
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
          ],
        ),
      ),
    );
  }
}
