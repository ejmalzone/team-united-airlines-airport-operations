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
                    print("This.code: ${this.code}");
                    var person = await Requests.get(
                      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/passenger/',
                      json: {"_id": this.code},
                    );

                    List<dynamic> allData = person.json()['data'];
                    for (var personData in allData) {
                      //print("Person: ${personData}");
                      if (personData['_id'] == this.code &&
                          personData['accommodations'] != []) {
                        print("REQUESTS PRESENT");
                      }
                    }

                    person.raiseForStatus();

                    var reply = await Requests.put(
                        'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/passenger/',
                        json: {"passengerId": this.code});
                    //reply.raiseForStatus();
                    String body = reply.content();
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
              ])),
        );
      }),
    );
  }
}
