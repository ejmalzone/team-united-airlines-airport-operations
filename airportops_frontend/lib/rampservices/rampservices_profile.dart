// ignore_for_file: prefer_const_constructors

import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/classes/events.dart';
import 'package:airportops_frontend/rampservices/event_details.dart';

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
  );

  late List<Passenger> l1 = [p1, p2, p3, p4];
  late List<Passenger> l2 = [p2, p3, p4];

  late Event e1 = Event("Line Dancing", 0, 0, 0, l1, [], []);
  late Event e2 = Event("Cowboy Rodeo", 0, 15, 0, l2, [], []);

  final Competitor c = Competitor("Satvik", "Ravipati", Position.Admin);
  final String image = 'icons8-circled-user-male-skin-type-6-96.png';

  @override
  Widget build(BuildContext context) {
    void submit() {
      Navigator.of(context).pop();
    }

    Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Create Event'),
              content: TextField(
                decoration: InputDecoration(hintText: 'Enter event name'),
              ),
              actions: [TextButton(onPressed: submit, child: Text('Submit'))],
            ));

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
            EventBox(event: e2),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(50, 30, 50, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF00239E),
                ),
                onPressed: () {
                  openDialog();
                  print("pressed generate");
                },
                child: Text(
                  "Generate New Event",
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
  const EventBox({super.key, required this.event});

  final Event event;

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
                          onPressed: () {
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
