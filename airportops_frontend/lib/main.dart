import 'dart:math';

import 'package:airportops_frontend/admin/admin_profile.dart';
import 'package:airportops_frontend/customerservice/customerservice_profile.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/classes/events.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/portal.dart';
import 'package:airportops_frontend/printing/pdfs.dart';
import 'package:airportops_frontend/progress_bar.dart';
import 'package:airportops_frontend/scoreboard.dart';
import 'package:airportops_frontend/widgets/passenger_profile.dart';
import 'package:camera/camera.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/extensions.dart';
import 'package:airportops_frontend/classes/baggage.dart';
import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/scanning.dart';
import 'package:airportops_frontend/rampservices/rampservices_profile.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'classes/competitor.dart';
import 'login.dart';

Future<void> main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => PortalRoute(),
      '/portal': (context) => LoginRoute(),
      '/home': (context) => const HomeRoute(),
      '/examplePassenger': (context) => ExamplePassengerProfileApp(),
      '/baggage': (context) => BaggageRoute(),
      //'/bars': (context) => const ProgressBarRoute(),
      '/dbTesting': (context) => const DatabaseRoute(),
      '/scanning': (context) => const ScanRoute(),
      '/camera': (context) => UniversalScanApp(),
      '/customerservice': (context) => CSRRoute(),
      '/honeywell': (context) => HoneywellScanApp()
    },
  ));
}

class PassengerDisplayRoute extends StatelessWidget {
  final Map<String, dynamic> data;
  const PassengerDisplayRoute({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Passenger> passengers = [];
    List<AdminPassengerProfile> profiles = [];
    for (var passenger in data['data']) {
      passengers.add(Passenger.fromJson(passenger));
    }

    for (var person in passengers) {
      profiles.add(AdminPassengerProfile(title: 'test', passenger: person));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Passenger Status Page'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
              ...profiles,
            ]),
          ),
        ));
  }
}

class ScanRoute extends StatelessWidget {
  const ScanRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Scanner'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => RSEScanApp())));
              },
              child: const Text('Open Device Camera'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => HoneywellScanApp())));
                },
                child: const Text('Honeywell Scanner')),
          ],
        ),
      ),
    );
  }
}

class DatabaseRoute extends StatelessWidget {
  const DatabaseRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Db testing page'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  //print('Testing: ');

                  var req = deleteEvent(eventName: 'fortnite');
                  print(req);
                },
                child: const Text('Event Query'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var req = await createBag(
                      passengerFirst: 'test',
                      passengerLast: 'bag',
                      origin: 'DTW',
                      destination: 'IAH',
                      weight: 78,
                      wrongDestination: false,
                      event: 'Test3');
                },
                child: const Text('Passenger Query'),
              ),
            ]),
      ),
    );
  }
}

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          backgroundColor: Colors.black,
        ),
        body: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Test Scoreboard'),
                onPressed: () {
                  Navigator.pushNamed(context, '/testScoreboard');
                },
              ),
              ElevatedButton(
                child: const Text('Example Passenger'),
                onPressed: () {
                  Navigator.pushNamed(context, '/examplePassenger');
                },
              ),
              ElevatedButton(
                  child: const Text('Baggage Information'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/baggage');
                  }),
              ElevatedButton(
                child: const Text('Test Save Boarding Passes to PDF'),
                onPressed: () async {
                  final data = (await currPassengerRequest())['data'];

                  List<Passenger> passengers = [];
                  for (var passengerInstance in data) {
                    passengers.add(Passenger.fromJson(passengerInstance));
                  }

                  PdfCreator.generateBoardingPassPages(passengers);
                },
              ),
              ElevatedButton(
                child: const Text('Test Save Baggage Tags to PDF'),
                onPressed: () async {
                  Map<String, dynamic> reqData = await eventRequest();
                  Map<String, dynamic> bagData =
                      await bagsRequest(reqData['data'][0]['name']);
                  final bagInstances = bagData['data'];

                  List<Baggage> bags = [];

                  for (var bagInstance in bagInstances) {
                    bags.add(Baggage.fromJson(bagInstance));
                  }

                  PdfCreator.generateBaggageTagPages(bags);
                },
              ),
              ElevatedButton(
                  child: const Text('Login Route'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  }),
              ElevatedButton(
                  child: const Text('Admin Panel'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin');
                  }),
              ElevatedButton(
                  child: const Text('Progress Bar Demo'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/bars');
                  }),
              ElevatedButton(
                  child: const Text('Database Testing'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/dbTesting');
                  }),
              ElevatedButton(
                  child: const Text('Scan Boarding Pass'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/camera');
                  }),
              ElevatedButton(
                  child: const Text('View Passenger Status'),
                  onPressed: () async {
                    var req = await currPassengerRequest();
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PassengerDisplayRoute(data: req)));
                  }),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/honeywell');
                },
                child: const Text('Honeywell Testing'),
              )
            ].withSpaceBetween(height: 8),
          )
        ]));
  }
}

class ExamplePassengerProfileApp extends StatelessWidget {
  ExamplePassengerProfileApp({super.key});

  final Passenger testP = Passenger(
    nameFirst: "Ethan",
    nameLast: "Malzone",
    birthday: DateTime(2001, 1, 4),
    flightSource: "DTW",
    flightDestination: "IAH",
    seat: "A",
    accommodations: [],
    boarded: false,
    event: 'Safety Rodeo',
    passengerId: "3849673547ef8989",
    row: 5,
    status: Status.boarded,
    connection: false,
    wrongGate: false,
    wrongDeparture: false,
    scanTime: null,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Profile'),
      ),
      body: Center(
        child:
            AdminPassengerProfile(title: 'Passenger Profile', passenger: testP),
      ),
    );
  }
}

// class ProgressBarRoute extends StatelessWidget {
//   const ProgressBarRoute({super.key});
// class ProgressBarRoute extends StatelessWidget {
//   const ProgressBarRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     GlobalKey<ProgressState> myKey = GlobalKey();
//     //var barA = ProgressBar(key: myKey, size: Size(200, 120));

//     return Scaffold(
//         appBar: AppBar(title: const Text('Progress Bars Demo')),
//         body: Center(
//             child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             barA,
//             OutlinedButton(
//               onPressed: () {
//                 myKey.currentState!.currentProgress =
//                     myKey.currentState!.currentProgress + 0.1;
//               },
//               child: Image.asset('assets/icons8-airport-64.png'),
//             )
//           ].withSpaceBetween(height: 8),
//         )));
//   }
// }

class QRImage extends StatelessWidget {
  const QRImage(this.passId, {super.key});
  final String passId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Passenger QR Code'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Center(
            child: QrImage(
          data: passId,
          size: 280,
          // You can include embeddedImageStyle Property if you
          //wanna embed an image from your Asset folder
          embeddedImageStyle: QrEmbeddedImageStyle(
            size: const Size(
              100,
              100,
            ),
          ),
        )));
  }
}
