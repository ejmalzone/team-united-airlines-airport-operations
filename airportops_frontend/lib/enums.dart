// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum Position {
  Ramp,
  Csr,
  Admin
}
enum Accommodations {
  wheelchair,
  stroller
}

enum Status {
  boarded,
  noShow,
  wrongFlight,
  unboarded
}

extension StatusExtension on Status {
  static const colors = {
    Status.boarded: Colors.green,
    Status.noShow: Colors.red,
    Status.wrongFlight: Colors.yellow,
    Status.unboarded: Colors.black
  };

  Color get color => colors[this] ?? Colors.black;
}

extension ImageExtension on Position {
  static const icons = {
    Position.Admin:'assets/united-airlines-logo-emblem-png-5.png' ,
    Position.Ramp:'assets/icons8-luggage-64 (1).png',
    Position.Csr:'assets/icons8-airport-64.png',

  };

  String get icon => icons[this] ?? 'assets/united-airlines-logo-emblem-png-5.png';
}
