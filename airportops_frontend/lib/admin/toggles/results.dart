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
import 'package:airportops_frontend/database.dart';

class ResultsPage extends StatefulWidget {
  Event event;
  ResultsPage({Key? key, required this.event}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List<Event> _foundResults = [];
  @override
  void initState() {
    _foundResults = widget.event.results;
    super.initState();
  }

  void filter(String keyword) {
    List<Event> results = [];
    if (keyword.isEmpty) {
      results = widget.event.results;
    } else {
      results = widget.event.results
          .where((b) => b.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.event.competitors.length.toString());
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Results page for: ${widget.event.name}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'How long did the rodeo take?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Total number of competitors: ${widget.event.competitors.length.toString()}',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'time series graph of how long it took with when people were checked in.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
