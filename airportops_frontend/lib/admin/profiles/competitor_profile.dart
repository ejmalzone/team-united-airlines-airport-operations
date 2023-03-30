import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';

class CompProfile extends StatefulWidget {
  Competitor c;
  CompProfile({Key? key, required this.c}) : super(key: key);

  @override
  State<CompProfile> createState() => CompProfileState();
}

class CompProfileState extends State<CompProfile> {
  final String image = 'icons8-circled-user-male-skin-type-6-96.png';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileBox(competitior: widget.c, image: image),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Container(
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
                        '0',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          color: Color(0xFF008525),
                          fontSize: 50,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'SCANNED',
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
                Center(
                  child: Container(
                    width: 120,
                    height: 100,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '0',
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            color: Colors.red,
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
