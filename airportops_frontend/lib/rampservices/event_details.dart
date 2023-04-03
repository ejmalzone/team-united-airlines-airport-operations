// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/scanning.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/classes/events.dart';

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
                          event.p_boarded.toString(),
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            color: Color(0xFF008525),
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'COMPLETED',
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
                    width: 120,
                    height: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          event.p_wrong.toString(),
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            color: Color(0xFFBCBF14),
                            fontSize: 50,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'WRONG FLIGHT',
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
                  children: List.generate(event.passengers.length, (index) {
                    return PCard(p: event.passengers[index]);
                  }),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: Center(
                  child: ElevatedButton(
                onPressed: () async {
                  print("SCAN");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UniversalScanApp()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  "SCAN",
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

// class PCard extends StatelessWidget {
//   const PCard({super.key, required this.p});

//   final Passenger p;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         print('tapped card');
//       },
//       child: Padding(
//         padding: EdgeInsetsDirectional.fromSTEB(25, 8, 25, 0),
//         child: Card(
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           color: Color(0xFFD9D9D9),
//           elevation: 5,
//           child: Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(11, 9, 0, 0),
//                       child: Text(
//                         p.fullName,
//                         style: TextStyle(
//                           fontFamily: 'Open Sans',
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(10, 6, 0, 10),
//                       child: Text(
//                         //'R-${p.reservationNum}|
//                         '${p.flightSource} to ${p.flightDestination}',
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontFamily: 'Open Sans',
//                           fontSize: 10,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     )
//                   ],
//                 ),
//                 Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Padding(
//                       padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
//                       child: Container(
//                         width: 70,
//                         height: 34.7,
//                         decoration: BoxDecoration(
//                           //color: Colors.black,
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(23),
//                             bottomRight: Radius.circular(20),
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                         ),
//                         child: Align(
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Text(
//                             p.status.name,
//                             style: TextStyle(
//                                 fontFamily: 'Open Sans',
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 10),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
