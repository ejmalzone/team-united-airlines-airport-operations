import 'package:airportops_frontend/admin/admin_profile.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/classes/events.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/progress_bar.dart';
import 'package:camera/camera.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/extensions.dart';
import 'package:airportops_frontend/classes/baggage.dart';
import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/scanning.dart';
import 'package:airportops_frontend/rampservices/rampservices_profile.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'login.dart';

Future<void> main() async {
  //var req = await passengerRequest();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => LoginRoute(),
      '/home': (context) => const HomeRoute(),
      '/examplePassenger': (context) => PassengerProfileApp(),
      '/baggage': (context) => BaggageRoute(),
      '/admin': (context) => AdminRoute(),
      '/bars': (context) => ProgressBarRoute(),
      '/dbTesting': (context) => DatabaseRoute(),
      '/scanning': (context) => ScanRoute(),
      '/camera': (context) => UniversalScanApp(),
      '/portal': (context) => PortalRoute()
      //'/passengerTesting': (context) => PassengerDisplayRoute(),
      //'/passengerTesting': (context) => PassengerDisplayRoute(
      //      data: req,
      //    ),
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
                  print('Testing: ');
                  var req = await testRequest();
                  print(req['data']);
                },
                child: const Text('Event Query'),
              ),
              ElevatedButton(
                onPressed: () async {
                  var req = await passengerRequest();
                  //print(req['data'][0]['boarded'] is bool);
                  for (var person in req['data']) {
                    print('ID: ${person['_id']}');
                  }
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
                  var req = await passengerRequest();
                  //Navigator.pushNamed(context, '/passengerTesting');
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PassengerDisplayRoute(data: req)));
                }),
          ].withSpaceBetween(height: 8),
        )
      )
    );
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
    status: Status.unboarded,
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
        )
      )
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
    return GestureDetector(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 16.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(children: <Widget>[
                                Text(passenger.fullName,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 24)),
                                Text(
                                  '${passenger.birthday.toString().split(' ')[0]}', // | ${passenger.citizenship}',
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(fontSize: 12),
                                )
                              ]),
                              Text(passenger.status.name.titleCase(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 36,
                                      color: passenger.status.color))
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
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold))
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
                                /*Text(
                                passenger.flightSourceDate
                                    .toLocal()
                                    .toIso8601String(),
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),*/
                                Expanded(child: Text('. ' * 1000, maxLines: 1)),
                                /*Text(
                                passenger.flightDestinationDate
                                    .toLocal()
                                    .toIso8601String(),
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),*/
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
        ), //print('Tapped! ${passenger.passengerId}')
        onTap: () async => await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRImage(passenger.passengerId),
          ),
        )
    );
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
        )
      )
    );
  }
}
