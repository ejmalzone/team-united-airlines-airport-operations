
class Passenger {
  final String nameFirst;
  final String nameLast;
  final DateTime birthday;
  final String flightSource;
  final DateTime flightSourceDate;
  final String flightDestination;
  final DateTime flightDestinationDate;
  final String citizenship;
  final String seat;

  Passenger(
      this.nameFirst,
      this.nameLast,
      this.birthday,
      this.flightSource,
      this.flightSourceDate,
      this.flightDestination,
      this.flightDestinationDate,
      this.citizenship,
      this.seat);

  bool isAdult() {
    return DateTime.now().difference(birthday).inDays > (365 * 18);
  }

  String get fullName {
    return '$nameFirst $nameLast';
  }
}
