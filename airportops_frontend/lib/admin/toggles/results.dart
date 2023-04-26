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

import 'package:jiffy/jiffy.dart';
import 'package:airportops_frontend/database.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ResultsPage extends StatefulWidget {
  Event event;
  ResultsPage({Key? key, required this.event}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List<Competitor> _foundCompetitors = [];
  late List<GraphData> chartData = [];
  late TooltipBehavior tooltip;
  @override
  void initState() {
    _foundCompetitors = widget.event.competitors;
    chartData = getChartData();
    tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  String eventDuration(Event event1) {
    String lowestTime = '';

    List<Competitor> results;
    List<DateTime> dateTimes = [];

    if (event1.competitors.isNotEmpty) {
      String format = '00:00';
      List<String> parts = [];
      int hours = 0;
      int minutes = 0;
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
      format = lowestTime.substring(0, lowestTime.length - 7);
      parts = format.split(":");
      parts = format.split(":");
      hours = int.parse(parts[0]);
      minutes = int.parse(parts[1]);

      return "$hours hours and $minutes minutes";
    }
    return "";
  }

  double toMinutes(String time) {
    List<String> parts = time.split(":");
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    double totalTimeInMinutes = hours * 60 + minutes + seconds / 60;
    return double.parse(totalTimeInMinutes.toStringAsFixed(3));
  }

  Map<String, double> timeGraph(Event event1) {
    String lowestTime = '';
    final Map<String, double> graphdata = {};
    print(event1.competitors.length);
    List<Competitor> results;
    List<double> dateTimes = [];
    List<String> usernameString = []; //username string
    List<String> masterList = [];

    for (Competitor results in event1.competitors) {
      results.startTime ??= 'Not started.';
      results.endTime ??= 'Not ended.';
      if (results.startTime != null && results.endTime != null && results.startTime != 'Not started.' &&
          results.endTime! != 'Not ended.') {
        String? dateString = results.startTime;
        String? dateString2 = results.endTime;
        String nameString = results.fullname; //username

        DateTime dateTime = DateTime.parse(dateString!);

        DateTime dateTime2 = DateTime.parse(dateString2!);

        Duration difference = dateTime2.difference(dateTime);

        lowestTime = difference.toString();
        String formattedTime = lowestTime.substring(0, lowestTime.length - 7);
        dateTimes.add(toMinutes(formattedTime));
        usernameString.add(nameString); 
      }
    }

    // totalTimes = dateTimes.join(', ');
    // totalNames = usernameString.join(', ');

    print(dateTimes);
    print(usernameString);

    for (int i = 0; i < usernameString.length && i < dateTimes.length; i++) {
      masterList.add('${usernameString[i]} took ${dateTimes[i]}');
      graphdata[usernameString[i]] = dateTimes[i];
    }

    // masterListStr = masterList.join(', ');

    print(graphdata);

    return graphdata;
  }

  List<GraphData> getChartData() {
    final List<GraphData> data = [];
    Map<String, double> graphdata = timeGraph(widget.event);
    for (var item in graphdata.entries) {
      data.add(GraphData(item.key, item.value));
    }

    return data;
  }

  Widget displayGraph() {
    if (chartData.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Text("No data to show"),
        ),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                //height: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      eventDuration(widget.event),
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF00239E),
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Event Duration',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                //height: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      widget.event.competitors.length.toString(),
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF00239E),
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Total amount of competitors',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SfCartesianChart(
              title: ChartTitle(
                  text: "Scanning durations",
                  textStyle: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF008525),
                  )),
              tooltipBehavior: tooltip,
              series: <ChartSeries>[
                BarSeries<GraphData, String>(
                    name: 'Duration',
                    dataSource: chartData,
                    xValueMapper: (GraphData item, _) => item.name,
                    yValueMapper: (GraphData item, _) => item.time,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true)
              ],
              primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Competitors')),
              primaryYAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                title: AxisTitle(text: 'Time in minutes'),
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 100,
          height: 85,
          alignment: AlignmentDirectional(0, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(30, 15, 30, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.event.Date,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Analysis for ${widget.event.name}',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 201, 201, 201),
            ),
            //height: 100,
            child: displayGraph()),
        Flexible(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 201, 201, 201),
            ),
          ),
        )
      ],
    );
  }
}

class GraphData {
  GraphData(this.name, this.time);
  final String name;
  final double time;
}
