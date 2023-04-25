// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

//https://stackoverflow.com/questions/51579546/how-to-format-datetime-in-flutter
//used the stackoverflow to help me format, also helped me learn about .parse

import 'package:airportops_frontend/admin/admin_profile.dart';
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
import 'package:intl/intl.dart';

class ResultsPage extends StatefulWidget {
  Event event;
  ResultsPage({Key? key, required this.event}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List<Competitor> _foundCompetitors = [];
  @override
  void initState() {
    _foundCompetitors = widget.event.competitors;
    super.initState();
  }

  String firstScan(Event event1) {
    String lowestTime = '';

    List<Competitor> results;
    List<DateTime> dateTimes = [];

    for (Competitor results in event1.competitors) {
      if (results.startTime != 'Not started.') {
        String? dateString = results.startTime;
        DateTime dateTime = DateTime.parse(dateString!);
        dateTimes.add(dateTime);
        dateTimes.sort((a, b) => a.compareTo(b));
        DateTime lowestDateTime = dateTimes.first;

        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
        DateTime dateTime2 = DateTime.parse(formattedDate);

        Duration diff = dateTime2.difference(lowestDateTime);

        lowestTime = diff.toString();
      }
    }
    return '$lowestTime is how long the event has been going on for';
  }

  String timeGraph(Event event1) {
    String lowestTime = '';
    String totalTimes = '';
    String totalNames = '';
    String masterListStr = '';

    List<Competitor> results;
    List<String> dateTimes = [];
    List<String> usernameString = []; //username string
    List<String> masterList = [];

    for (Competitor results in event1.competitors) {
      if (results.startTime != 'Not started.' &&
          results.endTime != 'Not started.') {
        String? dateString = results.startTime;
        String? dateString2 = results.endTime;
        String nameString = results.username; //username

        DateTime dateTime = DateTime.parse(dateString!);

        DateTime dateTime2 = DateTime.parse(dateString2!);

        Duration difference = dateTime2.difference(dateTime);

        lowestTime = difference.toString();
        dateTimes.add(lowestTime);
        usernameString.add(nameString); //add name  
      }
    }

    totalTimes = dateTimes.join(', ');
    totalNames = usernameString.join(', ');

    //print(totalNames);
    //print(totalTimes);

    for (int i = 0; i < usernameString.length && i < dateTimes.length; i++) {
      masterList.add('${usernameString[i]} took ${dateTimes[i]}');
    }

    masterListStr = masterList.join(', ');
    //print(masterListStr);


    return masterListStr;
  }

  @override
  Widget build(BuildContext context) {
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
                  firstScan(widget.event),
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
                  timeGraph(widget.event),
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
