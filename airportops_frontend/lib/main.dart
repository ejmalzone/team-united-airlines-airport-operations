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

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //var cameras = await availableCameras();
  //final firstCamera = cameras.first;
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeRoute(),
      '/examplePassenger': (context) => PassengerProfileApp(),
      '/baggage': (context) => BaggageRoute(),
      '/admin': (context) => AdminRoute(),
      // '/newPassenger': (context) => const NewPassenger(),
      '/bars': (context) => ProgressBarRoute(),
      '/dbTesting': (context) => DatabaseRoute(),
      '/scanning': (context) => ScanRoute(),
      //'/camera': (context) => TakePictureScreen(camera: firstCamera),
      '/camera': (context) => UniversalScanApp(),
    },
  ));
}

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
        child: ElevatedButton(
          onPressed: () async {
            print('Testing: ');
            var req = await testRequest();
            print(req['data']);
          },
          child: const Text('Submit'),
        ),
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
            const SizedBox(height: 8),
            ElevatedButton(
                child: const Text('Baggage Information'),
                onPressed: () {
                  Navigator.pushNamed(context, '/baggage');
                }),
            const SizedBox(height: 8),
            ElevatedButton(
                child: const Text('Admin Panel'),
                onPressed: () {
                  Navigator.pushNamed(context, '/admin');
                }),
            const SizedBox(height: 8),
            // ElevatedButton(
            //   child: const Text('New Passenger'),
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/newPassenger');
            //   },
            // ),
            const SizedBox(height: 8),
            ElevatedButton(
                child: const Text('Progress Bar Demo'),
                onPressed: () {
                  Navigator.pushNamed(context, '/bars');
                }),
            const SizedBox(height: 8),
            ElevatedButton(
                child: const Text('Database Testing'),
                onPressed: () {
                  Navigator.pushNamed(context, '/dbTesting');
                }),
            ElevatedButton(
              child: const Text('Scan Boarding Pass'),
              onPressed: () {
                Navigator.pushNamed(context, '/camera');
              },
            ),
            const SizedBox(height: 8),
          ],
        )));
  }
}

class PassengerProfileApp extends StatelessWidget {
  PassengerProfileApp({super.key});

  final Passenger testP = Passenger(
      nameFirst: "Ethan",
      nameLast: "Malzone",
      reservationNum: 1234,
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

class PassengerProfile extends StatelessWidget {
  const PassengerProfile(
      {super.key, required this.title, required this.passenger});

  final String title;
  final Passenger passenger;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
