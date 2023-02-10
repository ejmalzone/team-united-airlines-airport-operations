// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:airportops_frontend/events.dart';
import 'package:airportops_frontend/admin/event_details.dart';

class AdminRoute extends StatelessWidget {
  AdminRoute({Key? key}) : super(key: key);

  final Event e1 = Event("Line Dancing", "UA1234", "DTW", DateTime(2023, 5, 5), "IAH", 0, 0, 0, "C7");
  final Event e2 = Event("IDK", "UA5678", "LAX", DateTime(2023, 6, 23), "TPA", 0, 0 ,0, "A5");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: 340,
                    height: 92,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: 100,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Color(0xFF00239E),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Container(
                                      width: 74,
                                      height: 61,
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/icons8-circled-user-male-skin-type-6-96.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 186.5,
                                  height: 82.9,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 16, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      /**add font details */
                                      children: const [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-0.7, -0.7),
                                          child: Text(
                                            'Hello, Admin User',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-0.95, 0),
                                          child: Text('Admin',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 59.6,
                                  height: 50.6,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Image.asset(
                                      'assets/united-airlines-logo-emblem-png-5.png',
                                      width: 114.2,
                                      height: 93.4,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                )),
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
                            print("clicked event");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EventRoute(event: event))
                            );
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