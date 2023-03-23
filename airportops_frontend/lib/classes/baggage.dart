class Baggage {
  final String nameFirst;
  final String nameLast;
  final String originiatingAirport;
  final String destinationAirport;
  final double weight;
  final String event;
  final bool checked;

  Baggage(this.nameFirst, this.nameLast, this.originiatingAirport,
      this.destinationAirport, this.weight, this.event, this.checked);

  String get fullName {
    return '$nameFirst, $nameLast';
  }

  String get route {
    return '$originiatingAirport, $destinationAirport';
  }

  String get baggageBar {
    return '$originiatingAirport';
  }
}
