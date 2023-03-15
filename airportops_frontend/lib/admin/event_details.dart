// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:airportops_frontend/admin/competitor_page.dart';
import 'package:airportops_frontend/admin/new_passenger.dart';
import 'package:airportops_frontend/main.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:flutter/material.dart';
import '../classes/events.dart';
import '../widgets.dart';

class EventRoute extends StatefulWidget {
  Event event;
  EventRoute({Key? key, required this.event}) : super(key: key);

  @override
  EventRouteState createState() => EventRouteState();
}

class EventRouteState extends State<EventRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 100,
              height: 85,
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 15, 30, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.event.Date,
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Event Status',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                            child: Text(
                              'View Competitors >',
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                color: Color(0xFF00239E),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => CompetitorsPage(event: widget.event,)));
                              print('Pressed');
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 100,
              height: 100,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          widget.event.numBoarded.toString(),
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            color: Color(0xFF008525),
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'BOARDED',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: VerticalDivider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          widget.event.numNoShow.toString(),
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            color: Color(0xFF850000),
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'NO SHOW',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: VerticalDivider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          widget.event.numWrong.toString(),
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFBCBF14),
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'WRONG',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(50, 10, 50, 8),
              child: TextField(
                decoration: const InputDecoration(
                    labelText: 'Search for passengers',
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 201, 201, 201),
                ),
                child: ListView(
                  // mainAxisSize: MainAxisSize.max,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:
                      List.generate(widget.event.passengers.length, (index) {
                    return PCard(p: widget.event.passengers[index]);
                  }),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: Center(
                  child: ElevatedButton(
                onPressed: () async {
                  print("pressed add passengers");
                  print(widget.event.passengers);

                  var newPassenger = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewPassenger()));

                  setState(() {
                    widget.event.addPassenger(newPassenger);
                  });
                  for (int i = 0; i < widget.event.passengers.length; i++) {
                    print(widget.event.passengers[i].fullName);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF00239E),
                ),
                child: Text(
                  "Add Passenger",
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
