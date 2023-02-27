class Baggage {
  final String nameFirst;
  final String nameLast;
  final String originiatingAirport;
  final String destinationAirport;
  final String bagDetails;
  final int tagNumber;
  final int numberOfBags;

  Baggage(
      this.nameFirst,
      this.nameLast,
      this.originiatingAirport,
      this.destinationAirport,
      this.bagDetails,
      this.tagNumber,
      this.numberOfBags);

  String get fullName {
    return '$nameFirst, $nameLast';
  }

  String get route {
    return '$originiatingAirport, $destinationAirport';
  }

  String get getBagType {
    return bagDetails;
  }

  int get totalBags {
    return numberOfBags;
  }

  String get baggageBar {
    return '$originiatingAirport';
  }
}
