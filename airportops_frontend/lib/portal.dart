import 'dart:convert';

import 'package:airportops_frontend/admin/admin_profile.dart';
import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/customerservice/customerservice_profile.dart';

import 'package:airportops_frontend/extensions.dart';
import 'package:airportops_frontend/main.dart';
import 'package:airportops_frontend/rampservices/rampservices_profile.dart';
import 'package:airportops_frontend/scanning.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database.dart';
import 'login.dart';

class PortalRoute extends StatelessWidget {
//   ElevatedButton makeButton(BuildContext context, String text, String img,
//       [String? endRoute]) {
//     const buttonTextStyle = TextStyle(
//         color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold);

//     var buttonStyle = ElevatedButton.styleFrom(
//       minimumSize: const Size(180, 180),
//       backgroundColor: Colors.grey,
//       textStyle: buttonTextStyle,
//       shadowColor: Colors.black12,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.5)),
//     );

//     return ElevatedButton(
//         style: buttonStyle,
//         onPressed: () async {
//           final SharedPreferences prefs = await SharedPreferences.getInstance();
//           if (endRoute == '/admin') {
//             Map<String, dynamic> eventMap = await eventRequest();
//             String? user = prefs.getString(ADMIN_KEY);
//             if (user != null) {
//               await usernameValidation(user).then((data) async => {
//                     if (data["status"] == "success")
//                       {
//                         await Navigator.of(context)
//                             .push(MaterialPageRoute(builder: ((context) {
//                           return AdminRoute(eventmap: eventMap);
//                         })))
//                       }
//                     else
//                       {
//                         prefs.remove(ADMIN_KEY),
//                         await Navigator.of(context)
//                             .push(MaterialPageRoute(builder: ((context) {
//                           return LoginRoute();
//                         })))
//                       }
//                   });
//             } else {
//               await Navigator.of(context)
//                   .push(MaterialPageRoute(builder: ((context) {
//                 return LoginRoute();
//               })));
//             }
//           } else if (endRoute == '/csrSelect') {
//             //Navigator.pushNamed(context, endRoute);
//             String? competitor = prefs.getString(CUSTOMER_SERVICE_KEY);
//             if (competitor != null) {
//               Map<String, dynamic> compData = jsonDecode(competitor);
//               await validateCompetitor(compData["username"]).then((data) async => {
//                     if (data["status"] == "success")
//                       {
//                         await Navigator.of(context)
//                             .push(MaterialPageRoute(builder: ((context) {
//                           return CSRRoute();
//                         })))
//                       }
//                     else
//                       {
//                         prefs.remove(CUSTOMER_SERVICE_KEY),
//                         await Navigator.of(context).push(
//                           MaterialPageRoute(
//                               builder: (context) => CustomerServiceLogin()),
//                         )
//                       }
//                   });
//             } else {
//               await Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => CustomerServiceLogin()),
//               );
//             }
//           } else if (endRoute == '/baggageSelect') {
//             String? competitor = prefs.getString(RAMP_SERVICES_KEY);
//             if (competitor != null) {
//               Map<String, dynamic> compData = jsonDecode(competitor);
//               await validateCompetitor(compData["username"]).then((data) async => {
//                     if (data["status"] == "success")
//                       {
//                         await Navigator.of(context)
//                             .push(MaterialPageRoute(builder: ((context) {
//                           return BaggageRoute();
//                         })))
//                       }
//                     else
//                       {
//                         prefs.remove(RAMP_SERVICES_KEY),
//                         await Navigator.of(context).push(
//                           MaterialPageRoute(
//                               builder: (context) => RampServicesLogin()),
//                         )
//                       }
//                   });
//             } else {
//               await Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => RampServicesLogin()),
//               );
//             }
//           } else {
//             await Navigator.of(context).pushNamed(endRoute.toString());
//           }

//           // if (endRoute == '/admin') {
//           //   Navigator.pushNamed(context, '/admin');
//           //   Map<String, dynamic> eventMap = await eventRequest();
//           //   if (eventMap['status'] == 'success') {
//           //     await Navigator.push(context,
//           //             MaterialPageRoute(builder: (context) => AdminRoute(eventmap: eventMap)));
//           //   }
//           // }
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [Image.asset(img), Text(text, style: buttonTextStyle)]
//               .withSpaceBetween(height: 8),
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Portal Selection'),
//         titleTextStyle: const TextStyle(
//             fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//         backgroundColor: Color.fromARGB(255, 0, 47, 149),
//         toolbarHeight: 105,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // makeButton(context, 'Customer Service',
//                 //     'assets/icons8-airport-64.png', '/customerservice'),
//                 // makeButton(context, 'Ramp Service',
//                 //     'assets/icons8-luggage-64 (1).png', '/baggage'),
//                 makeButton(context, 'Customer Service',
//                     'assets/icons8-airport-64.png', '/csrSelect'),
//                 makeButton(context, 'Ramp Service',
//                     'assets/icons8-luggage-64 (1).png', '/baggageSelect'),
//               ].withSpaceBetween(width: 36),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 makeButton(
//                     context, 'Admin', 'assets/united-square-64.png', '/admin'),
//                 makeButton(
//                     //TEMPORARY DEBUG BUTTON
//                     context,
//                     'Debug',
//                     'assets/united-square-64.png',
//                     '/home'),
//               ].withSpaceBetween(
//                 width: 36,
//               ),
//             ),
//           ].withSpaceBetween(height: 36),
//         ),
//       ),
//     );
//   }
// }

