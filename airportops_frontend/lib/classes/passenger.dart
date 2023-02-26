import '../enums.dart';

class Passenger {
  final String nameFirst;
  final String nameLast;
  final int reservationNum;
  final DateTime birthday;
  final String flightSource;
  final DateTime flightSourceDate;
  final String flightDestination;
  final DateTime flightDestinationDate;
  final String citizenship;
  final String seat;

  List<String> requests = [];
  Status status = Status.unboarded;

  Passenger(
      {required this.nameFirst,
      required this.nameLast,
      required this.reservationNum,
      required this.birthday,
      required this.flightSource,
      required this.flightSourceDate,
      required this.flightDestination,
      required this.flightDestinationDate,
      required this.citizenship,
      required this.seat,
      requests});

  

  bool isAdult() {
    return DateTime.now().difference(birthday).inDays > (365 * 18);
  }

  String get fullName {
    return '$nameFirst $nameLast';
  }

  String get requestsString {
    if (requests.isEmpty) {
      return 'None';
    } else {
      return requests.join(', ');
    }
  }
}
