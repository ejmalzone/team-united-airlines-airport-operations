// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/classes/events.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/widgets/passenger_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:requests/requests.dart';
import 'package:airportops_frontend/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/*
  Honeywell Scanner Widget
*/
class HoneywellScanApp extends StatefulWidget {
  @override
  _HoneywellScanAppState createState() => _HoneywellScanAppState();
}

class _HoneywellScanAppState extends State<HoneywellScanApp> {
  String? lastScan;

  late HoneywellScanner honeywellScanner;
  bool supported = false;

  @override
  Widget build(BuildContext context) {
    honeywellScanner = HoneywellScanner(
      onScannerDecodeCallback: (scannedData) async {
        setState(() {
          lastScan = scannedData?.code;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var compJson = prefs.getString(RAMP_SERVICES_KEY);
        var compData = jsonDecode(compJson!);

        if (scannedData!.code! == "start") {
          scanStart(competitor: compData["username"]);
        } else if (scannedData.code! == "finish") {
          scanFinish(competitor: compData["username"]);
        } else {
          await scanBag(
              bagId: scannedData.code!, competitor: compData["username"]);
        }
      },
      onScannerErrorCallback: (error) {},
    );
    honeywellScanner.startScanner();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Honeywell Scanner Testing'),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('Last scan result: '),
            Text(lastScan ?? 'No Recent Scans'),
          ])),
    );
  }
}

/*
  Mobile/Web Scanning
*/
class UniversalScanApp extends StatefulWidget {
  @override
  _UniversalScanAppState createState() => _UniversalScanAppState();
}

class _UniversalScanAppState extends State<UniversalScanApp> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;
  String? last;

  Future<Passenger> getdata(String? code) async {
    String baseURL = getBaseURL();
    var person = await Requests.post('${baseURL}filtered/passenger/',
        json: {"_id": code});
    print(person.json());
    Passenger p = Passenger.fromJson(person.json()['data'][0]);
    person.raiseForStatus();
    return p;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Boarding'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        if (code != null) {
          return Material(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  child: SizedBox(
                    width: 250,
                    height: 100,
                    child: ElevatedButton.icon(
                        onPressed: () async {
                          print("this is code: $code, this is output: $last");
                          if (code != "start" && code != "finish") {
                            Passenger p = await getdata(code);
                            p.boarded = true;
                            //output = "View ${p.fullName}'s details";
                            print(p.passengerId);
                            print(p.fullName);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                        appBar: AppBar(
                                          title:
                                              Text("${p.fullName}'s Profile"),
                                          backgroundColor: Colors.black,
                                          centerTitle: true,
                                        ),
                                        body: PassengerProfile(
                                            title: "${p.fullName} 's Profile",
                                            passenger: p))));
                          }
                        },
                        label: Text("View ${last!}'s details"),
                        icon: Icon(
                          Icons.person,
                          size: 30,
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF00239E),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var compJson = prefs.getString(CUSTOMER_SERVICE_KEY);
                        var compData = jsonDecode(compJson!);
                        _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                            context: context,
                            onCode: (code) async {
                              if (code != null) {
                                if (kIsWeb) {
                                  code = code.substring(15);
                                }
                                if (code != "start" &&
                                    code != "finish") {
                                  Passenger person =
                                      await getdata(code);
                                  print(person.fullName);
                                  await scanPassenger(
                                      passengerId: code,
                                      competitor: compData["username"]);
                                  setState(() {
                                    this.code = code;
                                    last = person.fullName;
                                  });
                                } else {
                                  this.code = code;
                                  if (this.code == 'start') {
                                    print(
                                        "this is the code: ${code}");
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(206, 47, 124, 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Text(
                                            "Your time has started. Start Scanning!",
                                            textAlign: TextAlign.center),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      duration: Duration(seconds: 2),
                                    ));
                                    scanStart(competitor: compData["username"]);
                                    last = "start";
                                  } else if (this.code == 'finish') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                            color: Color(0xFF850000),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Text(
                                            "Your time has ended! Any other passenger scans will not count",
                                            textAlign: TextAlign.center),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      duration: Duration(seconds: 2),
                                    ));
                                    scanFinish(
                                        competitor: compData["username"]);
                                    last = "finish";
                                  }
                                }
                              }
                            });
                      },
                      child: Text("Rescan"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                      )),
                ),
              ],
            )),
          );
        }
        return Material(
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const Text('To scan a boarding pass, click the icon below'),
                IconButton(
                  icon: const Icon(Icons.camera_enhance),
                  iconSize: 50,
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var compJson = prefs.getString(CUSTOMER_SERVICE_KEY);
                    var compData = jsonDecode(compJson!);
                    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                        context: context,
                        onCode: (code) async {
                          if (code != null) {
                            if (kIsWeb) {
                              code = code.substring(15);
                            }
                            if (code == "start") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(206, 47, 124, 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Text(
                                      "Your time has started. Start Scanning!",
                                      textAlign: TextAlign.center),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                duration: Duration(seconds: 2),
                              ));
                              scanStart(competitor: compData["username"]);
                            } else if (code == "finish") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF850000),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Text(
                                      "Your time has ended! Any other bag scans will not count",
                                      textAlign: TextAlign.center),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                duration: Duration(seconds: 2),
                              ));
                              scanFinish(competitor: compData["username"]);
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF00239E),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Text("Passenger Scanned!",
                                      textAlign: TextAlign.center),
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                duration: Duration(seconds: 2),
                              ));
                              await scanPassenger(
                                      passengerId: code,
                                      competitor: compData["username"])
                                  .then((reply) {});
                            }
                          }
                        });
                  },
                )
              ])),
        );
      }),
    );
  }
}

/**
 * Ramp Service Employee Scanning Widget
 */
class RSEScanApp extends StatefulWidget {
  @override
  _RSEScanAppState createState() => _RSEScanAppState();
}

class _RSEScanAppState extends State<RSEScanApp> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baggage Check-in'),
        backgroundColor: const Color.fromARGB(255, 0, 47, 149),
      ),
      body: Builder(builder: (context) {
        return Material(
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const Text('To scan a baggage tag, click the icon below'),
                IconButton(
                  icon: const Icon(Icons.camera_enhance),
                  iconSize: 50,
                  onPressed: () async {
                    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                        context: context,
                        onCode: (code) async {
                          await SharedPreferences.getInstance()
                              .then((prefs) async {
                            var comp = prefs.getString(RAMP_SERVICES_KEY);
                            var compData = jsonDecode(comp!);

                            if (code != null) {
                              if (kIsWeb) {
                                code = code?.substring(15);
                              }

                              if (code == "start") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(206, 47, 124, 2),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text(
                                        "Your time has started. Start Scanning!",
                                        textAlign: TextAlign.center),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  duration: Duration(seconds: 2),
                                ));
                                scanStart(competitor: compData["username"]);
                              } else if (code == "finish") {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF850000),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text(
                                        "Your time has ended! Any other bag scans will not count",
                                        textAlign: TextAlign.center),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  duration: Duration(seconds: 2),
                                ));
                                scanFinish(competitor: compData["username"]);
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF00239E),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text("Bag Scanned!",
                                        textAlign: TextAlign.center),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  duration: Duration(seconds: 2),
                                ));
                                await scanBag(
                                        bagId: code!,
                                        competitor: compData["username"])
                                    .then((reply) {});
                              }
                            }
                          });
                          setState(() {
                            this.code = code;
                          });
                        });
                  },
                )
              ])),
        );
      }),
    );
  }
}
