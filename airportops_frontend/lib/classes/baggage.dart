class Baggage {
  final String nameFirst;
  final String nameLast;
  final String originatingAirport;
  final String destinationAirport;
  final double weight;
  final String event;
  final bool checked;

  Baggage(
      {required this.nameFirst,
      required this.nameLast,
      required this.originatingAirport,
      required this.destinationAirport,
      required this.weight,
      required this.event,
      required this.checked});

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
