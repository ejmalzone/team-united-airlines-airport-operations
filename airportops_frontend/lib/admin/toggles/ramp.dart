import 'package:airportops_frontend/admin/new_bag.dart';
import 'package:airportops_frontend/admin/new_passenger.dart';
import 'package:airportops_frontend/classes/baggage.dart';
import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/printing/pdfs.dart';
import 'package:airportops_frontend/scanning.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';

import '../../classes/events.dart';
import 'competitor_page.dart';

class AdminRamp extends StatefulWidget {
  Event event;
  AdminRamp({Key? key, required this.event}) : super(key: key);

  @override
  State<AdminRamp> createState() => _AdminRampState();
}

class _AdminRampState extends State<AdminRamp> {
  List<Baggage> _foundBags = [];
  @override
  void initState() {
    _foundBags = widget.event.bags;
    super.initState();
  }

  void filter(String keyword) {
    List<Baggage> results = [];
    if (keyword.isEmpty) {
      results = widget.event.bags;
    } else {
      results = widget.event.bags
          .where(
              (b) => b.fullName.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundBags = results;
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
                      '${widget.event.name} Bag Status',
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
          //height: 100,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                //height: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      widget.event.b_boarded.toString(),
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
                height: 50,
                child: VerticalDivider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              Container(
                width: 120,
                //height: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      widget.event.b_unboarded.toString(),
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
                height: 50,
                child: VerticalDivider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              Container(
                width: 120,
                //height: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      widget.event.b_wrong.toString(),
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
                labelText: 'Search for bags',
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
              children: List.generate(_foundBags.length, (index) {
                return BCard(b: _foundBags[index]);
              }),
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Baggage newBag = await Navigator.push(
                      context, MaterialPageRoute(builder: (context) => NewBag()));
                  setState(() {
                    widget.event.addBag(newBag);
                    var newB = createBag(
                        passengerFirst: newBag.nameFirst,
                        passengerLast: newBag.nameLast,
                        origin: newBag.originatingAirport,
                        destination: newBag.destinationAirport,
                        weight: newBag.weight,
                        wrongDestination: newBag.wrongDestination,
                        event: widget.event.name);
                  });
                  for (int i = 0; i < widget.event.bags.length; i++) {
                    print(widget.event.bags[i].fullName);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF00239E),
                ),
                child: Text(
                  "Add Bags",
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: ElevatedButton(
                  onPressed: () async {
                    var curr = await getCurrentEvent();
                    await setEvent(widget.event.name);
                    if (curr['data']['name'] != widget.event.name) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(206, 47, 124, 2),
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          child: Text(
                              "${widget.event.name} is now set as the current event!",
                              textAlign: TextAlign.center),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        duration: Duration(seconds: 2),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(216, 133, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(
                              "${widget.event.name} is already set as the current event!",
                              textAlign: TextAlign.center),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 47, 124, 2),
                  ),
                  child: Text(
                    'Set Current Event',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 15,
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: ElevatedButton(
                  onPressed: () async {
                Map<String, dynamic> reqData = await getCurrentEvent();
                Map<String, dynamic> bagData =
                    await bagsRequest(reqData['data']['name']);
                final bagInstances = bagData['data'];

                List<Baggage> bags = [];

                for (var bagInstance in bagInstances) {
                  bags.add(Baggage.fromJson(bagInstance));
                }

                PdfCreator.generateBaggageTagPages(bags);

                showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                      title: const Text("Generating..."),
                      content: const Text("Generating PDF"),
                      actions: [
                        TextButton(
                            child: Text("Ok"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            })
                      ]),
                );
                  },
                  style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF00239E),
                  ),
                  child: Text(
                "Print Bag tags",
                style: TextStyle(
                  fontFamily: 'Open Sans',
                ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
