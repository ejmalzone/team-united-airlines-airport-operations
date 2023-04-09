import 'dart:math';

import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/passenger.dart';
import '../main.dart';

class PassengerProfile extends StatelessWidget {
  PassengerProfile({super.key, required this.title, required this.passenger});

  static final rng = Random();
  static const myStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5);

  final String reservation = 'R-${rng.nextInt(9000) + 999}';
  final String title;
  final Passenger passenger;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 16.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(children: <Widget>[
                                Text(passenger.fullName,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 24)),
                                Text(
                                  passenger.birthday.toString().split(
                                      ' ')[0], // | ${passenger.citizenship}',
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(fontSize: 12),
                                )
                              ]),
                              Container(
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: passenger.status.color,
                                      borderRadius: const BorderRadius.all(
                                          Radius.elliptical(25, 25)),
                                      border: Border.all(
                                          color: passenger.status.color,
                                          width: 8)),
                                  child: Text(passenger.status.name.titleCase(),
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white70))),
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
                              Text(reservation,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(passenger.flightSource,
                                    style: TextStyle(fontSize: 12)),
                                Text(passenger.flightDestination,
                                    style: TextStyle(fontSize: 12)),
                              ]),
                          SizedBox(height: 4),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                /*Text(
                                passenger.flightSourceDate
                                    .toLocal()
                                    .toIso8601String(),
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),*/
                                Expanded(child: Text('. ' * 1000, maxLines: 1)),
                                /*Text(
                                passenger.flightDestinationDate
                                    .toLocal()
                                    .toIso8601String(),
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),*/
                              ]),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Traveler Details',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 12, 5, 5),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(children: const [
                                                Text('Citizenship: ',
                                                    style: myStyle),
                                                Text('United States'),
                                              ]),
                                              Row(children: [
                                                Text('DOB: ', style: myStyle),
                                                Text(passenger.birthday
                                                    .toString()
                                                    .split(' ')[0])
                                              ]),
                                              Row(children: const [
                                                Text('Fare Type: ',
                                                    style: myStyle),
                                                Text('United Polaris®')
                                              ])
                                            ].withSpaceBetween(height: 4))),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 12, 10, 0),
                                        child: Column(children: [
                                          Text("Seat",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)),
                                          SizedBox(height: 5),
                                          Text(
                                              passenger.seat.toString() +
                                                  "-" +
                                                  passenger.row.toString(),
                                              style:
                                                  TextStyle(color: Colors.red))
                                        ]))
                                  ])
                            ],
                          ),
                          SizedBox(height: 10),
                          Text('Special Requests:',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('    ${passenger.requestsString}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ])),
                Padding(
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
