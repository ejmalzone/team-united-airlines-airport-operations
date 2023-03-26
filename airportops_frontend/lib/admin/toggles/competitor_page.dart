// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:airportops_frontend/classes/events.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';

import '../../classes/competitor.dart';

class CompetitorsPage extends StatefulWidget {
  Event event;

  CompetitorsPage({Key? key, required this.event}) : super(key: key);

  @override
  State<CompetitorsPage> createState() => _CompetitorsPageState();
}

class _CompetitorsPageState extends State<CompetitorsPage> {
  final String image = 'icons8-circled-user-male-skin-type-6-96.png';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        TextField(
          decoration: const InputDecoration(
              labelText: 'Search for Employees',
              suffixIcon: Icon(Icons.search)),
        ),
        Flexible(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              // mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(widget.event.competitors.length, (index) {
                return EBox(
                    competitior: widget.event.competitors[index], image: image);
              }),
            ),
          ),
        ),
      ]),
    );
  }
}

class EBox extends StatelessWidget {
  EBox({super.key, required this.competitior, required this.image});

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
                                    '${competitior.firstname} ${competitior.lastname}',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
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
                              competitior.position.icon,
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
