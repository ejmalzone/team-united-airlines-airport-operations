import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
//import 'dart:html' as html; TODO: Figure out how to make android compile with this being imported still?
import 'package:airportops_frontend/classes/baggage.dart';

import '../classes/passenger.dart';

class PdfCreator {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static int _id = 0;

  // static Future<File> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load('assets/$path');
  //
  //   final file = File('${(await getTemporaryDirectory()).path}/$path');
  //   await file.writeAsBytes(byteData.buffer
  //       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //
  //   return file;
  // }

  static generatePassengerPdf(final Passenger passenger) async {
    // lol
  }

  static generateBagPdf(final Baggage bag) async {
    final bytes = await rootBundle.load('assets/united-high-res.png');
    final _unitedLogo = pw.MemoryImage(bytes.buffer.asUint8List());

    final pdf = pw.Document();

    const code = "123456789";

    pdf.addPage(pw.Page(
        // I think this is the right size paper...
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {
          return pw.Center(
              child: pw.Column(children: [
            pw.BarcodeWidget(
                data: code,
                barcode: pw.Barcode.qrCode(),
                width: 200,
                height: 200),
            pw.SizedBox(height: 20),
            pw.Image(_unitedLogo),
            pw.SizedBox(height: 20),
            pw.BarcodeWidget(
                data: code,
                barcode: pw.Barcode.qrCode(),
                width: 200,
                height: 200),
            pw.SizedBox(height: 20),
            pw.BarcodeWidget(
                data: code,
                barcode: pw.Barcode.qrCode(),
                width: 200,
                height: 200),
            pw.SizedBox(height: 10),
            pw.Text(DateTime.now().toIso8601String())
          ])); // Center
        })); // Page

    final name = 'baggage_tag_${_id++}.pdf';
    final Uint8List pdfInBytes = await pdf.save();

    if (kIsWeb) {
      final content = base64Encode(pdfInBytes);
      /*final anchor = html.AnchorElement(
          href:
              "data:application/octet-stream;charset=utf-16le;base64,$content")
        ..setAttribute("download", name)
        ..click();*/
    } else {
      final file = io.File('${await _localPath}/$name');
      await file.writeAsBytes(pdfInBytes);
    }
  }
}
