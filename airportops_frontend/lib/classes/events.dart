// ignore_for_file: non_constant_identifier_names, prefer_collection_literals
import 'package:airportops_frontend/classes/baggage.dart';
import 'package:airportops_frontend/classes/competitor.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:jiffy/jiffy.dart';

class Event {
  final String name;

  int p_boarded;
  int p_unboarded;
  int p_wrong;

  int b_boarded;
  int b_unboarded;
  int b_wrong;

  List<Passenger> passengers = [];
  List<Baggage> bags = [];
  List<Competitor> competitors = [];

  Event(
      this.name,
      this.p_boarded,
      this.p_unboarded,
      this.p_wrong,
      this.b_boarded,
      this.b_unboarded,
      this.b_wrong,
      this.passengers,
      this.bags,
      this.competitors) {}

  String get Date {
    String result = Jiffy(DateTime.now()).format('MMM do yyyy');
    return result;
  }

  void addPassenger(Passenger p) {
    passengers.add(p);
  }

  void addCompetitor(Competitor c) {
    competitors.add(c);
  }

  void addBag(Baggage b) {
    bags.add(b);
  }

  void Reset() {
    passengers.clear();
    bags.clear();
    competitors.clear();
    p_boarded = 0;
    p_unboarded = 0;
    p_wrong = 0;
    b_boarded = 0;
    b_unboarded = 0;
    b_wrong = 0;
  }
}
