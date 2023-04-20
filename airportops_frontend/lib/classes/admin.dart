import '../enums.dart';

class Admin {
  final String username;
  final String password;

  Admin({required this.username, required this.password});

  String get usernameAdmin {
    return '$username ';
  }

  String get passwordAdmin {
    return '$username ';
  }

  static Admin fromJson(Map instance) {
    return Admin(
        password: instance['password'], username: instance['username']);
  }
}
