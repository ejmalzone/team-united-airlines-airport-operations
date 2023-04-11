import 'dart:convert';

import 'package:airportops_frontend/classes/baggage.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/customerservice/customerservice_profile.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:airportops_frontend/main.dart';
import 'package:airportops_frontend/rampservices/rampservices_profile.dart';
import 'package:airportops_frontend/scanning.dart';
import 'package:flutter/material.dart';
import 'package:airportops_frontend/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:airportops_frontend/custom_icons_icons.dart';

final String CUSTOMER_SERVICE_KEY = "CUSTOMER_SERVICE";
final String RAMP_SERVICES_KEY = "RAMP_SERVICES";

class Admin {
  final String firstname;
  final String lastname;
  final Position position;

  Admin(this.firstname, this.lastname, this.position);
}

class Competitor {
  final String firstname;
  final String lastname;
  final String stationCode;
  final String username;
  final String event;
  final List<Baggage> bagsScanned;
  final List<Passenger> passengersScanned;
  final Position position;
  int scanned;
  int wrong;

  Competitor(
      {required this.firstname,
      required this.lastname,
      required this.stationCode,
      required this.username,
      required this.event,
      required this.bagsScanned,
      required this.passengersScanned,
      required this.position,
      required this.scanned,
      required this.wrong});

  String get fullname {
    return '$firstname $lastname';
  }

  void addpass(Passenger p) {
    passengersScanned.add(p);
  }

  void addbag(Baggage b) {
    bagsScanned.add(b);
  }

  void Reset() {
    passengersScanned.clear();
    bagsScanned.clear();
    scanned = 0;
    wrong = 0;
  }
}

// class NewCompetitorPage extends StatefulWidget {
//   // Where did the new competitor request come from? CSR or Baggage route
//   final String source;
//   const NewCompetitorPage({Key? key, required this.source}) : super(key: key);

//   @override
//   State<NewCompetitorPage> createState() => _NewCompetitorPageState();
// }

// class _NewCompetitorPageState extends State<NewCompetitorPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _stationController = TextEditingController();
//   final _usernameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("New Competitor Page"),
//         backgroundColor: Colors.black,
//       ),
//       body: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 controller: _firstNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'First Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter first name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _lastNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Last Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter last name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _stationController,
//                 decoration: const InputDecoration(
//                   labelText: 'Station',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter station';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Username',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter username';
//                   }
//                   return null;
//                 },
//               ),
//             ],
//           )),
//     );
//   }
// }

// class ExistingCompetitorPage extends StatefulWidget {
//   final String source;
//   const ExistingCompetitorPage({Key? key, required this.source})
//       : super(key: key);
//   String get getSource => source;
//   @override
//   State<ExistingCompetitorPage> createState() => _ExistingCompetitorPageState();
// }

// class _ExistingCompetitorPageState extends State<ExistingCompetitorPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     print("SOURCE: ${widget.getSource}");
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Competitor Login Page"),
//         backgroundColor: Colors.black,
//       ),
//       body: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Username',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter username';
//                   }
//                   return null;
//                 },
//               ),
//             ],
//           )),
//     );
//   }
// }

// class CompetitorSelectPage extends StatelessWidget {
//   final String source;
//   const CompetitorSelectPage({Key? key, required this.source})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("SignUp/Login"),
//           backgroundColor: Colors.black,
//         ),
//         body: Center(
//             child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//                 onPressed: () {
//                   if (source == '/csrSelect') {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 const NewCompetitorPage(source: 'CSR')));
//                   } else if (source == '/baggageSelect') {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 const NewCompetitorPage(source: 'RSE')));
//                   }
//                 },
//                 child: const Text('New User')),
//             ElevatedButton(
//                 onPressed: () {
//                   if (source == '/csrSelect') {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 const ExistingCompetitorPage(source: 'CSR')));
//                   } else if (source == '/baggageSelect') {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 const ExistingCompetitorPage(source: 'RSE')));
//                   }
//                 },
//                 child: const Text('Existing User')),
//           ],
//         )));
//   }
// }

