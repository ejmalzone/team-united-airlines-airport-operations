// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/extensions.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/passenger.dart';
import '../main.dart';

class AdminPassengerProfile extends StatelessWidget {
  AdminPassengerProfile(
      {super.key, required this.title, required this.passenger});

  static final rng = Random();
  static const myStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  static const myStyle2 =
      TextStyle(fontWeight: FontWeight.normal, fontSize: 16);

  // final String reservation = 'R-${rng.nextInt(9000) + 999}';
  final String title;
  late String id;
  final Passenger passenger;
  final Image planeImage =
      Image.asset('assets/airplane_3.png', width: 50, height: 50);

  @override
  Widget build(BuildContext context) {
    String hex = passenger.passengerId;
    BigInt bin = BigInt.parse(hex, radix: 16);
    id = "R-${bin.toString().characters.takeLast(5)}";
    return GestureDetector(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                    color: Color(0xFFE9E9E9),
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 16.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Container(
                                    //   height: 5,
                                    //   decoration: const BoxDecoration(
                                    //     color: Color(0xFF987700),
                                    //   ),
                                    // ),
                                    Text(passenger.fullName,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        passenger.birthday
                                                .toString()
                                                .split(' ')[
                                            0], // | ${passenger.citizenship}',
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text('Time Scanned: ${passenger.scanTime}',
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(fontSize: 12, color: Color(0xFF850000)),
                                      ),
                                    )
                                  ]),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: passenger.status.color,
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
                                      passenger.status.name,
                                      style: TextStyle(
                                        fontFamily: 'Open Sans',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]))),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Divider(color: Colors.black12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text('Reservation Number',
                                  style: TextStyle(fontSize: 14)),
                              Text(id,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(passenger.flightSource,
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: DottedLine(),
                                ),
                                planeImage,
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: DottedLine(),
                                ),
                                Text(passenger.flightDestination,
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ]),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(color: Colors.black12),
                                const Text('Traveler Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                25, 12, 5, 5),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(children: const [
                                                      Text('Citizenship: ',
                                                          style: myStyle),
                                                      Text(
                                                        'United States',
                                                        style: myStyle2,
                                                      ),
                                                    ]),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(children: [
                                                      Text('DOB: ',
                                                          style: myStyle),
                                                      Text(
                                                        passenger.birthday
                                                            .toString()
                                                            .split(' ')[0],
                                                        style: myStyle2,
                                                      )
                                                    ]),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(children: const [
                                                      Text('Fare Type: ',
                                                          style: myStyle),
                                                      Text(
                                                        'United Economy®',
                                                        style: myStyle2,
                                                      )
                                                    ]),
                                                  )
                                                ].withSpaceBetween(height: 4))),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 12, 10, 0),
                                            child: Column(children: [
                                              Text("Seat", style: myStyle),
                                              SizedBox(height: 5),
                                              Text(
                                                  passenger.seat.toString() +
                                                      "-" +
                                                      passenger.row.toString(),
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16))
                                            ]))
                                      ]),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Special Requests:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 20, 5, 5),
                            child: Text('    ${passenger.requestsString}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ])),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          deletePassenger(passengerId: passenger.passengerId);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(206, 47, 124, 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Text(
                                  "${passenger.fullName} is successfully deleted!",
                                  textAlign: TextAlign.center),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            duration: Duration(seconds: 2),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF850000),
                        ),
                        child: const Text('Delete Passenger')),
                  ),
                )
              ],
            ),
          ),
        ), //print('Tapped! ${passenger.passengerId}')
        onTap: () async => await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRImage(passenger.passengerId),
              ),
            ));
  }
}

class PassengerProfile extends StatelessWidget {
  PassengerProfile({super.key, required this.title, required this.passenger});

  static final rng = Random();
  static const myStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  static const myStyle2 =
      TextStyle(fontWeight: FontWeight.normal, fontSize: 16);

  // final String reservation = 'R-${rng.nextInt(9000) + 999}';
  late String id;
  final String title;
  final Passenger passenger;
  final Image planeImage =
      Image.asset('assets/airplane_3.png', width: 50, height: 50);

  @override
  Widget build(BuildContext context) {
    String hex = passenger.passengerId;
    BigInt bin = BigInt.parse(hex, radix: 16);
    id = "R-${bin.toString().characters.takeLast(5)}";
    return GestureDetector(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                    color: Color(0xFFE9E9E9),
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 16.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Container(
                                    //   height: 5,
                                    //   decoration: const BoxDecoration(
                                    //     color: Color(0xFF987700),
                                    //   ),
                                    // ),
                                    Text(passenger.fullName,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500)),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        passenger.birthday
                                                .toString()
                                                .split(' ')[
                                            0], // | ${passenger.citizenship}',
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    )
                                  ]),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: passenger.status.color,
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
                                      passenger.status.name,
                                      style: TextStyle(
                                        fontFamily: 'Open Sans',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]))),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Divider(color: Colors.black12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text('Reservation Number',
                                  style: TextStyle(fontSize: 14)),
                              Text(id,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(passenger.flightSource,
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    )),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: DottedLine(),
                                ),
                                planeImage,
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: DottedLine(),
                                ),
                                Text(passenger.flightDestination,
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ]),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(color: Colors.black12),
                                const Text('Traveler Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                25, 12, 5, 5),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(children: const [
                                                      Text('Citizenship: ',
                                                          style: myStyle),
                                                      Text(
                                                        'United States',
                                                        style: myStyle2,
                                                      ),
                                                    ]),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(children: [
                                                      Text('DOB: ',
                                                          style: myStyle),
                                                      Text(
                                                        passenger.birthday
                                                            .toString()
                                                            .split(' ')[0],
                                                        style: myStyle2,
                                                      )
                                                    ]),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(children: const [
                                                      Text('Fare Type: ',
                                                          style: myStyle),
                                                      Text(
                                                        'United Economy®',
                                                        style: myStyle2,
                                                      )
                                                    ]),
                                                  )
                                                ].withSpaceBetween(height: 4))),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 12, 10, 0),
                                            child: Column(children: [
                                              Text("Seat", style: myStyle),
                                              SizedBox(height: 5),
                                              Text(
                                                  passenger.seat.toString() +
                                                      "-" +
                                                      passenger.row.toString(),
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16))
                                            ]))
                                      ]),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Special Requests:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 20, 5, 5),
                            child: Text('    ${passenger.requestsString}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ])),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              minimumSize: Size(30, 10)),
                          child: const Text('Go Back')),
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF850000),
                          ),
                          child: const Text('Edit')),
                    ],
                  ),
                )
              ],
            ),
          ),
        ), //print('Tapped! ${passenger.passengerId}')
        onTap: () async => await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QRImage(passenger.passengerId),
              ),
            ));
  }
}
