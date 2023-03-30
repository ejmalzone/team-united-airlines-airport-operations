// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:airportops_frontend/classes/baggage.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class BagProfile extends StatelessWidget {
  Baggage bag;
  BagProfile({super.key, required this.bag});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: Container(
                    width: double.infinity,
                    height: 179.8,
                    decoration: BoxDecoration(
                      color: Color(0xFFE9E9E9),
                      boxShadow: [
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
                            color: Color(0xFF987700),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(-1, -0.7),
                                        child: Text(
                                          "${bag.fullName}'s bag",
                                          style: TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Text(
                                          'R-1234',
                                          style: TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(23),
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(
                                        '[Status]',
                                        style: TextStyle(
                                          fontFamily: 'Open Sans',
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '7:50am',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    '${bag.originatingAirport}',
                                    style: TextStyle(
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    'May 5th',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    width: 300,
                                    child: DottedLine(),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '5:40am',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    '${bag.destinationAirport}',
                                    style: TextStyle(
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    'May 5th',
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ))),
          )
        ],
      ),
    );
  }
}


// Align(
//           alignment: AlignmentDirectional(0, 0),
//           child: Padding(
//             padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//             child: Container(
//               width: 340.1,
//               height: 179.8,
//               decoration: BoxDecoration(
//                 color: Color(0xFFE9E9E9),
//                 boxShadow: [
//                   BoxShadow(
//                     blurRadius: 4,
//                     color: Color(0x33000000),
//                     offset: Offset(0, 2),
//                   )
//                 ],
//                 shape: BoxShape.rectangle,
//               ),
//               alignment: AlignmentDirectional(0, 0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Container(
//                     width: 100,
//                     height: 5,
//                     decoration: BoxDecoration(
//                       color: Color(0xFF987700),
//                     ),
//                   ),
//                   Expanded(
//                     child: Row(

//                       children: [
//                         Container(
//                           width: 186.5,
//                           height: 82.9,
//                           decoration: BoxDecoration(
//                             color: Color(0xFFE9E9E9),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 Align(
//                                   alignment: AlignmentDirectional(-1, -0.7),
//                                   child: Text(
//                                     'Joel Fester',
//                                     style:
//                                         TextStyle(
//                                               fontFamily: 'Open Sans',
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: AlignmentDirectional(-1, 0),
//                                   child: Text(
//                                     'R-1234',
//                                     style: TextStyle(
//                                           fontFamily: 'Open Sans',
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
//                           child: Container(
//                             width: 70,
//                             height: 34.7,
//                             decoration: BoxDecoration(
//                               color: Color(0xFF850000),
//                               borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(23),
//                                 bottomRight: Radius.circular(20),
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(20),
//                               ),
//                             ),
//                             child: Align(
//                               alignment: AlignmentDirectional(0, 0),
//                               child: Text(
//                                 '[Status]',
//                                 style: TextStyle(
//                                       fontFamily: 'Open Sans',
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Column(
//                           mainAxisSize: MainAxisSize.max,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '7:50am',
//                               style: TextStyle(
//                                     fontFamily: 'Open Sans',
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                             ),
//                             Text(
//                               'IAH',
//                               style: TextStyle(
//                                     fontFamily: 'Open Sans',
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                             ),
//                             Text(
//                               'May 5th',
//                               style: TextStyle(
//                                     fontFamily: 'Open Sans',
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             // SizedBox(
//                             //   width: 200,
//                             //   child: StyledDivider(
//                             //     thickness: 2,
//                             //     color: Color(0xFF7F7F7F),
//                             //     lineStyle: DividerLineStyle.dotted,
//                             //   ),
//                             // ),
//                             Expanded(child: Text('. ' * 1000, maxLines: 1))
//                           ],
//                         ),
//                         Column(
//                           mainAxisSize: MainAxisSize.max,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               '5:40am',
//                               style: TextStyle(
//                                     fontFamily: 'Open Sans',
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                             ),
//                             Text(
//                               'DTW',
//                               style: TextStyle(
//                                     fontFamily: 'Open Sans',
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                             ),
//                             Text(
//                               'May 5th',
//                               style: TextStyle(
//                                     fontFamily: 'Open Sans',
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )