// ignore_for_file: non_constant_identifier_names, prefer_collection_literals
import 'package:airportops_frontend/baggage.dart';
import 'package:airportops_frontend/competitor.dart';
import 'package:airportops_frontend/passenger.dart';
import 'package:jiffy/jiffy.dart';

class Event {
  final String name;
  

  final int numBoarded;
  final int numNoShow;
  final int numWrong;

  List<Passenger> passengers = [];
  List<Baggage> bags = [];
  List<Competitor> competitors = [];

  Event(
      this.name,
      this.numBoarded,
      this.numNoShow,
      this.numWrong,
      this.passengers,
      this.bags,
      this.competitors);

  String get Date {
    String result = Jiffy(DateTime.now()).format('MMM do yyyy');
    return result;
  }

  void addPassenger(Passenger p) {
    passengers.add(p);
  }
}
