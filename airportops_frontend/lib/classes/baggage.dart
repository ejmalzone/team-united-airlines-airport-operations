class Baggage {
  final String nameFirst;
  final String nameLast;
  final String originatingAirport;
  final String destinationAirport;
  final int weight;
  final String event;
  final bool checked;
  final String id;

  Baggage({
    required this.nameFirst,
    required this.nameLast,
    required this.originatingAirport,
    required this.destinationAirport,
    required this.weight,
    required this.event,
    required this.checked,
    required this.id,
  });

  String get fullName {
    return '$nameFirst, $nameLast';
  }

  String get route {
    return '$originatingAirport, $destinationAirport';
  }

  String get baggageBar {
    return '$originatingAirport';
  }
}
