
class Passenger {
  final String nameFirst;
  final String nameLast;
  final DateTime birthday;

  Passenger(this.nameFirst, this.nameLast, this.birthday);

  bool isAdult() {
    return DateTime.now().difference(birthday).inDays > (365 * 18);
  }
}
