import 'package:airportops_frontend/enums.dart';
import 'package:flutter/material.dart';

class Competitor {
  final String firstname;
  final String lastname;
  final Position position;

  Competitor(this.firstname, this.lastname, this.position);
}

class CompetitorProfile {
  final String firstname;
  final String lastname;
  final String stationCode;
  final String username;
  final String event;
  final String bagsScanned;
  final String passengersScanned;
  final Position position;

  CompetitorProfile(
    this.firstname,
    this.lastname,
    this.stationCode,
    this.username,
    this.event,
    this.bagsScanned,
    this.passengersScanned,
    this.position,
  );
}

class NewCompetitorPage extends StatefulWidget {
  // Where did the new competitor request come from? CSR or Baggage route
  final String source;
  const NewCompetitorPage({Key? key, required this.source}) : super(key: key);

  @override
  State<NewCompetitorPage> createState() => _NewCompetitorPageState();
}

class _NewCompetitorPageState extends State<NewCompetitorPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _stationController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Competitor Page"),
        backgroundColor: Colors.black,
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stationController,
                decoration: const InputDecoration(
                  labelText: 'Station',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter station';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
            ],
          )),
    );
  }
}

class ExistingCompetitorPage extends StatefulWidget {
  final String source;
  const ExistingCompetitorPage({Key? key, required this.source})
      : super(key: key);
  String get getSource => source;
  @override
  State<ExistingCompetitorPage> createState() => _ExistingCompetitorPageState();
}

class _ExistingCompetitorPageState extends State<ExistingCompetitorPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print("SOURCE: ${widget.getSource}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Competitor Login Page"),
        backgroundColor: Colors.black,
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
            ],
          )),
    );
  }
}

class CompetitorSelectPage extends StatelessWidget {
  final String source;
  const CompetitorSelectPage({Key? key, required this.source})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SignUp/Login"),
          backgroundColor: Colors.black,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  if (source == '/csrSelect') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const NewCompetitorPage(source: 'CSR')));
                  } else if (source == '/baggageSelect') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const NewCompetitorPage(source: 'RSE')));
                  }
                },
                child: const Text('New User')),
            ElevatedButton(
                onPressed: () {
                  if (source == '/csrSelect') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ExistingCompetitorPage(source: 'CSR')));
                  } else if (source == '/baggageSelect') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ExistingCompetitorPage(source: 'RSE')));
                  }
                },
                child: const Text('Existing User')),
          ],
        )));
  }
}
