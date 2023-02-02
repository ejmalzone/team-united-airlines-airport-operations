import 'package:flutter/material.dart';

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
