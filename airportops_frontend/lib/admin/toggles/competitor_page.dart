// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:airportops_frontend/admin/profiles/competitor_profile.dart';
import 'package:airportops_frontend/classes/events.dart';
import 'package:airportops_frontend/database.dart';
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

  List<Competitor> _foundComps = [];
  @override
  void initState() {
    _foundComps = widget.event.competitors;
    super.initState();
  }

  void filter(String keyword) {
    List<Competitor> results = [];
    if (keyword.isEmpty) {
      results = widget.event.competitors;
    } else {
      results = widget.event.competitors
          .where(
              (c) => c.fullname.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundComps = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
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
                  '${widget.event.name} Competitors',
                  style: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      var curr = await getCurrentEvent();
                      await setEvent(widget.event.name);
                      if (curr['data']['name'] != widget.event.name) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(206, 47, 124, 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
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
                    ))
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 8),
        child: TextField(
          decoration: const InputDecoration(
              labelText: 'Search for competitors',
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
            children: List.generate(_foundComps.length, (index) {
              return CCard(c:_foundComps[index]);
            }),
          ),
        ),
      ),
    ]);
  }
}

class CCard extends StatefulWidget {
  final Competitor c;
  CCard({super.key, required this.c});

  @override
  State<CCard> createState() => CCardState();
}

class CCardState extends State<CCard> {
  final String image = 'assets/icons8-circled-user-male-skin-type-6-96.png';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
                    appBar: AppBar(
                      title: Text("${widget.c.fullname}'s Profile"),
                      backgroundColor: Colors.black,
                      centerTitle: true,
                    ),
                    body: CompProfile(c: widget.c))));
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
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 8, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${widget.c.fullname}",
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 6, 0, 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            //'R-${p.reservationNum}|
                            '@${widget.c.username}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                Container(
                  width: 59.6,
                  height: 50.6,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 5, 0),
                    child: Image.asset(
                      widget.c.position.icon,
                      width: 114.2,
                      height: 93.4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class EBox extends StatelessWidget {
//   EBox({super.key, required this.competitior, required this.image});

//   final Competitor competitior;
//   final String image;

//   late String image_route = 'assets/$image';
//   late String position = competitior.position.name;

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//         alignment: Alignment.topCenter,
//         child: Padding(
//           padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//           child: Container(
//             width: 340,
//             height: 92,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 4,
//                   color: Color(0x33000000),
//                   offset: Offset(0, 2),
//                 )
//               ],
//               shape: BoxShape.rectangle,
//             ),
//             alignment: AlignmentDirectional(0, 0),
//             child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Container(
//                     width: 100,
//                     height: 5,
//                     decoration: BoxDecoration(
//                       color: Color(0xFF00239E),
//                     ),
//                   ),
//                   Expanded(
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Align(
//                           alignment: AlignmentDirectional(0, 0),
//                           child: Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
//                             child: Container(
//                               width: 74,
//                               height: 61,
//                               child: Container(
//                                 width: 120,
//                                 height: 120,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Image.asset(
//                                   image_route,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: 186.5,
//                           height: 82.9,
//                           child: Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               /**add font details */
//                               children: [
//                                 Align(
//                                   alignment: AlignmentDirectional(-0.7, -0.7),
//                                   child: Text(
//                                     '${competitior.firstname} ${competitior.lastname}',
//                                     style: TextStyle(
//                                         fontFamily: 'Poppins',
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           width: 59.6,
//                           height: 50.6,
//                           child: Padding(
//                             padding:
//                                 EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
//                             child: Image.asset(
//                               competitior.position.icon,
//                               width: 114.2,
//                               height: 93.4,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ]),
//           ),
//         ));
//   }
// }


