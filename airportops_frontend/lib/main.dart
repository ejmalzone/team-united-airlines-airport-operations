import 'dart:math';

import 'package:airportops_frontend/admin/admin_profile.dart';
import 'package:airportops_frontend/customerservice/customerservice_profile.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/classes/events.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/portal.dart';
import 'package:airportops_frontend/printing/pdfs.dart';
import 'package:airportops_frontend/progress_bar.dart';
import 'package:airportops_frontend/widgets/passenger_profile.dart';
import 'package:camera/camera.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/extensions.dart';
import 'package:airportops_frontend/classes/baggage.dart';
import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/scanning.dart';
import 'package:airportops_frontend/rampservices/rampservices_profile.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'classes/competitor.dart';
import 'login.dart';

Future<void> main() async {
  //var req = await passengerRequest();
  Map<String, dynamic> eventMap = await eventRequest();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      //'/': (context) => LoginRoute(),
      //'/portal': (context) => PortalRoute(),
      '/': (context) => PortalRoute(),
      '/portal': (context) => LoginRoute(),
      '/home': (context) => const HomeRoute(),
      '/examplePassenger': (context) => PassengerProfileApp(),
      '/baggage': (context) => BaggageRoute(),
      '/bars': (context) => ProgressBarRoute(),
      '/dbTesting': (context) => DatabaseRoute(),
      '/scanning': (context) => ScanRoute(),
      '/camera': (context) => UniversalScanApp(),
      '/customerservice': (context) => CSRRoute(),
      '/honeywell': (context) => HoneywellScanApp(),
    },
  ));
}

class PassengerDisplayRoute extends StatelessWidget {
  final Map<String, dynamic> data;
  const PassengerDisplayRoute({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Passenger> passengers = [];
    List<PassengerProfile> profiles = [];
    for (var passenger in data['data']) {
      passengers.add(Passenger(
        accommodations: passenger['accommodations'],
        passengerId: passenger['_id'],
        birthday: DateTime.now(),
        boarded: passenger['boarded'] == true,
        event: passenger['event'],
        flightDestination: passenger['destination'],
        flightSource: passenger['origin'],
        nameFirst: passenger['firstName'],
        nameLast: passenger['lastName'],
        row: passenger['row'],
        seat: passenger['seat'],
        status:
            passenger['boarded'] == true ? Status.boarded : Status.unboarded,
      ));
    }

    for (var person in passengers) {
      profiles.add(PassengerProfile(title: 'test', passenger: person));
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

/*class PassengerDisplayRoute extends StatefulWidget {
  PassengerDisplayRoute({Key? key}) : super(key: key);
  _PassengerDisplayRouteState createState() => _PassengerDisplayRouteState();
}

class _PassengerDisplayRouteState extends State<PassengerDisplayRoute> {
  Map<String, dynamic>? data;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    getPassengers();
  }

  getPassengers() async {
    setState(() {
      _isLoading = true;
    });
    var requestData = await passengerRequest();
    setState(() {
      data = requestData;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Passenger> passengers = [];
    List<PassengerProfile> profiles = [];

    for (var passenger in this.data?['data']) {
      passengers.add(Passenger(
          accommodations: passenger['accommodations'],
          passengerId: passenger['_id'],
          birthday: DateTime.now(),
          boarded: passenger['boarded'] == 'true',
          event: passenger['event'],
          flightDestination: passenger['destination'],
          flightSource: passenger['origin'],
          nameFirst: passenger['firstName'],
          nameLast: passenger['lastName'],
          row: passenger['row'],
          seat: passenger['seat']));
    }

    for (var person in passengers) {
      profiles.add(PassengerProfile(title: 'test', passenger: person));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Passenger Status Page'),
        ),
        body: _isLoading
            ? CircularProgressIndicator()
            : SingleChildScrollView(
                child: Center(
                  child: Column(children: <Widget>[
                    ...profiles,
                  ]),
                ),
              ));
  }
}
*/
class ScanRoute extends StatelessWidget {
  const ScanRoute({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanning Testing'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/camera');
          },
          child: const Text('Open Camera'),
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
                  var req = await testRequest();
                  //print(req['data']);
                },
                child: const Text('Event Query'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var req = await currPassengerRequest();
                  //print(req['data'][0]['boarded'] is bool);
                  //for (var person in req['data']) {
                  //  print('ID: ${person['_id']}');
                  //}
                  //await Navigator.of(context).pushNamed('/passengerTesting');
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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              child: const Text('Test Save Bag PDF'),
              onPressed: () async {
                Map<String, dynamic> reqData = await eventRequest();
                //print(reqData['data'][0]['_id']);
                Map<String, dynamic> bagData =
                    await bagsRequest(reqData['data'][0]['name']);
                print("BAG: ${bagData['data'][0]}");
                print(bagData['data'][0].runtimeType);
                Map bagInstance = bagData['data'][0];
                print('ID Test: ${bagInstance['_id']}');
                final testBag = Baggage(
                  checked: bagInstance['checked'],
                  destinationAirport: bagInstance['destination'],
                  event: bagInstance['event'],
                  nameFirst: bagInstance['passengerFirst'],
                  nameLast: bagInstance['passengerLast'],
                  originatingAirport: bagInstance['origin'],
                  weight: bagInstance['weight'],
                  id: bagInstance['_id'],
                );
                /*final bag = Baggage(
                    nameFirst: 'John',
                    nameLast: 'Doe',
                    originatingAirport: 'ATL',
                    destinationAirport: 'JFK',
                    weight: 40,
                    event: 'Test Event',
                    checked: false);*/
                PdfCreator.generateBagPdf(testBag);
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
                  //Navigator.pushNamed(context, '/passengerTesting');
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PassengerDisplayRoute(data: req)));
                }),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/honeywell');
              },
              child: const Text('Honeywell Testing'),
            )
          ].withSpaceBetween(height: 8),
        )));
  }
}

class PassengerProfileApp extends StatelessWidget {
  PassengerProfileApp({super.key});

  final Passenger testP = Passenger(
    nameFirst: "Ethan",
    nameLast: "Malzone",
    //reservationNum: 1234,
    birthday: DateTime(2001, 1, 4),
    flightSource: "DTW",
    //flightSourceDate: DateTime(2023, 2, 2),
    flightDestination: "IAH",
    //flightDestinationDate: DateTime(2023, 2, 3),
    //citizenship: "United States",
    seat: "A",
    accommodations: [],
    boarded: false,
    event: 'Safety Rodeo',
    passengerId: "3849673547ef8989",
    row: 5,
    status: Status.boarded,
  );

  @override
  Widget build(BuildContext context) {
    //testP.status = Status.boarded;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Profile'),
      ),
      body: Center(
        child: PassengerProfile(title: 'Passenger Profile', passenger: testP),
      ),
    );
  }
}

class ProgressBarRoute extends StatelessWidget {
  const ProgressBarRoute({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ProgressState> myKey = GlobalKey();
    var barA = ProgressBar(key: myKey, size: Size(200, 120));

    return Scaffold(
        appBar: AppBar(title: const Text('Progress Bars Demo')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            barA,
            OutlinedButton(
              onPressed: () {
                myKey.currentState!.currentProgress =
                    myKey.currentState!.currentProgress + 0.1;
              },
              child: Image.asset('assets/icons8-airport-64.png'),
            )
          ].withSpaceBetween(height: 8),
        )));
  }
}

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
