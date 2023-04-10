// ignore_for_file: prefer_const_constructors

import 'package:airportops_frontend/admin/new_passenger.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';

import '../../classes/events.dart';
import 'competitor_page.dart';

class AdminPassengers extends StatefulWidget {
  Event event;
  AdminPassengers({Key? key, required this.event}) : super(key: key);

  @override
  State<AdminPassengers> createState() => _AdminPassengersState();
}

class _AdminPassengersState extends State<AdminPassengers> {
  List<Passenger> _foundPassengers = [];
  @override
  void initState() {
    _foundPassengers = widget.event.passengers;
    super.initState();
  }

  void filter(String keyword) {
    List<Passenger> results = [];
    if (keyword.isEmpty) {
      results = widget.event.passengers;
    } else {
      results = widget.event.passengers
          .where(
              (p) => p.fullName.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundPassengers = results;
    });
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
                      '${widget.event.name} Passenger Status',
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
                      widget.event.p_boarded.toString(),
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF008525),
                        fontSize: 50,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'BOARDED',
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
              Container(
                width: 100,
                height: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      widget.event.p_unboarded.toString(),
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        color: Color(0xFF850000),
                        fontSize: 50,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'UNBOARDED',
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
              Container(
                width: 100,
                height: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      widget.event.p_wrong.toString(),
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        color: Color(0xFFBCBF14),
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
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(50, 10, 50, 8),
          child: TextField(
            decoration: const InputDecoration(
                labelText: 'Search for passengers',
                suffixIcon: Icon(Icons.search)),
            onChanged: (value) {
              filter(value);
            },
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
              children: List.generate(_foundPassengers.length, (index) {
                return PCard(p: _foundPassengers[index]);
              }),
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: Center(
              child: ElevatedButton(
            onPressed: () async {
              print("pressed add passengers");
              print(widget.event.passengers);

              Passenger newPassenger = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewPassenger()));

              setState(() {
                widget.event.addPassenger(newPassenger);
                var newPass = createPassenger(
                    first: newPassenger.nameFirst,
                    last: newPassenger.nameLast,
                    DOB: newPassenger.birthday.toIso8601String(),
                    row: newPassenger.row,
                    seat: newPassenger.seat,
                    originAirport: newPassenger.flightSource,
                    destinationAirport: newPassenger.flightDestination,
                    event: widget.event.name);
              });
              for (int i = 0; i < widget.event.passengers.length; i++) {
                print(widget.event.passengers[i].fullName);
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF00239E),
            ),
            child: Text(
              "Add Passenger",
              style: TextStyle(
                fontFamily: 'Open Sans',
              ),
            ),
          )),
        )
      ],
    );
  }
}
