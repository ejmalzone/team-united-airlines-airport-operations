import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

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
            return Material(
                child: Column(
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
                  onPressed: () {},
                  child: Text('Query based on ${this.code}'),
                ),
              ],
            ));
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
        return Material(
          child: Center(
            child: ElevatedButton(
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
          ),
        );
      }),
    );
  }
}
