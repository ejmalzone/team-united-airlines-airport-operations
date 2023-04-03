// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print, use_build_context_synchronously, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:airportops_frontend/classes/baggage.dart';
import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/classes/events.dart';
import 'package:airportops_frontend/admin/event_details.dart';

class AdminRoute extends StatefulWidget {
  Map<String, dynamic> eventmap;
  AdminRoute({Key? key, required this.eventmap}) : super(key: key);

  @override
  State<AdminRoute> createState() => AdminRouteState();
}

class AdminRouteState extends State<AdminRoute> {
  AdminRouteState({Key? key});

  late List<Event> events = [];

  final Admin c = Admin("Stanley", "Duru", Position.Admin);
  final String image = 'icons8-circled-user-male-skin-type-6-96.png';

  String newEventName = '';

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

    for (var e in widget.eventmap['data']) {
      Event cEvent = Event(e['name'], 0, 0, 0, 0, 0, 0, [], [], []);
      events.add(cEvent);
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
            AdminProfileBox(admin: c, image: image),
            Align(
              alignment: AlignmentDirectional(-1, -1),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 30, 0, 0),
                child: Text(
                  'Current Event',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(50, 15, 50, 0),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFA9C3FF),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'Line Dancing',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Text(
                          'Monday April 3 2023',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                      child: Text(
                        '[Passengers bar]',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Text(
                        '[Bags bar ]',
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: Center(
                          child: ElevatedButton(
                        onPressed: () async {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF00239E),
                        ),
                        child: Text(
                          "View Event",
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                          ),
                        ),
                      )),
                    )
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
            Flexible(
              child: SizedBox(
                  child: Column(
                children: List.generate(events.length, (index) {
                  return EventBox(
                    event: events[index],
                  );
                }),
              )),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(50, 30, 50, 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF00239E),
                ),
                onPressed: () async {
                  final eventName = await openDialog();
                  if (eventName == null || eventName.isEmpty) return;
                  setState(() {
                    var e = eventPost(eventName);
                    newEventName = eventName;
                    print(e);
                  });
                  print(eventRequest());
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
  EventBox({super.key, required this.event});

  final Event event;

  List<Admin> employees = [
    Admin("Grant", "Mcleod", Position.Csr),
    Admin("Nadia", "Summers", Position.Csr),
    Admin("Alice", "Nixon", Position.Ramp),
  ];

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
                            event.Reset();
                            await passengerRequest(event.name).then((pReq) {
                              if (pReq['status'] == 'success') {
                                for (var passenger in pReq['data']) {
                                  event.addPassenger(Passenger(
                                    accommodations:
                                        passenger['accommodations'] ?? [],
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

                                for (var person in event.passengers) {
                                  if (person.boarded == true) {
                                    event.p_boarded += 1;
                                  }

                                  if (person.boarded == false) {
                                    event.p_unboarded += 1;
                                  }
                                }
                              }
                            });
                            await bagsRequest(event.name).then((bReq) {
                              if (bReq["status"] == "success") {
                                for (var bag in bReq["data"]) {
                                  event.addBag(Baggage(
                                      nameFirst: bag["passengerFirst"],
                                      nameLast: bag["passengerLast"],
                                      originatingAirport: bag["origin"],
                                      destinationAirport: bag["destination"],
                                      weight: bag["weight"],
                                      event: bag["event"],
                                      checked: bag["checked"],
                                      id: bag["_id"],
                                      status: bag["checked"] == true
                                          ? Status.boarded
                                          : Status.unboarded));
                                }
                              }
                            });

                            await competitorRequest(event.name).then((cReq) {
                              if (cReq['status'] == 'success') {
                                for (var comp in cReq['data']) {
                                  event.addCompetitor(Competitor(
                                      firstname: comp['firstName'],
                                      lastname: comp['lastName'],
                                      stationCode: comp['stationCode'],
                                      username: comp['username'],
                                      event: event.name,
                                      bagsScanned: [],
                                      passengersScanned: [],
                                      position: comp['position'] == 0
                                          ? Position.Csr
                                          : Position.Ramp));
                                }

                                for (var bag in event.bags) {
                                  if (bag.checked == true) {
                                    event.b_boarded += 1;
                                  }

                                  if (bag.checked == false) {
                                    event.b_unboarded += 1;
                                  }
                                }
                              }
                            });
                            // for (var emp in employees) {
                            //   event.addCompetitor(emp);
                            // }

                            // print(event.passengers);

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
