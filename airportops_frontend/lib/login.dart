import 'package:airportops_frontend/admin/event_details.dart';
import 'package:airportops_frontend/database.dart';
import 'package:airportops_frontend/extensions.dart';
import 'package:airportops_frontend/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:airportops_frontend/admin/admin_profile.dart';

class LoginRoute extends StatelessWidget {
  const LoginRoute({super.key});

  @override
  Widget build(BuildContext context) {
    const welcomeStyle = TextStyle(
        color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold);

    const welcomeMessage = [
      Text('Welcome to the', style: welcomeStyle),
      Text('Airport Operations', style: welcomeStyle),
      Text('TRAINING PORTAL', style: welcomeStyle)
    ];

    const loginStyle = TextStyle(
        color: Colors.white, fontSize: 14.5, fontWeight: FontWeight.bold);

    var buttonStyle = ElevatedButton.styleFrom(
        minimumSize: const Size(120, 50),
        backgroundColor: Colors.blueAccent,
        textStyle: loginStyle);

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/unitedlogo.png', fit: BoxFit.cover),
        backgroundColor: Colors.black,
        toolbarHeight: 105,
      ),
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/unitedjet.jpg'),
                  fit: BoxFit.cover)),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: welcomeMessage.withSpaceBetween(height: 6) +
                      [
                        SizedBox(
                            width: 300,
                            child: Column(children: [
                              SizedBox(height: 12),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Username', style: loginStyle)
                                  ]),
                              LoginInput(textController: usernameController, obscure: false),
                              SizedBox(height: 12),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Password', style: loginStyle)
                                  ]),
                              LoginInput(textController: passwordController, obscure: true),
                              SizedBox(height: 22),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      style: buttonStyle,
                                      onPressed: () async {
                                        await loginRequest(usernameController.text, passwordController.text)
                                        .then((response) {
                                          if (response['status'] == "success") {
                                            Navigator.pushNamed(context, '/portal');
                                          } else {
                                            usernameController.text = "Login failed!";
                                          }
                                        });
                                      },
                                      child: const Text('Submit')),
                                  ElevatedButton(
                                      style: buttonStyle,
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/home');
                                      },
                                      child: const Text('Debug'))
                                ].withSpaceBetween(width: 20),
                              )
                            ]))
                      ]))),
    );
  }
}

class PortalRoute extends StatelessWidget {
  ElevatedButton makeButton(BuildContext context, String text, String img,
      [String? endRoute]) {
    const buttonTextStyle = TextStyle(
        color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold);

    var buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(180, 180),
      backgroundColor: Colors.grey,
      textStyle: buttonTextStyle,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.5)),
    );

    return ElevatedButton(
        style: buttonStyle,
        onPressed: () async {
          if (endRoute == '/admin') {
            Map<String, dynamic> eventMap = await eventRequest();
            if (eventMap['status'] == 'success') {
              await Navigator.of(context)
                  .push(MaterialPageRoute(builder: ((context) {
                return AdminRoute(
                  eventmap: eventMap,
                );
              })));
            }
          }

          if (endRoute != null) {
            Navigator.pushNamed(context, endRoute);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Image.asset(img), Text(text, style: buttonTextStyle)]
              .withSpaceBetween(height: 8),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Portal Selection'),
          titleTextStyle: const TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          backgroundColor: Colors.black,
          toolbarHeight: 105,
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      makeButton(context, 'Customer Service',
                          'assets/icons8-airport-64.png', '/customerservice'),
                      makeButton(context, 'Ramp Service',
                          'assets/icons8-luggage-64 (1).png', '/baggage'),
                    ].withSpaceBetween(width: 36),
                  ),
                  makeButton(
                      context, 'Admin', 'assets/united-square-64.png', '/admin')
                ].withSpaceBetween(height: 36))));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_login/flutter_login.dart';
// import 'dashboard_screen.dart';

// const users = const {
//   'dribbble@gmail.com': '12345',
//   'hunter@gmail.com': 'hunter',
// };

// class LoginScreen extends StatelessWidget {
//   Duration get loginTime => Duration(milliseconds: 2250);

//   Future<String?> _authUser(LoginData data) {
//     debugPrint('Name: ${data.name}, Password: ${data.password}');
//     return Future.delayed(loginTime).then((_) {
//       if (!users.containsKey(data.name)) {
//         return 'User not exists';
//       }
//       if (users[data.name] != data.password) {
//         return 'Password does not match';
//       }
//       return null;
//     });
//   }

//   Future<String?> _signupUser(SignupData data) {
//     debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
//     return Future.delayed(loginTime).then((_) {
//       return null;
//     });
//   }

//   Future<String> _recoverPassword(String name) {
//     debugPrint('Name: $name');
//     return Future.delayed(loginTime).then((_) {
//       if (!users.containsKey(name)) {
//         return 'User not exists';
//       }
//       return null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FlutterLogin(
//       title: 'ECORP',
//       logo: AssetImage('assets/images/ecorp-lightblue.png'),
//       onLogin: _authUser,
//       onSignup: _signupUser,
//       onSubmitAnimationCompleted: () {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => DashboardScreen(),
//         ));
//       },
//       onRecoverPassword: _recoverPassword,
//     );
//   }
// }
// https://pub.dev/packages/flutter_login
