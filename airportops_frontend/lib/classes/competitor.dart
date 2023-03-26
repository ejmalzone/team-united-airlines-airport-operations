import 'package:airportops_frontend/enums.dart';
import 'package:flutter/material.dart';

class Competitor {
  final String firstname;
  final String lastname;
  final Position position;

  Competitor(this.firstname, this.lastname, this.position);
}

class CompetitorPage extends StatefulWidget {
  const CompetitorPage({Key? key}) : super(key: key);

  @override
  State<CompetitorPage> createState() => _CompetitorPageState();
}

class _CompetitorPageState extends State<CompetitorPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _stationController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Competitor Page"),
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
                    return 'Please enter some text';
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
                    return 'Please enter some text';
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
                    return 'Please enter some text';
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
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ],
          )),
    );
  }
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
