import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class NewPassenger extends StatefulWidget {
  const NewPassenger({Key? key}) : super(key: key);

  @override
  State<NewPassenger> createState() => _NewPassengerState();
}

class _NewPassengerState extends State<NewPassenger> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _flightSourceController = TextEditingController();
  final TextEditingController _flightDestinationController =
      TextEditingController();
  final TextEditingController _citizenshipController = TextEditingController();
  final TextEditingController _seatController = TextEditingController();
  final TextEditingController _passengerIdController = TextEditingController();
  final TextEditingController _rowController = TextEditingController();
  final TextEditingController _boardedController = TextEditingController();
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  DateTime _birthday = DateTime.now();
  DateTime _flightSourceDate = DateTime.now();
  DateTime _flightDestinationDate = DateTime.now();

  @override
  void submitForm() {
    // validate form and create new passenger object
    if (_formKey.currentState!.validate()) {
      Passenger newPassenger = Passenger(
        nameFirst: _firstNameController.text,
        nameLast: _lastNameController.text,
        //reservationNum: 0, // You can set this to a unique value
        birthday: _birthday, // Use the value from the DateTimeFormField
        flightSource: _flightSourceController.text,
        //flightSourceDate:
        //    _flightSourceDate, // Use the value from the DateTimeFormField
        flightDestination: _flightDestinationController.text,
        //flightDestinationDate:
        // _flightDestinationDate, // Use the value from the DateTimeFormField
        //citizenship: _citizenshipController.text,
        seat: _seatController.text,
        passengerId: '12345',
        // row: int.parse(_rowController.text),
        row: 5,
        boarded: _boardedController.text == 'true',
        event: _eventController.text,
        //requests: []); // You can add requests here if needed
        accommodations: [],
        status: _boardedController.text == 'true'
            ? Status.boarded
            : Status.unboarded,
      ); // TODO: Implement parsing accomodations

      Navigator.pop(context, newPassenger);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("New Passenger Page"), backgroundColor: Colors.black,),
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter First Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Last Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text.';
                    }
                    return null;
                  },
                ),
                DateTimeFormField(
                    decoration: const InputDecoration(
                        labelText: 'Select your birthday'),
                    mode: DateTimeFieldPickerMode.date,
                    onDateSelected: (DateTime value) {
                      setState(() {
                        _birthday = value;
                      });
                    }),
                TextFormField(
                  controller: _flightSourceController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Flight Source',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text.';
                    }
                    return null;
                  },
                ),
                // DateTimeFormField(
                //     decoration: const InputDecoration(
                //         labelText: 'Select Flight Source Date'),
                //     mode: DateTimeFieldPickerMode.date,
                //     onDateSelected: (DateTime value) {
                //       setState(() {
                //         _flightSourceDate = value;
                //       });
                //     }),
                TextFormField(
                  controller: _flightDestinationController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Flight Destination',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text.';
                    }
                    return null;
                  },
                ),
                // DateTimeFormField(
                //     decoration: const InputDecoration(
                //         labelText: 'Select Flight Destination Date'),
                //     mode: DateTimeFieldPickerMode.date,
                //     onDateSelected: (DateTime value) {
                //       setState(() {
                //         _flightDestinationDate = value;
                //       });
                //     }),
                TextFormField(
                  controller: _citizenshipController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Country of Citizenship',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _seatController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Seat No.',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text.';
                    }
                    return null;
                  },
                ),
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
