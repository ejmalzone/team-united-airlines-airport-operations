import '../enums.dart';

class newAdmin {
  final String username;
  final String password;

  newAdmin({required this.username, required this.password});

  String get usernameAdmin {
    return '$username ';
  }

  String get passwordAdmin {
    return '$username ';
  }

  static newAdmin fromJson(Map instance) {
    return newAdmin(
        password: instance['password'], username: instance['username']);
  }
}
