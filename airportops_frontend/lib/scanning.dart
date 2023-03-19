import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:requests/requests.dart';

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
        /*showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Scan Results'),
                  content:
                      const Text('Do you want to check in the scanned bag?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                    ),
                    TextButton(
                      child: Text('Check In id no. ${scannedData?.code}'),
                      onPressed: () async {
                        if (scannedData != null) {}
                        await Requests.put(
                            'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/passenger/',
                            json: {"passengerId": scannedData?.code});
                        Navigator.of(context).pop('OK');
                      },
                    )
                  ],
                ));*/
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

class UniversalScanApp extends StatefulWidget {
  @override
  _UniversalScanAppState createState() => _UniversalScanAppState();
}

class _UniversalScanAppState extends State<UniversalScanApp> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('QR Scanning Page'),
        ),
        body: Builder(builder: (context) {
          if (code != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                            context: context,
                            onCode: (code) {
                              setState(() {
                                this.code = code?.substring(15);
                              });
                            });
                      },
                      child: Text((() {
                        if (code == null) {
                          return 'Scan Tag';
                        }
                        return 'Scan Another Tag';
                      }())),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //Requests.put('http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/passenger/', )
                      var reply = await Requests.put(
                          'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/passenger/',
                          json: {"passengerId": this.code});
                      reply.raiseForStatus();
                      String body = reply.content();
                    },
                    child: Text('Query based on ${this.code}'),
                  ),
                ],
              ),
              //),
            );
            //);
          }

          return Material(
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                        context: context,
                        onCode: (code) {
                          setState(() {
                            this.code = code?.substring(15);
                          });
                        });
                  },
                  child: Text(code ?? "Scan Boarding Pass")),
            ),
          );
        }),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanning Page'),
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
                    //Requests.put('http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/passenger/', )
                    var reply = await Requests.put(
                        'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/passenger/',
                        json: {"passengerId": this.code});
                    reply.raiseForStatus();
                    String body = reply.content();
                  },
                  child: Text('Query based on ${this.code}'),
                ),
                ElevatedButton(
                    onPressed: () {
                      _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                          context: context,
                          onCode: (code) {
                            setState(() {
                              this.code = code;
                            });
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
                            setState(() {
                              this.code = code;
                            });
                          });
                    },
                    child: Text(code ?? "Scan Boarding Pass")),
              ])),
        );
      }),
    );
  }
}
