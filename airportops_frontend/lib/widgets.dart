// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:airportops_frontend/admin/profiles/bagprofile.dart';
import 'package:airportops_frontend/classes/baggage.dart';
import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/main.dart';
import 'package:airportops_frontend/widgets/passenger_profile.dart';
import 'package:flutter/material.dart';

/* Creates Profile box
  params: competitor, icon image */
class AdminProfileBox extends StatelessWidget {
  AdminProfileBox({super.key, required this.admin, required this.image});

  final Admin admin;
  final String image;

  late String image_route = 'assets/$image';
  late String position = admin.position.name;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 0),
          child: Container(
            width: double.infinity,
            //height: 92,
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 10),
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
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Hello, ${admin.firstname} ${admin.lastname}',
                                  style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(position,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
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
                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 5, 0),
                          child: Image.asset(
                            admin.position.icon,
                            width: 114.2,
                            height: 93.4,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }
}

class ProfileBox extends StatelessWidget {
  ProfileBox({super.key, required this.competitior, required this.image});

  final Competitor competitior;
  final String image;

  late String image_route = 'assets/${image}';
  late String position = competitior.position.name;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 0),
          child: Container(
            width: double.infinity,
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
                      color: Color(0xFF987700),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
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
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${competitior.firstname} ${competitior.lastname}',
                                  style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('@${competitior.username}',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
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
                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 5, 0),
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
                ]),
          ),
        ));
  }
}

/* Creates passenger card
param: passenger
*/
class PCard extends StatefulWidget {
  final Passenger p;
  PCard({super.key, required this.p});

  @override
  State<PCard> createState() => PCardState();
}

class PCardState extends State<PCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text("${widget.p.fullName}'s Profile"),
                      backgroundColor: Colors.black,
                      centerTitle: true,
                    ),
                    body: PassengerProfile(
                        title: "${widget.p.fullName} 's Profile",
                        passenger: widget.p))));
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
                        widget.p.fullName,
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
                        //'R-${p.reservationNum}|
                        '${widget.p.passengerId} | ${widget.p.flightSource} to ${widget.p.flightDestination}',
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
                          color: widget.p.status.color,
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
                            widget.p.status.name,
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

class LoginInput extends StatefulWidget {
  final TextEditingController textController;
  final bool obscure;
  const LoginInput(
      {Key? key, required this.textController, required this.obscure})
      : super(key: key);

  @override
  State<LoginInput> createState() => _LoginState();
}

class _LoginState extends State<LoginInput> {
  @override
  dispose() {
    widget.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(fillColor: Colors.grey, filled: true),
        controller: widget.textController,
        obscureText: widget.obscure);
  }
}

class CountrySelector extends StatefulWidget {
  final List<String> countries;
  final Function(String) onSelect;
  final TextEditingController controller;
  final String label;

  CountrySelector(
      {required this.countries,
      required this.onSelect,
      required this.controller,
      required this.label});

  @override
  _CountrySelectorState createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  String _selectedCountry = "Select a Country";

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: _selectedCountry,
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(),
      ),
      items: [
        DropdownMenuItem(
          child: Text("Select a Country"),
          value: "Select a Country",
        ),
        ...widget.countries.map(
          (country) => DropdownMenuItem(
            child: Text(country),
            value: country,
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _selectedCountry = value.toString();
          List<String> split = _selectedCountry.split(" - ");
          widget.controller.text = split[1];
          widget.onSelect(_selectedCountry);
        });
      },
    );
  }
}

class BCard extends StatefulWidget {
  final Baggage b;
  BCard({super.key, required this.b});

  @override
  State<BCard> createState() => BCardState();
}

class BCardState extends State<BCard> {
  Color r = Colors.black54;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text("${widget.b.fullName}'s bag"),
                      backgroundColor: Colors.black,
                      centerTitle: true,
                    ),
                    body: BagProfile(bag: widget.b))));
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
                        "${widget.b.fullName}'s bag",
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
                        //'R-${p.reservationNum}|
                        'Weight: ${widget.b.weight.toString()}lbs | ${widget.b.originatingAirport} to ${widget.b.destinationAirport}',
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
                          color: widget.b.status.color,
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
                            widget.b.status.name,
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
