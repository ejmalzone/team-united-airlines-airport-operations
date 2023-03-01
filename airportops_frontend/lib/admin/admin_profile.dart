// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/classes/events.dart';
import 'package:airportops_frontend/admin/event_details.dart';

class AdminRoute extends StatefulWidget {
  AdminRoute({super.key});

  @override
  State<AdminRoute> createState() => AdminRouteState();
}

class AdminRouteState extends State<AdminRoute> {
  AdminRouteState({Key? key});

  /*Passenger p1 = Passenger(
      nameFirst: "John",
      nameLast: "Fester",
      reservationNum: 1234,
      birthday: DateTime(2001, 9, 12),
      flightSource: "DTW",
      flightSourceDate: DateTime(2023, 5, 5),
      flightDestination: "IAH",
      flightDestinationDate: DateTime(2023, 5, 5),
      citizenship: "USA",
      seat: "123");

  Passenger p2 = Passenger(
      nameFirst: "Linda",
      nameLast: "Holmes",
      reservationNum: 1235,
      birthday: DateTime(1998, 8, 3),
      flightSource: "DTW",
      flightSourceDate: DateTime(2023, 5, 5),
      flightDestination: "IAH",
      flightDestinationDate: DateTime(2023, 5, 5),
      citizenship: "USA",
      seat: "124");

  Passenger p3 = Passenger(
      nameFirst: "Ray",
      nameLast: "Palmer",
      reservationNum: 1236,
      birthday: DateTime(1901, 7, 12),
      flightSource: "DTW",
      flightSourceDate: DateTime(2023, 5, 5),
      flightDestination: "IAH",
      flightDestinationDate: DateTime(2023, 5, 5),
      citizenship: "USA",
      seat: "125");
      */
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

  late List<Passenger> l1 = [p1, p2, p3];
  late List<Passenger> l2 = [p2, p3];

  late Event e1 = Event("Line Dancing", 0, 0, 0, l1, [], []);
  late Event e2 = Event("IDK", 0, 15, 0, l2, [], []);

  final Competitor c = Competitor("Stanley", "Duru", Position.Admin);
  final String image = 'icons8-circled-user-male-skin-type-6-96.png';

  String newEventName = '';

  List<Event> events = [];
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void submit() {
      Navigator.of(context).pop(controller.text);
      controller.clear();
    }

    Future<String?> openDialog() => showDialog<String?>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Create Event'),
              content: TextField(
                decoration: InputDecoration(hintText: 'Enter event name'),
                controller: controller,
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
            SizedBox(
                child: Column(
              children: List.generate(events.length, (index) {
                return EventBox(
                  event: events[index],
                );
              }),
            )),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(50, 30, 50, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF00239E),
                ),
                onPressed: () async {
                  final eventName = await openDialog();
                  if (eventName == null || eventName.isEmpty) return;
                  setState(() {
                    newEventName = eventName;
                  });
                  Event newEvent = Event(newEventName, 0, 0, 0, [], [], []);
                  events.add(newEvent);
                  print(newEventName);
                  print(events);
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