class CustomerServiceLogin extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 1500);
  Map<String, dynamic> _competitor = {};

  Future<String?> _authUser(LoginData data) async {
    return Future.delayed(loginTime).then((_) async {
      var loginData =
          await loginCompetitor(data.name, int.parse(data.password), 0);
      if (loginData["status"] == "success") {
        var dataMap = {
          "username": data.name,
          "first": loginData["data"]["firstName"],
          "last": loginData["data"]["lastName"]
        };
        _competitor = dataMap;
        await SharedPreferences.getInstance().then((final prefs) =>
            {prefs.setString(CUSTOMER_SERVICE_KEY, jsonEncode(dataMap))});
        return null;
      }
      return "Login failed!";
    });
  }

  Future<String?> _signupUser(SignupData data) async {
    return Future.delayed(loginTime).then((_) async {
      var additionalData = data.additionalSignupData;
      var signupResponse = await signupCompetitor(
          firstName: additionalData!["first"],
          lastName: additionalData["last"],
          stationCode: additionalData["station"],
          username: data.name,
          position: 0,
          pin: int.parse(data.password!));
      if (signupResponse["status"] == "success") {
        var dataMap = {
          "username": data.name,
          "first": additionalData["first"],
          "last": additionalData["last"]
        };
        _competitor = dataMap;
        await SharedPreferences.getInstance().then((final prefs) =>
            {prefs.setString(CUSTOMER_SERVICE_KEY, jsonEncode(dataMap))});
        return null;
      }
      return "Username is already taken!";
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

  String? _passValidator(String? pass) {
    if (pass!.length != 3) {
      return "PIN must be 3 digits!";
    } else if (int.tryParse(pass) == null) {
      return "PIN provided is not a number!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Customer Service Login'),
          backgroundColor: Colors.black,
        ),
        body: FlutterLogin(
            title: 'Customer Service',
            userType: LoginUserType.name,
            logo: const AssetImage('assets/united-high-res.png'),
            hideForgotPasswordButton: true,
            userValidator: _userValidator,
            passwordValidator: _passValidator,
            onLogin: _authUser,
            onSignup: _signupUser,
            messages: LoginMessages(
                passwordHint: "3-Digit PIN",
                confirmPasswordHint: "Re-Enter PIN",
                userHint: "Unique Username",
                additionalSignUpFormDescription:
                    "Enter additional information for the judges",
                loginButton: "Login",
                signupButton: "Register",
                confirmPasswordError: "PINs do not match.",
                signUpSuccess: "Success!"),
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => CSRRoute(competitor: _competitor)));
            },
            additionalSignupFields: const [
              UserFormField(
                  keyName: "first",
                  displayName: "First Name",
                  icon: Icon(CustomIcons.font),
                  userType: LoginUserType.name),
              UserFormField(
                  keyName: "last",
                  displayName: "Last Name",
                  icon: Icon(CustomIcons.bold),
                  userType: LoginUserType.name),
              UserFormField(
                  keyName: "station",
                  displayName: "Station Code",
                  icon: Icon(CustomIcons.barcode),
                  userType: LoginUserType.name)
            ],
            onRecoverPassword: _recoverPassword,
            theme: LoginTheme(
              primaryColor: const Color.fromARGB(255, 0, 94, 170),
              accentColor: Colors.black,
              errorColor: const Color.fromARGB(255, 78, 78, 78),
            )));
  }
}

class RampServicesLogin extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 1500);

  Map<String, dynamic> _competitor = {};

  Future<String?> _authUser(LoginData data) async {
    return Future.delayed(loginTime).then((_) async {
      var loginData =
          await loginCompetitor(data.name, int.parse(data.password), 1);
      if (loginData["status"] == "success") {
        var dataMap = {
          "username": data.name,
          "first": loginData["data"]["firstName"],
          "last": loginData["data"]["lastName"]
        };
        _competitor = dataMap;
        await SharedPreferences.getInstance().then((final prefs) =>
            {prefs.setString(RAMP_SERVICES_KEY, jsonEncode(dataMap))});
        return null;
      }
      return "Login Failed!";
    });
  }

  Future<String?> _signupUser(SignupData data) async {
    return Future.delayed(loginTime).then((_) async {
      var additionalData = data.additionalSignupData;
      var signupResponse = await signupCompetitor(
          firstName: additionalData!["first"],
          lastName: additionalData["last"],
          stationCode: additionalData["station"],
          username: data.name,
          position: 1,
          pin: int.parse(data.password!));
      if (signupResponse["status"] == "success") {
        var dataMap = {
          "username": data.name,
          "first": additionalData["first"],
          "last": additionalData["last"]
        };
        _competitor = dataMap;
        await SharedPreferences.getInstance().then((final prefs) =>
            {prefs.setString(RAMP_SERVICES_KEY, jsonEncode(dataMap))});
        return null;
      }
      return "Username is already taken!";
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

  String? _passValidator(String? pass) {
    if (pass!.length != 3) {
      return "PIN must be 3 digits!";
    } else if (int.tryParse(pass) == null) {
      return "PIN provided is not a number!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ramp Services Login'),
          backgroundColor: Colors.black,
        ),
        body: FlutterLogin(
            title: 'Ramp Services',
            userType: LoginUserType.name,
            logo: const AssetImage('assets/united-high-res.png'),
            hideForgotPasswordButton: true,
            userValidator: _userValidator,
            passwordValidator: _passValidator,
            onLogin: _authUser,
            onSignup: _signupUser,
            messages: LoginMessages(
                passwordHint: "3-Digit PIN",
                confirmPasswordHint: "Re-Enter PIN",
                userHint: "Unique Username",
                additionalSignUpFormDescription:
                    "Enter additional information for the judges",
                loginButton: "Login",
                signupButton: "Register",
                confirmPasswordError: "PINs do not match.",
                signUpSuccess: "Success!"),
            onSubmitAnimationCompleted: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => BaggageRoute(competitor: _competitor)));
            },
            additionalSignupFields: const [
              UserFormField(
                  keyName: "first",
                  displayName: "First Name",
                  icon: Icon(CustomIcons.font),
                  userType: LoginUserType.name),
              UserFormField(
                  keyName: "last",
                  displayName: "Last Name",
                  icon: Icon(CustomIcons.bold),
                  userType: LoginUserType.name),
              UserFormField(
                  keyName: "station",
                  displayName: "Station Code",
                  icon: Icon(CustomIcons.barcode),
                  userType: LoginUserType.name)
            ],
            onRecoverPassword: _recoverPassword,
            theme: LoginTheme(
              primaryColor: const Color.fromARGB(255, 0, 94, 170),
              accentColor: Colors.black,
              errorColor: const Color.fromARGB(255, 78, 78, 78),
            )));
  }
}
