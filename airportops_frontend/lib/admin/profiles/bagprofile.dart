// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:airportops_frontend/classes/baggage.dart';
import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/enums.dart';
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
                padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: Container(
                    width: double.infinity,
                    height: 179.8,
                    decoration: const BoxDecoration(
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
                          decoration: const BoxDecoration(
                            color: Color(0xFF987700),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: const AlignmentDirectional(-1, -0.7),
                                        child: Text(
                                          "${bag.fullName}'s bag",
                                          style: const TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: const AlignmentDirectional(-1, 0),
                                        child: Text(
                                          '${bag.weight}lbs',
                                          style: const TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 16.5,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 0),
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: bag.status.color,
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
                                        bag.status.name,
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
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
                onPressed: () async {
                  deleteBag(bagId: bag.id);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(206, 47, 124, 2),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                          "${bag.fullName}'bag is successfully deleted!",
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
                child: const Text('Delete Bag')),
          )
        ],
      ),
    );
  }
}
