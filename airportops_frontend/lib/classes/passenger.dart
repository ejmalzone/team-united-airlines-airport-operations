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
  final bool connection;
  final bool wrongGate;
  final bool wrongDeparture;
  final String? scanTime;

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
    required this.status,
    required this.connection,
    required this.wrongGate,
    required this.wrongDeparture,
    required this.scanTime
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

  static Passenger fromJson(Map<String, dynamic> instance) {
    return Passenger(
      accommodations: instance['accommodations'] ?? <String>[],
      passengerId: instance['_id'],
      birthday: DateTime.parse(instance['DOB']),
      boarded: instance['boarded'] == true,
      event: instance['event'],
      flightDestination: instance['destination'],
      flightSource: instance['origin'],
      nameFirst: instance['firstName'],
      nameLast: instance['lastName'],
      row: instance['row'],
      seat: instance['seat'],
      status: instance['boarded'] ? Status.boarded : Status.unboarded,
      connection: instance['connection'],
      wrongGate: instance['wrongGate'],
      wrongDeparture: instance['wrongDeparture'],
      scanTime: instance['scanTime']
    );
  }
}