  ElevatedButton makeButton(BuildContext context, String text, String img,
      [String? endRoute]) {
    const buttonTextStyle = TextStyle(
        color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold);
    var buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(180, 180),
      backgroundColor: Colors.grey,
      textStyle: buttonTextStyle,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.5)),
      padding: const EdgeInsets.all(8),
    );
    makeLogoutAlert(BuildContext context, int portal, SharedPreferences prefs) {
      String portalName = "";
      String key = ADMIN_KEY;
      switch (portal) {
        case (0):
          {
            portalName = "Admin";
            key = ADMIN_KEY;
            break;
          }
        case (1):
          {
            portalName = "Customer Service";
            key = CUSTOMER_SERVICE_KEY;
            break;
          }
        case (2):
          {
            portalName = "Ramp Services";
            key = RAMP_SERVICES_KEY;
            break;
          }
      }
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text("Sign out?"),
                content: Text(
                    "You are logged into the $portalName portal already. Would you like to sign out?"),
                actions: <Widget>[
                  TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        prefs.remove(key);
                        Navigator.pop(context, 'ack');
                      }),
                  TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context, 'ack');
                      }),
                ],
              ));
    }

    return ElevatedButton(
        style: buttonStyle,
        onPressed: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          if (endRoute == '/admin') {
            Map<String, dynamic> eventMap = await eventRequest();
            Map<String, dynamic> currEventMap = await getCurrentEvent();
            String? user = prefs.getString(ADMIN_KEY);
            String? CSRData = prefs.getString(CUSTOMER_SERVICE_KEY);
            String? RSData = prefs.getString(RAMP_SERVICES_KEY);
            if (CSRData != null) {
              makeLogoutAlert(context, 1, prefs);
            } else if (RSData != null) {
              makeLogoutAlert(context, 2, prefs);
            } else if (user != null) {
              await usernameValidation(user).then((data) async => {
                    if (data["status"] == "success")
                      {
                        await Navigator.of(context)
                            .push(MaterialPageRoute(builder: ((context) {
                          return AdminRoute(
                              eventmap: eventMap, curreventmap: currEventMap);
                        })))
                      }
                    else
                      {
                        prefs.remove(ADMIN_KEY),
                        await Navigator.of(context)
                            .push(MaterialPageRoute(builder: ((context) {
                          return LoginRoute();
                        })))
                      }
                  });
            } else {
              await Navigator.of(context)
                  .push(MaterialPageRoute(builder: ((context) {
                return LoginRoute();
              })));
            }
          } else if (endRoute == '/csrSelect') {
            //Navigator.pushNamed(context, endRoute);
            String? user = prefs.getString(ADMIN_KEY);
            String? CSRData = prefs.getString(CUSTOMER_SERVICE_KEY);
            String? RSData = prefs.getString(RAMP_SERVICES_KEY);
            if (user != null) {
              makeLogoutAlert(context, 0, prefs);
            } else if (RSData != null) {
              makeLogoutAlert(context, 2, prefs);
            } else if (CSRData != null) {
              Map<String, dynamic> compData = jsonDecode(CSRData);
              await validateCompetitor(compData["username"])
                  .then((data) async => {
                        if (data["status"] == "success")
                          {
                            await Navigator.of(context)
                                .push(MaterialPageRoute(builder: ((context) {
                              return CSRRoute(competitor: compData);
                            })))
                          }
                        else
                          {
                            prefs.remove(CUSTOMER_SERVICE_KEY),
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => CustomerServiceLogin()),
                            )
                          }
                      });
            } else {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CustomerServiceLogin()),
              );
            }
          } else if (endRoute == '/baggageSelect') {
            String? user = prefs.getString(ADMIN_KEY);
            String? CSRData = prefs.getString(CUSTOMER_SERVICE_KEY);
            String? RSData = prefs.getString(RAMP_SERVICES_KEY);
            if (user != null) {
              makeLogoutAlert(context, 0, prefs);
            } else if (CSRData != null) {
              makeLogoutAlert(context, 1, prefs);
            } else if (RSData != null) {
              Map<String, dynamic> compData = jsonDecode(RSData);
              await validateCompetitor(compData["username"])
                  .then((data) async => {
                        if (data["status"] == "success")
                          {
                            await Navigator.of(context)
                                .push(MaterialPageRoute(builder: ((context) {
                              return BaggageRoute(competitor: compData);
                            })))
                          }
                        else
                          {
                            prefs.remove(RAMP_SERVICES_KEY),
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => RampServicesLogin()),
                            )
                          }
                      });
            } else {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => RampServicesLogin()),
              );
            }
          } else {
            await Navigator.of(context).pushNamed(endRoute.toString());
          }
          // if (endRoute == '/admin') {
          //   Navigator.pushNamed(context, '/admin');
          //   Map<String, dynamic> eventMap = await eventRequest();
          //   if (eventMap['status'] == 'success') {
          //     await Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => AdminRoute(eventmap: eventMap)));
          //   }
          // }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Image.asset(img), Text(text, style: buttonTextStyle)]
              .withSpaceBetween(height: 8),
        ));
  }

  @override
  Widget build(BuildContext context) {
    makeLogoutAlert(BuildContext context, int portal, SharedPreferences prefs) {
      String portalName = "";
      String key = ADMIN_KEY;
      switch (portal) {
        case (0):
          {
            portalName = "Admin";
            key = ADMIN_KEY;
            break;
          }
        case (1):
          {
            portalName = "Customer Service";
            key = CUSTOMER_SERVICE_KEY;
            break;
          }
        case (2):
          {
            portalName = "Ramp Services";
            key = RAMP_SERVICES_KEY;
            break;
          }
      }
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text("Sign out?"),
                content: Text(
                    "You are logged into the $portalName portal already. Would you like to sign out?"),
                actions: <Widget>[
                  TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        prefs.remove(key);
                        Navigator.pop(context, 'ack');
                      }),
                  TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context, 'ack');
                      }),
                ],
              ));
    }

    if (kIsWeb) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 47, 149),
          automaticallyImplyLeading: false,
          title: SelectionArea(
              child: Text(
            'Portal Selection Page',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          )),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        //body: SafeArea(
        body: ListView(
          children: [
            GestureDetector(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: SelectionArea(
                              child: Text(
                            'United Airlines Safety Rodeo',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            {
                              Map<String, dynamic> eventMap =
                                  await eventRequest();
                              Map<String, dynamic> currEventMap =
                                  await getCurrentEvent();
                              String? user = prefs.getString(ADMIN_KEY);
                              String? CSRData =
                                  prefs.getString(CUSTOMER_SERVICE_KEY);
                              String? RSData =
                                  prefs.getString(RAMP_SERVICES_KEY);
                              if (CSRData != null) {
                                makeLogoutAlert(context, 1, prefs);
                              } else if (RSData != null) {
                                makeLogoutAlert(context, 2, prefs);
                              } else if (user != null) {
                                await usernameValidation(user)
                                    .then((data) async => {
                                          if (data["status"] == "success")
                                            {
                                              await Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: ((context) {
                                                return AdminRoute(
                                                  eventmap: eventMap,
                                                  curreventmap: currEventMap,
                                                );
                                              })))
                                            }
                                          else
                                            {
                                              prefs.remove(ADMIN_KEY),
                                              await Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: ((context) {
                                                return LoginRoute();
                                              })))
                                            }
                                        });
                              } else {
                                await Navigator.of(context).push(
                                    MaterialPageRoute(builder: ((context) {
                                  return LoginRoute();
                                })));
                              }
                            }
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color:
                                  Color.fromARGB(255, 173, 177, 180), //change?
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x33000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white, //change?
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12, 12, 12, 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Admin',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image.network(
                                        'assets/united-square-64.png',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            {
                              String? user = prefs.getString(ADMIN_KEY);
                              String? CSRData =
                                  prefs.getString(CUSTOMER_SERVICE_KEY);
                              String? RSData =
                                  prefs.getString(RAMP_SERVICES_KEY);
                              if (user != null) {
                                makeLogoutAlert(context, 0, prefs);
                              } else if (CSRData != null) {
                                makeLogoutAlert(context, 1, prefs);
                              } else if (RSData != null) {
                                Map<String, dynamic> compData =
                                    jsonDecode(RSData);
                                await validateCompetitor(compData["username"])
                                    .then((data) async => {
                                          if (data["status"] == "success")
                                            {
                                              await Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: ((context) {
                                                return BaggageRoute(
                                                  competitor: compData,
                                                );
                                              })))
                                            }
                                          else
                                            {
                                              prefs.remove(RAMP_SERVICES_KEY),
                                              await Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RampServicesLogin()),
                                              )
                                            }
                                        });
                              } else {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RampServicesLogin()),
                                );
                              }
                            }
                          },
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 173, 177, 180),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white, //change?
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12, 12, 12, 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ramp Service',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image.network(
                                          'assets/icons8-luggage-64 (1).png',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            {
                              String? user = prefs.getString(ADMIN_KEY);
                              String? CSRData =
                                  prefs.getString(CUSTOMER_SERVICE_KEY);
                              String? RSData =
                                  prefs.getString(RAMP_SERVICES_KEY);
                              if (user != null) {
                                makeLogoutAlert(context, 0, prefs);
                              } else if (RSData != null) {
                                makeLogoutAlert(context, 2, prefs);
                              } else if (CSRData != null) {
                                Map<String, dynamic> compData =
                                    jsonDecode(CSRData);
                                await validateCompetitor(compData["username"])
                                    .then((data) async => {
                                          if (data["status"] == "success")
                                            {
                                              await Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: ((context) {
                                                return CSRRoute(
                                                  competitor: compData,
                                                );
                                              })))
                                            }
                                          else
                                            {
                                              prefs
                                                  .remove(CUSTOMER_SERVICE_KEY),
                                              await Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CustomerServiceLogin()),
                                              )
                                            }
                                        });
                              } else {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CustomerServiceLogin()),
                                );
                              }
                            }
                          },
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 173, 177, 180),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white, //change?
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12, 12, 12, 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Customer Service',
                                          style: TextStyle(
                                            fontFamily: 'Outfit',
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image.network(
                                          'assets/icons8-airport-64.png',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /**
               * 
               * FFButtonWidget(
                onPressed: () {
                  print('Button pressed ...');
                },
                text: 'Debug',
                options: FFButtonOptions(
                  width: 130,
                  height: 40,
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                      ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ) ,
               * */

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(50, 30, 50, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeRoute()));
                        print("link to debug button");
                      },
                      child: Text(
                        "DEBUG",
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Portal Selection'),
        titleTextStyle: const TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        backgroundColor: Color.fromARGB(255, 0, 47, 149),
        toolbarHeight: 105,
      ),
      body: Center(
        //child: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
        //  children: [
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            //Row(
            //  mainAxisAlignment: MainAxisAlignment.center,
            //  children: [
            // makeButton(context, 'Customer Service',
            //     'assets/icons8-airport-64.png', '/customerservice'),
            // makeButton(context, 'Ramp Service',
            //     'assets/icons8-luggage-64 (1).png', '/baggage'),
            makeButton(context, 'Customer Service',
                'assets/icons8-airport-64.png', '/csrSelect'),
            makeButton(context, 'Ramp Service',
                'assets/icons8-luggage-64 (1).png', '/baggageSelect'),
            //].withSpaceBetween(width: 18),
            //),
            //Row(
            //  mainAxisAlignment: MainAxisAlignment.center,
            //  children: [
            makeButton(
                context, 'Admin', 'assets/united-square-64.png', '/admin'),
            makeButton(
                //TEMPORARY DEBUG BUTTON
                context,
                'Debug',
                'assets/united-square-64.png',
                '/home'),
            //  ].withSpaceBetween(
            //    width: 18,
            //  ),
            // ),
          ].withSpaceBetween(height: 18),
        ),
      ),
    );
  }
}
