import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:requests/requests.dart';

class HoneywellScanApp extends StatefulWidget {
  @override
  _HoneywellScanAppState createState() => _HoneywellScanAppState();
}

class _HoneywellScanAppState extends State<HoneywellScanApp> {
  final FocusNode _focusNode = FocusNode();
  String? _message;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, RawKeyEvent event) {
    setState(() {
      if (event.physicalKey == PhysicalKeyboardKey.keyA) {
        _message = 'Pressed the key next to CAPS LOCK!';
      } else {
        if (kReleaseMode) {
          _message =
              'Not the key next to CAPS LOCK: Pressed 0x${event.physicalKey.usbHidUsage.toRadixString(16)}';
        } else {
          // As the name implies, the debugName will only print useful
          // information in debug mode.
          _message =
              'Not the key next to CAPS LOCK: Pressed ${event.physicalKey.debugName}';
        }
      }
    });
    return event.physicalKey == PhysicalKeyboardKey.keyA
        ? KeyEventResult.handled
        : KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Honeywell Scanner Testing'),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Focus(
            focusNode: _focusNode,
            onKey: _handleKeyEvent,
            child: AnimatedBuilder(
                animation: _focusNode,
                builder: (BuildContext context, Widget? child) {
                  if (!_focusNode.hasFocus) {
                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(_focusNode);
                      },
                      child: const Text('Click to focus'),
                    );
                  }
                  return Text(_message ?? 'Press a key');
                }),
          )),
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
