// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:flutter/material.dart';


/* Creates Profile box
  params: competitor, icon image */
class ProfileBox extends StatelessWidget {
  ProfileBox({super.key, required this.competitior, required this.image});

  final Competitor competitior;
  final String image;

  late String image_route = 'assets/$image';
  late String position = competitior.position.name;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: Container(
            width: 340,
            height: 92,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0x33000000),
                  offset: Offset(0, 2),
                )
              ],
              shape: BoxShape.rectangle,
            ),
            alignment: AlignmentDirectional(0, 0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 100,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Color(0xFF00239E),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                            child: Container(
                              width: 74,
                              height: 61,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  image_route,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 186.5,
                          height: 82.9,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              /**add font details */
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-0.7, -0.7),
                                  child: Text(
                                    'Hello, ${competitior.firstname} ${competitior.lastname}',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-0.95, 0),
                                  child: Text(position,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 59.6,
                          height: 50.6,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Image.asset(
                              'assets/united-airlines-logo-emblem-png-5.png',
                              width: 114.2,
                              height: 93.4,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }
}

/* Creates passenger card
param: passenger
*/
class PCard extends StatelessWidget {
  const PCard({super.key, required this.p});

  final Passenger p;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tapped card');
      },
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(30, 10, 30, 0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Color.fromARGB(255, 238, 238, 238),
          elevation: 5,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 8, 0, 0),
                      child: Text(
                        p.fullName,
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 6, 0, 10),
                      child: Text(
                        'R-${p.reservationNum}| ${p.flightSource} to ${p.flightDestination}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 10, 0),
                      child: Container(
                        width: 70,
                        height: 34.7,
                        decoration: BoxDecoration(
                          color: Color(0xFF850000),
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
                            p.status.name,
                            style: TextStyle(
                                fontFamily: 'Open Sans',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}