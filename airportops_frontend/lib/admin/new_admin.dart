// ignore_for_file: prefer_const_constructors
import 'package:airportops_frontend/classes/admin.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

import '../widgets.dart';

class NewAdmin extends StatefulWidget {
  const NewAdmin({Key? key}) : super(key: key);

  @override
  State<NewAdmin> createState() => _NewAdminState();
}

class _NewAdminState extends State<NewAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  final _usernameController = TextEditingController();

  @override
  void submitForm() async {
    // validate form and create new admin object
    if (_formKey.currentState!.validate()) {
      newAdmin admin2 = newAdmin(
          password: _passwordController.text,
          username: _usernameController.text);
      Navigator.pop(context, admin2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Bag"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty || value.length < 4) {
                      return 'Please enter a username greater than 4 characters.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty || value.length < 5) {
                      return 'Please enter a password of at least 5 characters.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        submitForm();
                      },
                      child: const Text('Submit'),
                    ))
              ],
            )));
  }
}
