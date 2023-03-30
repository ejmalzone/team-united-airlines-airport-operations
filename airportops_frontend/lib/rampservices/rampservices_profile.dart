// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/scanning.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/classes/events.dart';
import 'package:airportops_frontend/rampservices/event_details.dart';
import 'package:jiffy/jiffy.dart';

class BaggageRoute extends StatelessWidget {
  BaggageRoute({Key? key}) : super(key: key);

  final String image = 'icons8-circled-user-male-skin-type-6-96.png';
  final Competitor c = Competitor(
      firstname: 'firstname',
      lastname: 'lastname',
      stationCode: 'stationCode',
      username: 'username',
      event: 'event',
      bagsScanned: [],
      passengersScanned: [],
      position: Position.Ramp);

  @override
  Widget build(BuildContext context) {
    void submit() {
      Navigator.of(context).pop();
    }

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
                  "UNIVERSAL SCANNER",
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                  ),
                ),
              ),
            ),
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
                          builder: (context) => HoneywellScanApp()));
                  print("link to honeywell scanner");
                },
                child: Text(
                  "HONEYWELL SCAN",
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
