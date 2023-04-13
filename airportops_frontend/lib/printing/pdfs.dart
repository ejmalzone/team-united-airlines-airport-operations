import 'dart:convert';
import 'dart:io' as io;
import 'dart:math';

import 'package:airportops_frontend/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;
import 'package:airportops_frontend/classes/baggage.dart';



import '../classes/passenger.dart';

class PdfCreator {
  static final rng = Random();

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static int _id = 0;

  static generateBoardingPassPages(final List<Passenger> passengers) async {
    if (passengers.isEmpty) {
      return;
    }

    final bytes = await rootBundle.load('assets/united-high-res.png');
    final unitedLogo = pw.MemoryImage(bytes.buffer.asUint8List());

    final pdf = pw.Document();

    for (var value in passengers) {
      addBoardingPassPage(unitedLogo, pdf, value);
    }

    final Uint8List pdfInBytes = await pdf.save();
    final name = 'boarding_pass_$_id.pdf';

    await savePdf(pdfInBytes, name);
  }

  static generateBaggageTagPages(final List<Baggage> bags) async {
    if (bags.isEmpty) {
      return;
    }

    final bytes = await rootBundle.load('assets/united-high-res.png');
    final unitedLogo = pw.MemoryImage(bytes.buffer.asUint8List());

    final pdf = pw.Document();

    for (var value in bags) {
      addBaggageTagPage(unitedLogo, pdf, value);
    }

    final Uint8List pdfInBytes = await pdf.save();
    final name = 'baggage_tag_${_id++}.pdf';

    await savePdf(pdfInBytes, name);
  }

  static addBoardingPassPage(final pw.MemoryImage unitedLogo, final pw.Document document, final Passenger passenger) async {
    final flag = (passenger.wrongDeparture || passenger.wrongGate || passenger.connection) ? '*' : '';

    var boardTime = '12:';
    if (passenger.wrongDeparture) {
      String wrongTime;

      // have to do this in case it gets 25 again
      do {
        wrongTime = rng.nextInt(60).toString().padLeft(2, '0');
      } while (wrongTime == '25');

      boardTime += wrongTime;
    } else {
      boardTime += '25';
    }

    var gate = 'B1';
    if (passenger.wrongGate) {
      String wrongGate;

      do {
        wrongGate = rng.nextInt(10).toString();
      } while (wrongGate == '2');

      gate += wrongGate;
    } else {
      gate += '2';
    }

    var flightSource = passenger.flightSource;
    var flightDestination = passenger.flightDestination;
    if (passenger.connection) {
      flightSource = flightDestination;

      do {
        flightDestination = countries.keys.elementAt(rng.nextInt(countries.keys.length));
      } while (flightDestination == passenger.flightDestination);

      gate = _getRandomGate();
      boardTime = '${10 + rng.nextInt(10)}:${rng.nextBool() ? '35' : '25'}';
    }

    document.addPage(
      pw.Page(
        pageFormat: const PdfPageFormat(
            (7 + 3/8) * PdfPageFormat.inch,
            (3 + 1/4) * PdfPageFormat.inch,
            marginTop: .25 * PdfPageFormat.inch,
            marginLeft: .25 * PdfPageFormat.inch,
            marginRight: .05 * PdfPageFormat.inch,
        ),
        build: (pw.Context context) {
          return pw.Row(children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(children: [
                  pw.Image(unitedLogo, width: 200, height: 50),
                  pw.SizedBox(width: 190),
                  pw.Text((_id++).toString() + flag, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24))
                ]),
                pw.Row(children: [
                  pw.Text('${passenger.nameFirst.toUpperCase()} / ${passenger.nameLast.toUpperCase()}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12))
                ]),
                pw.SizedBox(height: 5),
                pw.Text('----------------------------------------------------------------------------------------------------------'),
                pw.SizedBox(height: 5),
                pw.Row(children: [
                  pw.Column(children: [
                    pw.SizedBox(height: 0.05 * PdfPageFormat.inch),
                    pw.Table(
                        defaultColumnWidth: const pw.FixedColumnWidth(100),
                        children: [
                          pw.TableRow(
                            verticalAlignment: pw.TableCellVerticalAlignment.top,
                            children: [
                              pw.Text('UA 1047', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
                              pw.Text('GATE', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
                              pw.Text('BOARD TIME', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
                              pw.Text('SEAT', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
                            ]
                          ),
                          pw.TableRow(
                              verticalAlignment: pw.TableCellVerticalAlignment.top,
                              children: [
                                pw.Text('$flightSource -> $flightDestination', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16)),
                                pw.Text(gate, style: const pw.TextStyle(fontSize: 18)),
                                pw.Text(boardTime, style: const pw.TextStyle(fontSize: 18)),
                                pw.Text('${passenger.row}${passenger.seat}', style: const pw.TextStyle(fontSize: 18)),
                              ]
                          ),
                        ]
                    ),
                  ]),
                  pw.Container(
                    // transform: Matrix4Transform()
                    //   .rotateDegrees(90, origin: const Offset(75/2, 25/2))
                    //   .translate(x: -50.0, y: -10.0)
                    //   .matrix4,
                    child: pw.BarcodeWidget(
                      data: passenger.passengerId,
                      barcode: pw.Barcode.qrCode(),
                      width: 100,
                      height: 100,
                      drawText: false,
                    ),
                  )
                ]),
                pw.SizedBox(height: 5),
                pw.Text('----------------------------------------------------------------------------------------------------------'),
                pw.SizedBox(height: 5),
                // pw.Divider(height: 0.1 * PdfPageFormat.inch, thickness: 2, indent: 5, endIndent: 60),
                pw.Row(children: [
                  pw.Text('Ticket: ${passenger.passengerId}')
                ])
              ]
            ),
            pw.SizedBox(width: 10)
          ]);
        }
      )
    );
  }

