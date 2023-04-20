// ignore_for_file: prefer_const_constructors
import 'package:airportops_frontend/classes/admin.dart';
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

import '../widgets.dart';

class NewBag extends StatefulWidget {
  const NewBag({Key? key}) : super(key: key);

  @override
  State<NewBag> createState() => _NewBagState();
}

class _NewBagState extends State<NewBag> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  final _usernameController = TextEditingController();

  @override
  void submitForm() async {
    // validate form and create new admin object
    if (_formKey.currentState!.validate()) {
      Admin newAdmin = Admin(
          password: _passwordController.text,
          username: _usernameController.text);
      Navigator.pop(context, newAdmin);
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
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text.';
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
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text.';
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
