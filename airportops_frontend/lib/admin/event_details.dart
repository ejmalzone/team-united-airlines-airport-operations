// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:airportops_frontend/admin/toggles/competitor_page.dart';
import 'package:airportops_frontend/admin/toggles/csr.dart';
import 'package:airportops_frontend/admin/new_passenger.dart';
import 'package:airportops_frontend/admin/toggles/csr.dart';
import 'package:airportops_frontend/admin/toggles/ramp.dart';
import 'package:airportops_frontend/customerservice/customerservice_profile.dart';
import 'package:airportops_frontend/main.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:flutter/material.dart';
import '../classes/events.dart';
import '../widgets.dart';

class EventRoute extends StatefulWidget {
  Event event;
  EventRoute({Key? key, required this.event}) : super(key: key);

  @override
  EventRouteState createState() => EventRouteState();
}

class EventRouteState extends State<EventRoute> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.event.name),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab( 
                    icon: Icon(Icons.airplane_ticket, color: Colors.black),
                  ),
                  Tab( 
                    icon: Icon(Icons.luggage, color: Colors.black),
                  ),
                  Tab( 
                    icon: Icon(Icons.person, color: Colors.black),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    AdminPassengers(event: widget.event),
                    AdminRamp(event: widget.event),
                    CompetitorsPage(event: widget.event)
              
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
