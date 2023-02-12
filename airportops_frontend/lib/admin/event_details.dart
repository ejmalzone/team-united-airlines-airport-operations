// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../events.dart';

class EventRoute extends StatelessWidget {
  EventRoute({super.key, required this.event});

  final Event event;

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
                          event.Date,
                          style:
                              TextStyle(
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
                          style:
                              TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        TextButton(
                          child: Text('View Competitors >',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              color: Color(0xFF00239E),
                            ),
                          ),
                          onPressed: () {
                            print('Pressed');
                          }
                        )
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
                          event.numBoarded.toString(),
                          style:
                              TextStyle(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF008525),
                                    fontSize: 50,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        Text(
                          'BOARDED',
                          style:
                              TextStyle(
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
                          event.numNoShow.toString(),
                          style:
                              TextStyle(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFF850000),
                                    fontSize: 50,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        Text(
                          'NO SHOW',
                          style:
                              TextStyle(
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
                          event.numWrong.toString(),
                          style:
                              TextStyle(
                                    fontFamily: 'Open Sans',
                                    color: Color(0xFFBCBF14),
                                    fontSize: 50,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        Text(
                          'WRONG',
                          style:
                              TextStyle(
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
          ],
        ),
      ),
    );
  }
}
