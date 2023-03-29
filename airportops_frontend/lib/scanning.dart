import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:requests/requests.dart';

/*
  Honeywell Scanner Code
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
        await Requests.put(
            'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/passenger/',
            json: {"passengerId": scannedData?.code});
      },
      onScannerErrorCallback: (error) {},
    );
    honeywellScanner.startScanner();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Honeywell Scanner Testing'),
        backgroundColor: Colors.blue[900],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: Text('Test device support: $supported'),
              onTap: () async {
                bool supp = await honeywellScanner.isSupported();
                setState(() {
                  supported = supp;
                });
              },
            ),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Boarding'),
        backgroundColor: Colors.blue[900],
      ),
      body: Builder(builder: (context) {
        if (code != null) {
          return Material(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var person = await Requests.post(
                        'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/filtered/passenger/',
                        json: {"_id": this.code});
                    if (person.json()['data'][0]['accommodations'].length !=
                        0) {
                      showDialog<dynamic>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Accommodations present:'),
                                content: SingleChildScrollView(
                                  child: ListBody(children: <Widget>[
                                    for (var req in person.json()['data'][0]
                                        ['accommodations'])
                                      Text(req)
                                  ]),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Acknowledge'),
                                    onPressed: () =>
                                        Navigator.pop(context, 'ack'),
                                  ),
                                ],
                              ));
                    }
                    // }

                    person.raiseForStatus();

                    var reply = await Requests.put(
                        'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/passenger/',
                        json: {"passengerId": this.code});
                  },
                  child: Text('Query based on ${this.code}'),
                ),
                ElevatedButton(
                    onPressed: () {
                      _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                          context: context,
                          onCode: (code) {
                            if (kIsWeb) {
                              setState(() {
                                // Web scanning prepends "Scan Result:" onto
                                // result, need substring to remove
                                this.code = code?.substring(15);
                              });
                            } else {
                              setState(() {
                                this.code = code;
                              });
                            }
                          });
                    },
                    child: Text(code ?? "Scan Boarding Pass")),
              ],
            )),
          );
        }
        return Material(
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                /*ElevatedButton(
                    onPressed: () {
                      _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                          context: context,
                          onCode: (code) {
                            if (kIsWeb) {
                              setState(() {
                                // Web scanning prepends "Scan Result:" onto
                                // result, need substring to remove
                                this.code = code?.substring(15);
                              });
                            } else {
                              setState(() {
                                this.code = code;
                              });
                            }
                          });
                    },
                    child: Text(code ?? "Scan Boarding Pass")),
                    Material(color: Color.fromARGB(255, 0, 47, 149), ),*/
                const Text('To scan a boarding pass, click the icon below'),
                IconButton(
                  icon: const Icon(Icons.camera_enhance),
                  iconSize: 50,
                  onPressed: () {
                    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                        context: context,
                        onCode: (code) {
                          if (kIsWeb) {
                            setState(() {
                              // Web scanning prepends "Scan Result:" onto
                              // result, need substring to remove
                              this.code = code?.substring(15);
                            });
                          } else {
                            setState(() {
                              this.code = code;
                            });
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
                  onPressed: () {
                    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                        context: context,
                        onCode: (code) {
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
