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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:airportops_frontend/login.dart';

class AdminRoute extends StatefulWidget {
  Map<String, dynamic> eventmap;
  Map<String, dynamic> curreventmap;
  AdminRoute({Key? key, required this.eventmap, required this.curreventmap})
      : super(key: key);

  @override
  State<AdminRoute> createState() => AdminRouteState();
}

class AdminRouteState extends State<AdminRoute> {
  AdminRouteState({Key? key});

  late Event currentEvent;
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
      if (e['name'] != widget.curreventmap['data']['name']) {
        Event cEvent = Event(e['name'], 0, 0, 0, 0, 0, 0, [], [], []);
        events.add(cEvent);
      } else {
        currentEvent = Event(
            widget.curreventmap['data']['name'], 0, 0, 0, 0, 0, 0, [], [], []);
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
            'assets/kisspng-logo-brand-font-airline-logo-5b1d7561d2b990.7344765815286572498631.png',
            fit: BoxFit.contain,
            height: 80),
        centerTitle: true,
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
            CurrBox(event: currentEvent),
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
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 50),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shadowColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Color.fromARGB(150, 0, 0, 0);
                          }
                          return Color.fromARGB(100, 0, 0, 0);
                        }),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          return Color.fromARGB(255, 151, 151, 151);
                        }),
                        alignment: Alignment.center,
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color:
                                            Color.fromARGB(255, 31, 31, 31)))),
                      ),
                      child: Image.asset("assets/logout.png",
                          width: 45, alignment: Alignment.centerRight),
                      onPressed: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove(ADMIN_KEY);
                        Navigator.of(context).pop();
                      }),
                ),
              ),
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

class CurrBox extends StatefulWidget {
  Event event;
  CurrBox({Key? key, required this.event}) : super(key: key);

  @override
  State<CurrBox> createState() => _CurrBoxState();
}

class _CurrBoxState extends State<CurrBox> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  // void getData() async {
    
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                widget.event.name,
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
                onPressed: () async {
                  widget.event.Reset();
                  await passengerRequest(widget.event.name).then((pReq) {
                    if (pReq['status'] == 'success') {
                      for (var passenger in pReq['data']) {
                        widget.event
                            .addPassenger(Passenger.fromJson(passenger));
                      }

                      for (var person in widget.event.passengers) {
                        if (person.boarded == true) {
                          widget.event.p_boarded += 1;
                        }

                        if (person.boarded == false) {
                          widget.event.p_unboarded += 1;
                        }
                      }
                    }
                  });
                  await bagsRequest(widget.event.name).then((bReq) {
                    if (bReq["status"] == "success") {
                      for (var bag in bReq["data"]) {
                        widget.event.addBag(Baggage(
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

                  await competitorRequest(widget.event.name).then((cReq) {
                    if (cReq['status'] == 'success') {
                      for (var comp in cReq['data']) {
                        widget.event.addCompetitor(Competitor(
                            firstname: comp['firstName'],
                            lastname: comp['lastName'],
                            stationCode: comp['stationCode'],
                            username: comp['username'],
                            event: widget.event.name,
                            bagsScanned: [],
                            passengersScanned: [],
                            position: comp['position'] == 0
                                ? Position.Csr
                                : Position.Ramp));
                      }

                      for (var bag in widget.event.bags) {
                        if (bag.checked == true) {
                          widget.event.b_boarded += 1;
                        }

                        if (bag.checked == false) {
                          widget.event.b_unboarded += 1;
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
                              EventRoute(event: widget.event)));
                },
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
                                  event.addPassenger(
                                      Passenger.fromJson(passenger));
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
