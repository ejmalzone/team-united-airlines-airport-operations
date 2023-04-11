// ignore_for_file: prefer_const_constructors

import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';

class CompProfile extends StatefulWidget {
  Competitor c;
  CompProfile({Key? key, required this.c}) : super(key: key);

  @override
  State<CompProfile> createState() => CompProfileState();
}

class CompProfileState extends State<CompProfile> {
  final String image = 'icons8-circled-user-male-skin-type-6-96.png';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileBox(competitior: widget.c, image: image),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Container(
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
                        widget.c.scanned.toString(),
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF008525),
                          fontSize: 50,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'SCANNED',
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
                Center(
                  child: Container(
                    width: 120,
                    height: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          widget.c.wrong.toString(),
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            color: Color(0xFF850000),
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
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(30, 10, 0,0),
          child: SizedBox(
            height: 40,
            child: Text(
              'Scanning History',
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            )
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
              children: List.generate(widget.c.passengersScanned.length, (index) {
                return PCard(p: widget.c.passengersScanned[index]);
              }),
            ),
          ),
        )
      ],
    );
  }
}
