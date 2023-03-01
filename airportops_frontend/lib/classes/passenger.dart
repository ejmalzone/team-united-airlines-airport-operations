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

  /* 
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
  final List<String> accomodations;
  final String event;

  //final int reservationNum;
  //final DateTime flightSourceDate;
  //final DateTime flightDestinationDate;
  //final String citizenship;
  //List<String> requests = [];
  Status status = Status.unboarded;
   */

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

  /*
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
    required this.accomodations,
    required this.event,
    //required this.reservationNum,
    //required this.flightSourceDate,
    //required this.flightDestinationDate,
    //required this.citizenship,
    //requests});
  });
       */

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

  /*String get requestsString {
    //if (requests.isEmpty) {
    if (accomodations.isEmpty) {
      return 'None';
    } else {
      //return requests.join(', ');
      return accomodations.join(', ');
    }
  }*/
}
