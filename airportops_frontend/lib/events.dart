// ignore_for_file: non_constant_identifier_names
import 'package:jiffy/jiffy.dart';

class Event {
  final String name;
  final String flight;
  final String flightSource;
  final DateTime flightSourceDate;
  final String flightDestination;
  final String Gate;

  final int numBoarded;
  final int numNoShow;
  final int numWrong;

  Event(
    this.name,
    this.flight,
    this.flightSource,
    this.flightSourceDate,
    this.flightDestination,
    this.numBoarded,
    this.numNoShow,
    this.numWrong,
    this.Gate
  );

  String get Date {
    String result = Jiffy(flightSourceDate).format('MMM do yyyy');
    return result;
  }
}
