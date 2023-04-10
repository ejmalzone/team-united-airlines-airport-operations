import '../enums.dart';

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

  Status status = Status.unboarded;

  Baggage({
    required this.nameFirst,
    required this.nameLast,
    required this.originatingAirport,
    required this.destinationAirport,
    required this.weight,
    required this.event,
    required this.checked,
    required this.id,
    required this.status,
    required this.wrongDestination
  });

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
      wrongDestination: instance['wrongDestination']
    );
  }
}
