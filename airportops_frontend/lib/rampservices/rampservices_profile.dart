// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/scanning.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/classes/events.dart';
import 'package:airportops_frontend/rampservices/event_details.dart';
import 'package:jiffy/jiffy.dart';

class BaggageRoute extends StatelessWidget {
  BaggageRoute({Key? key}) : super(key: key);

  Passenger p1 = Passenger(
    nameFirst: "John",
    nameLast: "Fester",
    //reservationNum: 1234,
    birthday: DateTime(2001, 9, 12),
    flightSource: "DTW",
    //flightSourceDate: DateTime(2023, 5, 5),
    flightDestination: "IAH",
    //flightDestinationDate: DateTime(2023, 5, 5),
    //citizenship: "USA",
    seat: "A",
    passengerId: "12345",
    row: 5,
    boarded: false,
    accommodations: [],
    event: "Safety Rodeo",
    status: Status.unboarded,
  );

  Passenger p2 = Passenger(
    nameFirst: "Linda",
    nameLast: "Holmes",
    //reservationNum: 1235,
    birthday: DateTime(1998, 8, 3),
    flightSource: "DTW",
    //flightSourceDate: DateTime(2023, 5, 5),
    flightDestination: "IAH",
    //flightDestinationDate: DateTime(2023, 5, 5),
    //citizenship: "USA",
    seat: "B",
    passengerId: "12345",
    row: 5,
    boarded: false,
    accommodations: [],
    event: "Safety Rodeo",
    status: Status.unboarded,
  );

  Passenger p3 = Passenger(
    nameFirst: "Ray",
    nameLast: "Palmer",
    //reservationNum: 1236,
    birthday: DateTime(1901, 7, 12),
    flightSource: "DTW",
    //flightSourceDate: DateTime(2023, 5, 5),
    flightDestination: "IAH",
    //flightDestinationDate: DateTime(2023, 5, 5),
    //citizenship: "USA",
    seat: "C",
    passengerId: "12345",
    row: 5,
    boarded: false,
    accommodations: [],
    event: "Safety Rodeo",
    status: Status.unboarded,
  );

  Passenger p4 = Passenger(
    nameFirst: "Test",
    nameLast: "Subject",
    //reservationNum: 1237,
    birthday: DateTime(1921, 7, 12),
    flightSource: "DTW",
    //flightSourceDate: DateTime(2023, 6, 5),
    flightDestination: "ORD",
    //flightDestinationDate: DateTime(2023, 5, 5),
    //citizenship: "USA",
    seat: "D",
    passengerId: "12345",
    row: 5,
    boarded: false,
    accommodations: [],
    event: "Safety Rodeo",
    status: Status.unboarded,
  );

  Event e1 = Event("Line Dancing", 0, 0, 0, [], [], []);

  List<Event> events = [];

  late Event e2 = Event("Cowboy Rodeo", 0, 15, 0, [], [], []);

  final Competitor c = Competitor("Satvik", "Ravipati", Position.Ramp);
  final String image = 'icons8-circled-user-male-skin-type-6-96.png';

  @override
  Widget build(BuildContext context) {
    void submit() {
      Navigator.of(context).pop();
    }



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileBox(competitior: c, image: image),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 30, 50, 0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Current Event',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            Jiffy(DateTime.now()).format('MMM do yyyy'),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(25, 10, 0, 0),
                            child: Text(
                              '${e1.name} - Team Cowboys',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          TextButton(
                            child: Text(
                              'View itinerary >',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                color: Color(0xFF00239E),
                              ),
                            ),
                            onPressed: () async {
                              var req = await passengerRequest();
                              List<Passenger> passengers = [p1,p2,p3];

                              for (var passenger in req['data']) {
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
                                  status: passenger['boarded'] == true
                                      ? Status.boarded
                                      : Status.unboarded,
                                ));
                              }
                              for (var person in passengers) {
                                e1.addPassenger(person);
                              }

                              print(e1.passengers);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EventRoute(event: e1)));
                              print('Pressed');
                            }
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(-1, -1),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 30, 0, 0),
                child: Text(
                  'Saved Events',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            EventBox(event: e1),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(50, 30, 50, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UniversalScanApp()));
                  print("LINK TO SCAN BUTTON");
                },
                child: Text(
                  "SCAN",
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EventBox extends StatelessWidget {
  EventBox({super.key, required this.event});

  final Event event;

    Passenger p1 = Passenger(
    nameFirst: "John",
    nameLast: "Fester",
    //reservationNum: 1234,
    birthday: DateTime(2001, 9, 12),
    flightSource: "DTW",
    //flightSourceDate: DateTime(2023, 5, 5),
    flightDestination: "IAH",
    //flightDestinationDate: DateTime(2023, 5, 5),
    //citizenship: "USA",
    seat: "A",
    passengerId: "12345",
    row: 5,
    boarded: false,
    accommodations: [],
    event: "Safety Rodeo",
    status: Status.unboarded,
  );

  Passenger p2 = Passenger(
    nameFirst: "Linda",
    nameLast: "Holmes",
    //reservationNum: 1235,
    birthday: DateTime(1998, 8, 3),
    flightSource: "DTW",
    //flightSourceDate: DateTime(2023, 5, 5),
    flightDestination: "IAH",
    //flightDestinationDate: DateTime(2023, 5, 5),
    //citizenship: "USA",
    seat: "B",
    passengerId: "12345",
    row: 5,
    boarded: false,
    accommodations: [],
    event: "Safety Rodeo",
    status: Status.unboarded,
  );

  Passenger p3 = Passenger(
    nameFirst: "Ray",
    nameLast: "Palmer",
    //reservationNum: 1236,
    birthday: DateTime(1901, 7, 12),
    flightSource: "DTW",
    //flightSourceDate: DateTime(2023, 5, 5),
    flightDestination: "IAH",
    //flightDestinationDate: DateTime(2023, 5, 5),
    //citizenship: "USA",
    seat: "C",
    passengerId: "12345",
    row: 5,
    boarded: false,
    accommodations: [],
    event: "Safety Rodeo",
    status: Status.unboarded,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(35, 15, 50, 0),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Container(
                width: 100,
                height: 45,
                decoration: BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color(0x33000000),
                      offset: Offset(0, 0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                      child: Text(
                        event.name,
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: IconButton(
                          onPressed: () async {
                            var req = await passengerRequest();
                            List<Passenger> passengers = [p1,p2,p3];

                            for (var passenger in req['data']) {
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
                                status: passenger['boarded'] == true
                                    ? Status.boarded
                                    : Status.unboarded,
                              ));
                            }
                            for (var person in passengers) {
                              event.addPassenger(person);
                            }

                            print(event.passengers);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EventRoute(event: event)));
                          
                          },
                          icon: Icon(
                            Icons.arrow_right,
                            color: Color(0xFF00239E),
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
    );
  }
}
