// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print, use_build_context_synchronously, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'package:airportops_frontend/classes/admin.dart';
import 'package:airportops_frontend/classes/baggage.dart';
import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/extensions.dart';
import 'package:airportops_frontend/progress_bar.dart';
import 'package:airportops_frontend/scoreboard.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/classes/events.dart';
import 'package:airportops_frontend/admin/event_details.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:airportops_frontend/login.dart';
import 'package:airportops_frontend/progress_bar.dart';

import '../printing/pdfs.dart';
import 'new_admin.dart';

class AdminRoute extends StatefulWidget {
  late Map<String, dynamic> eventmap;
  late Map<String, dynamic> curreventmap;
  AdminRoute({Key? key}) : super(key: key);

  @override
  State<AdminRoute> createState() => AdminRouteState();
}

class AdminRouteState extends State<AdminRoute> {
  AdminRouteState({Key? key});

  late Event currentEvent;
  bool res = true;
  late List<Event> events = [];

  final Admin c = Admin("Admin", "User", Position.Admin);
  final String image = 'united-square-64.png';

  String newEventName = '';

  late TextEditingController controller;

  bool genData = false;

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

    return FutureBuilder(
      future: doubleRequest(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("DATA FOUND!!!");
          print(snapshot.data![1]['status']);
          widget.eventmap = snapshot.data![0];
          widget.curreventmap = snapshot.data![1];
          openDialog() => showDialog<String?>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Create Event'),
                  content: Column(mainAxisSize: MainAxisSize.min, children: [
                    TextField(
                      decoration: InputDecoration(hintText: 'Enter event name'),
                      controller: controller,
                    ),
                    Row(children: [
                      Text("Generate random data?"),
                      Checkbox(
                          value: genData,
                          onChanged: (change) {
                            String txt = controller.text;
                            setState(() {
                              events.clear();
                              genData = change!;
                              submit();
                              controller.text = txt;
                              openDialog();
                            });
                          }),
                    ]),
                    Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            child: Text("Submit"),
                            onPressed: () async {
                              String eventName = controller.text;
                              if (eventName.isEmpty) return;
                              setState(() async {
                                List<Event> temp = [];
                                events.clear();
                                var data = eventPost(eventName, genData);
                                //print(data);
                                newEventName = eventName;
                                Event newE = Event(
                                    newEventName, 0, 0, 0, 0, 0, 0, [], [], []);
                                temp.add(newE);
                                genData = false;
                                submit();
                              });
                            }))
                  ]),
                ),
              );
          if (widget.curreventmap['status'] != 'error') {
            print(widget.curreventmap);
            for (var e in widget.eventmap['data']) {
              if (e['name'] != widget.curreventmap['data']['name']) {
                Event cEvent = Event(e['name'], 0, 0, 0, 0, 0, 0, [], [], []);
                events.add(cEvent);
              } else {
                currentEvent = Event(widget.curreventmap['data']['name'], 0, 0,
                    0, 0, 0, 0, [], [], []);
                currentEvent.b_unboarded = widget.curreventmap['data']['bags'];
                currentEvent.p_unboarded =
                    widget.curreventmap['data']['passengers'];
              }
            }
          } else {
            res = false;
            currentEvent = Event('none', 0, 0, 0, 0, 0, 0, [], [], []);
            if (widget.eventmap['status'] != 'error') {
              for (var e in widget.eventmap['data']) {
                Event cEvent = Event(e['name'], 0, 0, 0, 0, 0, 0, [], [], []);
                events.add(cEvent);
              }
            }
          }
          print(widget.curreventmap);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Image.asset(
                  'assets/kisspng-logo-brand-font-airline-logo-5b1d7561d2b990.7344765815286572498631.png',
                  fit: BoxFit.contain,
                  height: 80),
              centerTitle: true,
            ),
            body: ListView(
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
                CurrBox(event: currentEvent, isTrue: res),
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
                //Flexible(
                //child: SizedBox(
                SizedBox(
                    child: Column(
                  //child: ListView(
                  children: List.generate(events.length, (index) {
                    return EventBox(
                      event: events[index],
                    );
                  }),
                )),
                //),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  //child: Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 40, top: 10),
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
                                return Color.fromARGB(100, 151, 151, 151);
                              }),
                              alignment: Alignment.center,
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Color.fromARGB(
                                              100, 31, 31, 31)))),
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
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0, 30, 10, 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFF00239E),
                            ),
                            onPressed: () async {
                              openDialog();
                            },
                            child: Text(
                              "New Event",
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 30, 0, 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFF00239E),
                            ),
                            onPressed: () async {
                              newAdmin createAdmin = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewAdmin()));
                              await signupRequest(createAdmin.usernameAdmin,
                                  createAdmin.passwordAdmin);
                            },
                            child: Text(
                              "New Admin",
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class CurrBox extends StatefulWidget {
  Event event;
  bool isTrue = true;
  CurrBox({Key? key, required this.event, required this.isTrue})
      : super(key: key);

  @override
  State<CurrBox> createState() => _CurrBoxState();
}

class _CurrBoxState extends State<CurrBox> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getdata() async {}
  @override
  Widget build(BuildContext context) {
    int width = 50;
    int height = 10;
    Size size = Size(width.toDouble(), height.toDouble());
    if (widget.isTrue) {
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
                    widget.event.Date,
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      child: Center(
                          child: ElevatedButton(
                        onPressed: () async {
                          widget.event.Reset();
                          await passengerRequest(widget.event.name)
                              .then((pReq) {
                            if (pReq['status'] == 'success') {
                              for (var passenger in pReq['data']) {
                                widget.event.addPassenger(
                                    Passenger.fromJson(passenger));
                              }

                              for (var person in widget.event.passengers) {
                                if (person.boarded == true) {
                                  if (person.connection == true ||
                                      person.wrongGate == true ||
                                      person.wrongDeparture == true) {
                                    widget.event.p_wrong += 1;
                                    person.status = Status.wrongflight;
                                  } else {
                                    widget.event.p_boarded += 1;
                                  }
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
                                    scanTime: bag["scanTime"],
                                    wrongDestination: bag["wrongDestination"],
                                    status: bag["checked"] == true
                                        ? Status.boarded
                                        : Status.unboarded));
                              }
                            }
                            for (var bag in widget.event.bags) {
                              if (bag.checked == true) {
                                if (bag.wrongDestination == true) {
                                  widget.event.b_wrong += 1;
                                  bag.status = Status.wrongflight;
                                } else {
                                  widget.event.b_boarded += 1;
                                }
                              }

                              if (bag.checked == false) {
                                widget.event.b_unboarded += 1;
                              }
                            }
                          });

                          await competitorRequest(widget.event.name)
                              .then((cReq) {
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
                                        : Position.Ramp,
                                    wrong: 0,
                                    scanned: 0,
                                    startTime:
                                        comp["startTime"] ?? "Not started.",
                                    endTime: comp["endTime"] ?? "Not ended."));
                              }
                            }
                          });

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
                    ),
                    SizedBox(
                      height: 60,
                      child: Center(
                          child: ElevatedButton(
                        onPressed: () async {
                          widget.event.Reset();

                          Map<String, Passenger> passengersForId = {};
                          Map<String, Baggage> bagsForId = {};

                          // add passengers
                          await passengerRequest(widget.event.name)
                              .then((pReq) {
                            if (pReq['status'] == 'success') {
                              for (var passenger in pReq['data']) {
                                final pass = Passenger.fromJson(passenger);
                                widget.event.addPassenger(pass);
                                passengersForId[pass.passengerId] = pass;
                              }
                            }
                          });

                          await bagsRequest(widget.event.name).then((bReq) {
                            if (bReq["status"] == "success") {
                              for (var bag in bReq["data"]) {
                                final b = Baggage(
                                    nameFirst: bag["passengerFirst"],
                                    nameLast: bag["passengerLast"],
                                    originatingAirport: bag["origin"],
                                    destinationAirport: bag["destination"],
                                    weight: bag["weight"],
                                    event: bag["event"],
                                    checked: bag["checked"],
                                    id: bag["_id"],
                                    scanTime: bag["scanTime"],
                                    wrongDestination: bag["wrongDestination"],
                                    status: bag["checked"] == true
                                        ? Status.boarded
                                        : Status.unboarded);

                                widget.event.addBag(b);
                                bagsForId[b.id] = b;
                              }
                            }
                          });

                          await competitorRequest(widget.event.name)
                              .then((cReq) {
                            if (cReq['status'] == 'success') {
                              for (var comp in cReq['data']) {
                                final List<String> bagsScanned =
                                    (comp['bagsScanned'] as List)
                                        .map((e) => e as String)
                                        .toList();
                                final List<String> passengersScanned =
                                    (comp['passengersScanned'] as List)
                                        .map((e) => e as String)
                                        .toList();

                                int wrong = 0;

                                for (var bagId in bagsScanned) {
                                  if (bagsForId[bagId]?.wrongDestination ??
                                      false) {
                                    wrong++;
                                  }
                                }

                                for (var passId in passengersScanned) {
                                  if (passengersForId[passId]?.isWrong ??
                                      false) {
                                    wrong++;
                                  }
                                }

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
                                        : Position.Ramp,
                                    wrong: wrong,
                                    scanned: bagsScanned.length +
                                        passengersScanned.length,
                                    startTime:
                                        comp["startTime"] ?? "Not started.",
                                    endTime: comp["endTime"] ?? "Not ended."));
                              }
                            }
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ScoreboardRoute(event: widget.event)));
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF00239E),
                        ),
                        child: Text(
                          'View Scoreboard',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                          ),
                        ),
                      )),
                    )
                  ].withSpaceBetween(width: 20))
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(50, 15, 50, 0),
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Color.fromARGB(255, 175, 173, 173),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                  child: Text(
                "No Current Event Set",
                style: TextStyle(fontWeight: FontWeight.w500),
              )),
            )),
      );
    }
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
                                      scanTime: bag["scanTime"],
                                      wrongDestination: bag["wrongDestination"],
                                      status: bag["checked"] == true
                                          ? Status.boarded
                                          : Status.unboarded));
                                }
                              }

                              for (var bag in event.bags) {
                                if (bag.checked == true) {
                                  if (bag.wrongDestination == true) {
                                    event.b_wrong += 1;
                                  } else {
                                    event.b_boarded += 1;
                                  }
                                }

                                if (bag.checked == false) {
                                  event.b_unboarded += 1;
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
                                          : Position.Ramp,
                                      wrong: 0,
                                      scanned: 0,
                                      startTime: comp["startTime"],
                                      endTime: comp["endTime"]));
                                }
                              }
                            });

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
