// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:airportops_frontend/classes/competitor.dart';
// import 'package:airportops_frontend/database.dart';
// import 'package:airportops_frontend/enums.dart';
// import 'package:airportops_frontend/classes/passenger.dart';
// import 'package:airportops_frontend/scanning.dart';
// import 'package:airportops_frontend/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:airportops_frontend/classes/events.dart';
// import 'package:airportops_frontend/customerservice/event_details.dart';
// import 'package:jiffy/jiffy.dart';

// class CSRRoute extends StatelessWidget {
//   CSRRoute({Key? key, Map<String, dynamic>? competitor}) : super(key: key) {
//     this.competitor = competitor!;
//   }

//   late Map<String, dynamic> competitor;

//   // final Competitor c = Competitor(
//   //     firstname: 'firstname',
//   //     lastname: 'lastname',
//   //     stationCode: 'stationCode',
//   //     username: 'username',
//   //     event: 'event',
//   //     bagsScanned: [],
//   //     passengersScanned: [],
//   //     position: Position.Csr);
//   final String image = 'icons8-circled-user-male-skin-type-6-96.png';

//   @override
//   Widget build(BuildContext context) {
//     final Competitor c = Competitor(
//         firstname: competitor["first"],
//         lastname: competitor["last"],
//         stationCode: 'stationCode',
//         username: competitor["username"],
//         event: 'event',
//         bagsScanned: [],
//         passengersScanned: [],
//         position: Position.Csr);

//     void submit() {
//       Navigator.of(context).pop();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ProfileBox(competitior: c, image: image),
//             Padding(
//               padding: EdgeInsetsDirectional.fromSTEB(50, 30, 50, 0),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   backgroundColor: Colors.green,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => UniversalScanApp()));
//                   print("LINK TO SCAN BUTTON");
//                 },
//                 child: Text(
//                   "UNIVERSAL SCANNER",
//                   style: TextStyle(
//                     fontFamily: 'Open Sans',
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// /** 
// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: GestureDetector(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Align(
//                 alignment: AlignmentDirectional(0, 0),
//                 child: Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                   child: Container(
//                     width: 340.1,
//                     height: 124,
//                     decoration: BoxDecoration(
//                       color: Colors.white, //white?
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 4,
//                           color: Color(0x33000000),
//                           offset: Offset(0, 2),
//                         )
//                       ],
//                       shape: BoxShape.rectangle,
//                     ),
//                     alignment: AlignmentDirectional(0, 0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Container(
//                           width: 100,
//                           height: 5,
//                           decoration: BoxDecoration(
//                             color: Color(0xFF00239E),
//                           ),
//                         ),
//                         Expanded(
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Align(
//                                 alignment: AlignmentDirectional(0, -1),
//                                 child: Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       5, 0, 0, 0),
//                                   child: Container(
//                                     width: 73.9,
//                                     height: 66.3,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white, //white?
//                                     ),
//                                     child: Align(
//                                       alignment: AlignmentDirectional(0, 0),
//                                       child: Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 10, 0, 0),
//                                         child: Container(
//                                           width: 120,
//                                           height: 120,
//                                           clipBehavior: Clip.antiAlias,
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                           ),
//                                           child: Image.asset(
//                                             'assets/images/icons8-circled-user-male-skin-type-6-96.png',
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 width: 186.5,
//                                 height: 82.9,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white, //white?
//                                 ),
//                                 child: Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       0, 16, 0, 0),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Align(
//                                         alignment:
//                                             AlignmentDirectional(-0.7, -0.7),
//                                         child: Text(
//                                           'Hello, User',
//                                           style: TextStyle(
//                                             fontFamily: 'Poppins',
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ),
//                                       Align(
//                                         alignment:
//                                             AlignmentDirectional(-0.95, 0),
//                                         child: Text(
//                                           'Ramp/Customer Services',
//                                           style: TextStyle(
//                                             fontFamily: 'Poppins',
//                                             fontSize: 10,
//                                             fontWeight: FontWeight.normal,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Align(
//                                 alignment: AlignmentDirectional(0, -0.85),
//                                 child: Container(
//                                   width: 59.6,
//                                   height: 50.6,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white, //white?
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         10, 10, 0, 0),
//                                     child: Image.asset(
//                                       'assets/images/united-airlines-logo-emblem-png-5.png',
//                                       width: 114.2,
//                                       height: 104.3,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: AlignmentDirectional(0, 0),
//                 child: Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                   child: Container(
//                     width: 340.1,
//                     height: 124,
//                     decoration: BoxDecoration(
//                       color: Colors.white, //white
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 4,
//                           color: Color(0x33000000),
//                           offset: Offset(0, 2),
//                         )
//                       ],
//                       shape: BoxShape.rectangle,
//                     ),
//                     alignment: AlignmentDirectional(0, 0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Container(
//                           width: 100,
//                           height: 5,
//                           decoration: BoxDecoration(
//                             color: Color(0xFF00239E),
//                           ),
//                         ),
//                         Expanded(
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsetsDirectional.fromSTEB(
//                                         5, 0, 0, 0),
//                                     child: Text(
//                                       'Number of tickets/bags scanned:',
//                                       style: TextStyle(
//                                         fontFamily: 'Poppins',
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: AlignmentDirectional(0, 0),
//                 child: Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                   child: Container(
//                     width: 340.1,
//                     height: 150,
//                     decoration: BoxDecoration(
//                       color: Colors.white, //white?
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 4,
//                           color: Color(0x33000000),
//                           offset: Offset(0, 2),
//                         )
//                       ],
//                       shape: BoxShape.rectangle,
//                     ),
//                     alignment: AlignmentDirectional(0, 0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Container(
//                           width: 100,
//                           height: 5,
//                           decoration: BoxDecoration(
//                             color: Color(0xFF00239E),
//                           ),
//                         ),
//                         Expanded(
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: [
//                                   Column(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         children: [
//                                           Text(
//                                             'Current Event',
//                                             style: TextStyle(
//                                               fontFamily: 'Poppins',
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 15, 0, 0),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           children: [
//                                             Text(
//                                               'Current Date',
//                                               style: TextStyle(
//                                                 fontFamily: 'Poppins',
//                                                 fontWeight: FontWeight.normal,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0, 20, 0, 0),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsetsDirectional
//                                                   .fromSTEB(0, 5, 0, 0),
//                                               child: Text(
//                                                 'Event Name',
//                                                 style: TextStyle(
//                                                   fontFamily: 'Poppins',
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(50, 30, 50, 0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: Colors.green,
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => UniversalScanApp()));
//                     print("LINK TO SCAN BUTTON");
//                   },
//                   child: Text(
//                     "SCAN",
//                     style: TextStyle(
//                       fontFamily: 'Open Sans',
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// */
