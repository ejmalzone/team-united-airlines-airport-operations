// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/scanning.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/classes/events.dart';
import 'package:airportops_frontend/customerservice/event_details.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:airportops_frontend/classes/competitor.dart';

class CSRRoute extends StatelessWidget {
  CSRRoute({Key? key, Map<String, dynamic>? competitor}) : super(key: key) {
    this.competitor = competitor!;
  }

  late Map<String, dynamic> competitor;

  Event e1 = Event("Line Dancing", 0, 0, 0, 0, 0, 0, [], [], []);

  List<Event> events = [];

  late Event e2 = Event("Cowboy Rodeo", 0, 15, 0, 0, 0, 0, [], [], []);

  final String image = 'icons8-circled-user-male-skin-type-6-96.png';

  // final Competitor c = Competitor(
  //     firstname: 'firstname',
  //     lastname: 'lastname',
  //     stationCode: 'stationCode',
  //     username: 'username',
  //     event: 'event',
  //     bagsScanned: [],
  //     passengersScanned: [],
  //     position: Position.Csr);

  @override
  Widget build(BuildContext context) {
    // Future<Competitor> customerRetreval() async {
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();

    //   String? competitorData = prefs.getString(CUSTOMER_SERVICE_KEY);

    //   String firstName = '';
    //   String lastName = '';
    //   String username = '';

    //   if (competitorData != null) {
    //     Map<String, dynamic> competitor = jsonDecode(competitorData);
    //     firstName = competitor["first"];
    //     lastName = competitor["last"];
    //     username = competitor["username"];
    //   }

    //   return Competitor(
    //       firstname: firstName,
    //       lastname: lastName,
    //       stationCode: '0',
    //       username: username,
    //       event: 'default',
    //       bagsScanned: [],
    //       passengersScanned: [],
    //       position: Position.Csr);
    // }

    final Competitor c = Competitor(
        firstname: competitor["first"],
        lastname: competitor["last"],
        stationCode: 'stationCode',
        username: competitor["username"],
        event: 'event',
        bagsScanned: [],
        passengersScanned: [],
        position: Position.Csr,
        wrong: 0,
        scanned: 0);

    void submit() async {
      //c = await customerRetreval();
    }

    //submit();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileBox(competitior: c, image: image),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(50, 30, 50, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UniversalScanApp()));
                  print("LINK TO SCAN BUTTON");
                },
                child: Text(
                  "SCAN BOARDING PASS",
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 50, bottom: 50),
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color:
                                            Color.fromARGB(100, 31, 31, 31)))),
                      ),
                      child: Image.asset("assets/logout.png",
                          width: 45, alignment: Alignment.centerRight),
                      onPressed: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove(CUSTOMER_SERVICE_KEY);
                        Navigator.of(context).pop();
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