  static addBaggageTagPage(final pw.MemoryImage unitedLogo, final pw.Document document, final Baggage bag) async {
    var destination = bag.destinationAirport;
    if (bag.wrongDestination) {
      do {
        destination = countries.keys.elementAt(rng.nextInt(countries.keys.length));
      } while (destination == bag.destinationAirport);
    }

    document.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(0.1 * PdfPageFormat.inch),
        pageFormat: const PdfPageFormat(
            2 * PdfPageFormat.inch, 18 * PdfPageFormat.inch,
            marginAll: .2 * PdfPageFormat.inch),
        build: (pw.Context context) {
          return pw.Center(
              child: pw.Column(children: <pw.Widget>[
            pw.BarcodeWidget(
              data: bag.id,
              barcode: pw.Barcode.code128(),
              width: 100,
              height: 50,
              drawText: false,
            ),
            pw.BarcodeWidget(
              data: bag.id,
              barcode: pw.Barcode.qrCode(),
              width: 150,
              height: 150,
            ),
            //pw.SizedBox(height: 5),
            pw.Image(unitedLogo),
            //pw.SizedBox(height: 10),
            pw.BarcodeWidget(
              data: bag.id,
              barcode: pw.Barcode.qrCode(),
              width: 200,
              height: 200,
            ),
            pw.BarcodeWidget(
              data: bag.id,
              barcode: pw.Barcode.code128(),
              width: 100,
              height: 50,
              drawText: false,
            ),
            //pw.SizedBox(height: 10),
            //pw.Text(DateTime.now().toIso8601String()),
            pw.Text(
                "${DateTime.now().day.toString()} ${DateFormat('MMM').format(DateTime(0, DateTime.now().month))} ${DateTime.now().year.toString()}"),
            //pw.Text("4016 649626"), // bag ID number?
            pw.Text(bag.id),
            pw.Text(destination),
            pw.Text("UA474 1340"), //Flight number?
            pw.BarcodeWidget(
              data: bag.id,
              barcode: pw.Barcode.code128(),
              width: 100,
              height: 50,
              drawText: false,
            ),
            pw.Text(
                "${bag.nameLast}/${bag.nameFirst}       ${destination}"),
            pw.BarcodeWidget(
              data: bag.id,
              barcode: pw.Barcode.code128(),
              width: 100,
              height: 50,
              drawText: false,
            ),
            pw.BarcodeWidget(
              data: bag.id,
              barcode: pw.Barcode.qrCode(),
              width: 150,
              height: 150,
            ),
            //pw.SizedBox(height: 5),
            pw.Image(unitedLogo),
            //pw.SizedBox(height: 10),
            pw.BarcodeWidget(
              data: bag.id,
              barcode: pw.Barcode.qrCode(),
              width: 200,
              height: 200,
            ),
            pw.BarcodeWidget(
              data: bag.id,
              barcode: pw.Barcode.code128(),
              width: 100,
              height: 50,
              drawText: false,
            ),
            //pw.SizedBox(height: 10),
            //pw.Text(DateTime.now().toIso8601String()),
            pw.Text("${DateTime.now().day.toString()} ${DateFormat('MMM').format(DateTime(0, DateTime.now().month))} ${DateTime.now().year.toString()}"),
            //pw.Text("4016 649626"), // bag ID number?
            pw.Text(bag.id),
            pw.Text(destination),
            pw.Text("UA474 1340"), //Flight number?
            pw.BarcodeWidget(
              data: bag.id,
              barcode: pw.Barcode.code128(),
              width: 100,
              height: 50,
              drawText: false,
            ),
            pw.Text("${bag.nameLast}/${bag.nameFirst}       ${destination}"),
            pw.BarcodeWidget(
              data: bag.id,
              barcode: pw.Barcode.code128(),
              width: 100,
              height: 50,
              drawText: false,
            ),
          ])); // Center
        }
      )
    ); // Page
  }

  static savePdf(final Uint8List bytes, final String name) async {
    if (kIsWeb) {
      final content = base64Encode(bytes);
      final anchor = html.AnchorElement(
          href:
          "data:application/octet-stream;charset=utf-16le;base64,$content")
        ..setAttribute("download", name)
        ..click();
    } else {
      final file = io.File('${await _localPath}/$name');
      await file.writeAsBytes(bytes);
    }// Page
  }

  static String _getRandomGate() {
    return '${String.fromCharCode(97 + rng.nextInt(25)).toUpperCase()}${rng.nextInt(100)}';
  }
}
