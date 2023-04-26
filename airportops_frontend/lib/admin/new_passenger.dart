// ignore_for_file: prefer_const_constructors
import 'package:airportops_frontend/classes/passenger.dart';
import 'package:airportops_frontend/enums.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

import '../widgets.dart';

class NewPassenger extends StatefulWidget {
  const NewPassenger({Key? key}) : super(key: key);

  @override
  State<NewPassenger> createState() => _NewPassengerState();
}

class _NewPassengerState extends State<NewPassenger> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _flightSourceController = TextEditingController();
  final _flightDestinationController = TextEditingController();
  final _citizenshipController = TextEditingController();
  final _seatController = TextEditingController();
  final _passengerIdController = TextEditingController();
  final _rowController = TextEditingController();
  final _boardedController = TextEditingController();
  final _eventController = TextEditingController();
  final _statusController = TextEditingController();

  late String selectedCountry = "Select a Country";

  DateTime _birthday = DateTime.now();
  DateTime _flightSourceDate = DateTime.now();
  DateTime _flightDestinationDate = DateTime.now();

  var countries = {
    "ORD": "Chicago",
    "DCA": "Washington",
    "EWR": "Newark",
    "LGA": "New York",
    "YHZ": "Halifax",
    "YYZ": "Toronto",
    "AUS": "Austin",
    "CLT": "Charlotte",
    "ATL": "Atlanta",
    "BWI": "Baltimore",
    "SFO": "San Francisco",
    "DEN": "Denver",
    "FLL": "Fort Lauderdale",
    "LAS": "Las Vegas",
    "RIC": "Richmond",
    "BNA": "Nashville",
    "LAX": "Los Angeles",
    "RSW": "Fort Myers",
    "SAV": "Savannah",
    "YUL": "Montreal",
    "DFW": "Dallas",
    "MIA": "Miami",
    "BDL": "Hartford",
    "MSY": "New Orleans",
    "ROC": "Rochester",
    "TYS": "Knoxville",
    "PHL": "Philadelphia",
    "CHS": "Charleston",
    "IND": "Indianapolis",
    "CVG": "Cincinnati",
    "SNA": "Santa Ana",
    "CUN": "Cancun",
    "CLE": "Cleveland",
    "HPN": "Westchester County",
    "JAX": "Jacksonville",
    "PIT": "Pittsburgh",
    "RDU": "Raleigh/Durham",
    "SDF": "Louisville",
    "TPA": "Tampa",
    "BOS": "Boston",
    "IAH": "Houston",
    "DTW": "Detroit",
    "MCO": "Orlando",
    "PHX": "Phoenix",
    "PTY": "Panama City",
    "CMH": "Columbus",
    "FSD": "Sioux Falls",
    "MBJ": "Montego Bay",
    "MDT": "Middletown",
    "TVC": "Traverse City",
    "BUF": "Buffalo",
    "ASE": "Aspen",
    "GSP": "Greenville",
    "COS": "Colorado Springs",
    "OMA": "Omaha",
    "TUL": "Tulsa",
    "CHA": "Chattanooga",
    "GRB": "Green Bay",
    "CID": "Cedar Rapids",
    "MBS": "Saginaw",
    "YYC": "Calgary",
    "EGE": "Vail",
    "FAR": "Fargo",
    "GRR": "Grand Rapids",
    "LIT": "Little Rock",
    "LNK": "Lincoln",
    "ICT": "Wichita",
    "MEM": "Memphis",
    "TUS": "Tucson",
    "DLH": "Duluth",
    "IAD": "Dulles",
    "PVR": "Puerto Vallarta",
    "SEA": "Seattle",
    "MKE": "Milwaukee",
    "PDX": "Portland",
    "BOI": "Boise",
    "ERI": "Erie",
    "FWA": "Fort Wayne",
    "MEX": "Mexico City",
    "MSN": "Madison",
    "MSP": "Minneapolis",
    "MCI": "Kansas City",
    "MLI": "Moline",
    "PIA": "Peoria",
    "SAN": "San Diego",
    "SLC": "Salt Lake City",
    "BZN": "Belgrade",
    "STL": "Saint Louis",
    "JAC": "Jackson",
    "MTY": "Monterrey",
    "DSM": "Des Moines",
    "ELP": "El Paso",
    "HDN": "Hayden",
    "SJD": "San Jose Cabo",
    "SMF": "Sacramento",
    "SAT": "San Antonio",
    "ATW": "Appleton",
    "SJU": "San Juan",
    "ABQ": "Albuquerque",
    "MTJ": "Montrose",
    "PSP": "Palm Springs",
    "HNL": "Honolulu",
    "FOD": "Fort Dodge",
    "FNT": "Flint",
    "SBN": "South Bend",
    "SRQ": "Sarasota",
    "SUX": "Sioux City",
    "CAK": "Akron",
    "LEX": "Lexington",
    "NRT": "Tokyo",
    "PUJ": "Punta Cana",
    "EYW": "Key West",
    "OGG": "Kahului",
    "PNS": "Pensacola",
    "BHM": "Birmingham",
    "PBI": "West Palm Beach",
    "DAY": "Dayton",
    "XNA": "Bentonville",
    "AVL": "Asheville",
    "HSV": "Huntsville",
    "HND": "Tokyo",
    "HYS": "Hays"
  };

  late List<String> sortedCountries = countries.entries
      .map((entry) => '${entry.value} - ${entry.key}')
      .toList()
    ..sort((a, b) => a.split(' ')[0].compareTo(b.split(' ')[0]));

  bool connection = false;
  bool gate = false;
  bool wrongFlight = false;

  List<String> accommodations = [];

  @override
  void submitForm() async {
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
          passengerId: Object.hash(
              _firstNameController.text,
              _lastNameController.text,
              _birthday.toIso8601String(),
              _flightSourceController.text,
              _flightDestinationController.text
          ).toString(),
          // row: int.parse(_rowController.text),
          row: 5,
          //requests: []); // You can add requests here if needed
          accommodations: [],
          status: _boardedController.text == 'true'
              ? Status.boarded
              : Status.unboarded,
          connection: connection,
          wrongGate: gate,
          wrongDeparture: wrongFlight,
          scanTime: null,
          boarded: _boardedController.text == 'true',
          event: _eventController.text,
      ); // TODO: Implement parsing accomodations

      Navigator.pop(context, newPassenger);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Passenger Page"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
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
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.date_range),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DateTimeFormField(
                          decoration: const InputDecoration(
                            labelText: 'Birthday',
                            border: OutlineInputBorder(),
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          onDateSelected: (DateTime value) {
                            setState(() {
                              _birthday = value;
                            });
                          }),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 80,
                      child: TextFormField(
                        controller: _citizenshipController,
                        decoration: const InputDecoration(
                          labelText: 'Citizenship',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 80,
                      child: TextFormField(
                        controller: _seatController,
                        decoration: const InputDecoration(
                          labelText: 'Seat No.',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CountrySelector(
                  label: "Flight Source",
                  countries: sortedCountries,
                  onSelect: (country) {
                    print("Selected country: $country");
                  },
                  controller: _flightSourceController,
                ),
                const SizedBox(height: 16),
                CountrySelector(
                  label: "Flight Destination",
                  countries: sortedCountries,
                  onSelect: (country) {
                    print("Selected country: $country");
                  },
                  controller: _flightDestinationController,
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: Text('Connection'),
                  value: connection,
                  onChanged: (value) {
                    setState(() {
                      connection = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: Text('Wrong Gate'),
                  value: gate,
                  onChanged: (value) {
                    setState(() {
                      gate = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: Text('Wrong Departure Time'),
                  value: wrongFlight,
                  onChanged: (value) {
                    setState(() {
                      wrongFlight = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
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
