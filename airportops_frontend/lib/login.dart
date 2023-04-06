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

// class LoginRoute extends StatelessWidget {
//   const LoginRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const welcomeStyle = TextStyle(
//         color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold);

//     const welcomeMessage = [
//       Text('Welcome to the', style: welcomeStyle),
//       Text('Airport Operations', style: welcomeStyle),
//       Text('Training Portal', style: welcomeStyle)
//     ];

//     const loginStyle = TextStyle(
//         color: Colors.white, fontSize: 14.5, fontWeight: FontWeight.bold);

//     var buttonStyle = ElevatedButton.styleFrom(
//         minimumSize: const Size(120, 50),
//         backgroundColor: Colors.blueAccent,
//         textStyle: loginStyle);

//     TextEditingController usernameController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Image.asset('assets/unitedlogo.png', fit: BoxFit.cover),
//         backgroundColor: Colors.black,
//         toolbarHeight: 105,
//       ),
//       body: Container(
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage('assets/unitedjet.jpg'),
//                   fit: BoxFit.cover)),
//           child: Center(
//               child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: welcomeMessage.withSpaceBetween(height: 6) +
//                       [
//                         SizedBox(
//                             width: 300,
//                             child: Column(children: [
//                               SizedBox(height: 12),
//                               Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text('Username', style: loginStyle)
//                                   ]),
//                               LoginInput(
//                                   textController: usernameController,
//                                   obscure: false),
//                               SizedBox(height: 12),
//                               Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text('Password', style: loginStyle)
//                                   ]),
//                               LoginInput(
//                                   textController: passwordController,
//                                   obscure: true),
//                               SizedBox(height: 22),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   ElevatedButton(
//                                       style: buttonStyle,
//                                       onPressed: () async {
//                                         await loginRequest(
//                                                 usernameController.text,
//                                                 passwordController.text)
//                                             .then((response) async {
//                                           if (response['status'] == "success") {
//                                             // TODO:
//                                             //Navigator.pushNamed(
//                                             //    context, '/portal');

//                                             Map<String, dynamic> eventMap =
//                                                 await eventRequest();
//                                             if (eventMap['status'] ==
//                                                 'success') {
//                                               await Navigator.of(context).push(
//                                                   MaterialPageRoute(
//                                                       builder: ((context) {
//                                                 return AdminRoute(
//                                                     eventmap: eventMap);
//                                               })));
//                                             }
//                                           } else {
//                                             showDialog<dynamic>(
//                                                 context: context,
//                                                 builder:
//                                                     (BuildContext context) =>
//                                                         AlertDialog(
//                                                           title: const Text(
//                                                               "Login failed!"),
//                                                           content: const Text(
//                                                               "Check username or password."),
//                                                           actions: <Widget>[
//                                                             TextButton(
//                                                               child: const Text(
//                                                                   'OK'),
//                                                               onPressed: () =>
//                                                                   Navigator.pop(
//                                                                       context,
//                                                                       'ack'),
//                                                             ),
//                                                           ],
//                                                         ));
//                                           }
//                                         });
//                                       },
//                                       child: const Text('Submit')),
//                                   ElevatedButton(
//                                       style: buttonStyle,
//                                       onPressed: () {
//                                         Navigator.pushNamed(context, '/home');
//                                       },
//                                       child: const Text('Debug'))
//                                 ].withSpaceBetween(width: 20),
//                               )
//                             ]))
//                       ]))),
//     );
//   }
// }

// }

class LoginRoute extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Map<String, dynamic> _events = {};
  Map<String, dynamic> curr_event = {};

  Future<String?> _authUser(LoginData data) async {
    return Future.delayed(loginTime).then((_) async {
      var loginData = await loginRequest(data.name, data.password);
      if (loginData["status"] == "success") {
        Map<String, dynamic> eventMap = await eventRequest();
        Map<String, dynamic> curr_eventMap = await getCurrentEvent();
        if (eventMap['status'] == 'success') {
          _events = eventMap;
          curr_event = curr_eventMap;
          await SharedPreferences.getInstance()
              .then((final prefs) => {prefs.setString(ADMIN_KEY, data.name)});
          return null;
        }
        return "Something went wrong! Please try again.";
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
                  builder: (context) => AdminRoute(eventmap: _events, curreventmap: curr_event)));
            },
            onRecoverPassword: _recoverPassword,
            messages:
                LoginMessages(userHint: "Username", passwordHint: "Password"),
            theme: LoginTheme(
              primaryColor: const Color.fromARGB(255, 0, 94, 170),
              errorColor: const Color.fromARGB(255, 78, 78, 78),
              accentColor: Colors.black,
            )));
  }
}
//https://pub.dev/packages/flutter_login
