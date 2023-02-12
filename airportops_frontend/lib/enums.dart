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
