// ignore_for_file: use_build_context_synchronously

import 'package:airportops_frontend/admin/admin_profile.dart';
import 'package:airportops_frontend/admin/event_details.dart';
import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/extensions.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:airportops_frontend/admin/admin_profile.dart';
import 'portal.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String ADMIN_KEY = "ADMIN_KEY";

class LoginRoute extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    return Future.delayed(loginTime).then((_) async {
      var loginData = await loginRequest(data.name, data.password);
      if (loginData["status"] == "success") {
        Map<String, dynamic> eventMap = await eventRequest();
        Map<String, dynamic> curr_eventMap = await getCurrentEvent();
        await SharedPreferences.getInstance()
            .then((final prefs) => {prefs.setString(ADMIN_KEY, data.name)});
        return null;
      }
      return "Password does not match";
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return "User not exists";
    });
  }

  String? _userValidator(String? name) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Admin Login'),
          backgroundColor: Colors.black,
        ),
        body: FlutterLogin(
            title: 'Admin',
            userType: LoginUserType.name,
            logo: const AssetImage('assets/united-high-res.png'),
            hideForgotPasswordButton: true,
            userValidator: _userValidator,
            onLogin: _authUser,
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AdminRoute()
                )
              );
            },
            onRecoverPassword: _recoverPassword,
            messages:
                LoginMessages(userHint: "Username", passwordHint: "Password"),
            theme: LoginTheme(
              primaryColor: const Color(0xFF005DAA),
              errorColor: const Color.fromARGB(255, 78, 78, 78),
              accentColor: Colors.black,
            )));
  }
}
//https://pub.dev/packages/flutter_login
