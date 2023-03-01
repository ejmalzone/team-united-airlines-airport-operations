import '../enums.dart';

class Passenger {
  final String passengerId;
  final String nameFirst;
  final String nameLast;
  final DateTime birthday;
  final int row;
  final String seat;
  bool boarded;
  final String flightSource;
  final String flightDestination;
  final List accommodations;
  final String event;

  Status status = Status.unboarded;

  Passenger({
    required this.passengerId,
    required this.nameFirst,
    required this.nameLast,
    required this.birthday,
    required this.row,
    required this.seat,
    required this.boarded,
    required this.flightSource,
    required this.flightDestination,
    required this.accommodations,
    required this.event,
  });

  bool isAdult() {
    return DateTime.now().difference(birthday).inDays > (365 * 18);
  }

  String get fullName {
    return '$nameFirst $nameLast';
  }

  String get requestsString {
    if (accommodations.isEmpty) {
      return 'None';
    } else {
      return accommodations.join(', ');
    }
  }
}
