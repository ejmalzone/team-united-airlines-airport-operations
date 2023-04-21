import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../enums.dart';

const _assetLocations = [
  "assets/bag-backpack.png",
  "assets/bag-purse.png",
  "assets/bag-suitcase.png"
];

class Baggage {
  final String nameFirst;
  final String nameLast;
  final String originatingAirport;
  final String destinationAirport;
  final int weight;
  final String event;
  final bool checked;
  final String id;
  final bool wrongDestination;
  final String? scanTime;
  late Image thumbnail;

  Status status = Status.unboarded;

  Baggage(
      {required this.nameFirst,
      required this.nameLast,
      required this.originatingAirport,
      required this.destinationAirport,
      required this.weight,
      required this.event,
      required this.checked,
      required this.id,
      required this.status,
      required this.wrongDestination,
      required this.scanTime}) {
    final rng = Random(Object.hash(nameFirst, nameLast));
    thumbnail =
        Image.asset(_assetLocations[rng.nextInt(_assetLocations.length)]);
  }

  String get fullName {
    return '$nameFirst $nameLast';
  }

  String get route {
    return '$originatingAirport, $destinationAirport';
  }

  String get baggageBar {
    return originatingAirport;
  }

  static Baggage fromJson(Map instance) {
    print(instance['scanTime'].runtimeType);
    return Baggage(
      checked: instance['checked'],
      destinationAirport: instance['destination'],
      event: instance['event'],
      nameFirst: instance['passengerFirst'],
      nameLast: instance['passengerLast'],
      originatingAirport: instance['origin'],
      weight: instance['weight'],
      id: instance['_id'],
      status: instance['checked'] ? Status.unboarded : Status.boarded,
      wrongDestination: instance['wrongDestination'],
      scanTime: (instance['scanTime'] ?? 'Not yet scanned.')
    );
  }
}
