// ignore_for_file: non_constant_identifier_names

import 'package:requests/requests.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

//Future<String> testRequest() async {
Future<Map<String, dynamic>> testRequest() async {
  var reply = await Requests.get(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/event/');
  reply.raiseForStatus();
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return data;
}

Future<Map<String, dynamic>> currPassengerRequest() async {
  var reply = await Requests.post(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/filtered/passenger/');
  reply.raiseForStatus();
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return data;
}

Future<Map<String, dynamic>> eventPost(String name) async {
  var reply = await Requests.post(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/event/',
      json: {"name": name});
  String body = reply.content();
// decoding with convert
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return (data);
}

Future<Map<String, dynamic>> deleteEvent({required String eventId}) async {
  var reply = await Requests.delete(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/event/',
      json: {"eventId": eventId});
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  return data;
}

Future<Map<String, dynamic>> eventRequest() async {
  var reply = await Requests.get(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/event/');
  String body = reply.content();
// decoding with convert
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return (data);
}

Future<Map<String, dynamic>> getCurrentEvent() async {
  var reply = await Requests.get(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/event/current/');
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return (data);
}

Future<Map<String, dynamic>> signupRequest(
    String username, String password) async {
  var reply = await Requests.post(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/admin/signup',
      json: {"username": username, "password": password, "access": 2});
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print("DATA: ${data}");
  return (data);
}

Future<Map<String, dynamic>> loginRequest(
    String username, String password) async {
  var reply = await Requests.post(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/admin/login',
      json: {"username": username, "password": password});
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return (data);
}

Future<Map<String, dynamic>> usernameValidation(String username) async {
  var reply = await Requests.post(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/admin/validate',
      json: {"username": username});
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return (data);
}

Future<Map<String, dynamic>> passengerRequest(String event) async {
  var reply = await Requests.post(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/filtered/passenger/',
      json: {"event": event});
  String body = reply.content();
  // decoding with convert
  Map<String, dynamic> data = jsonDecode(body);
  //print(data);
  return data;
}

Future<Map<String, dynamic>> bagsRequest(String event) async {
  var reply = await Requests.post(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/filtered/bag/',
      json: {"event": event});
  String body = reply.content();
  // decoding with convert
  Map<String, dynamic> data = jsonDecode(body);
  //print(data);
  return data;
}

/// Set the event and return success or error if it was successful.
/// [name] The name of the event
Future<Map<String, dynamic>> setEvent(String name) async {
  var reply = await Requests.post(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/filtered/event/',
      json: {"setEvent": "true", "name": name});
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return data;
}

Future<Map<String, dynamic>> createPassenger(
    {required String first,
    required String last,
    required String DOB,
    required int row,
    required String seat,
    required String originAirport,
    required String destinationAirport,
    List<String>? accommodations,
    bool? connection,
    bool? gate,
    bool? wrongFlight,
    required String event}) async {
  var reply = await Requests.post(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/passenger/',
      json: {
        "firstName": first,
        "lastName": last,
        "DOB": DOB,
        "row": row,
        "seat": seat,
        "origin": originAirport,
        "destination": destinationAirport,
        "accommodations": accommodations,
        "event": event,
        "connection": connection,
        "wrongGate" : gate,
        "wrongDeparture": wrongFlight
      });
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return data;
}

Future<Map<String, dynamic>> deletePassenger(
    {required String passengerId}) async {
  var reply = await Requests.delete(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/passenger/',
      json: {"passengerId": passengerId});
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return data;
}

Future<Map<String, dynamic>> signupCompetitor(
    {required String? firstName,
    required String? lastName,
    required String? stationCode,
    required String? username,
    required int position,
    required int? pin}) async {
  var reply = await Requests.post(
      "http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/competitor/",
      json: {
        "firstName": firstName,
        "lastName": lastName,
        "stationCode": stationCode,
        "username": username,
        "position": position,
        "pin": pin
      });
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return data;
}

Future<Map<String, dynamic>> loginCompetitor(
    String username, int pin, int from) async {
  print(from);
  var reply = await Requests.post(
      "http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/competitor/login",
      json: {"username": username, "pin": pin, "from": from});
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return data;
}

Future<Map<String, dynamic>> validateCompetitor(String username) async {
  var reply = await Requests.post(
      "http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/filtered/competitor",
      json: {"username": username});
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return data;
}

Future<Map<String, dynamic>> competitorRequest(String event) async {
  var reply = await Requests.post(
      "http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/filtered/competitor",
      json: {"event": event});
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return data;
}

Future<Map<String, dynamic>> createBag(
    {required String passengerFirst,
    required String passengerLast,
    required String origin,
    required String destination,
    required int weight,
    required bool wrongDestination,
    required String event}) async {
  var reply = await Requests.post(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/bag/',
      json: {
        "passengerFirst": passengerFirst,
        "passengerLast": passengerLast,
        "origin": origin,
        "destination": destination,
        "weight": weight,
        "wrongDestination": wrongDestination,
        "event": event
      });
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return data;
}

Future<Map<String, dynamic>> deleteBag({required String bagId}) async {
  var reply = await Requests.delete(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/bag/',
      json: {"bagId": bagId});
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  return data;
}

Future<Map<String, dynamic>> scanBag(
    {required String bagId, required String competitor}) async {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm-ss');
  final String formatted = formatter.format(now);
  var reply = await Requests.put(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/bag/',
      json: {
        "bagId": bagId,
        "competitor": competitor,
        "scanTime": formatted
      });
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  return data;
}

Future<Map<String, dynamic>> scanPassenger(
    {required String passengerId, required String competitor}) async {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm-ss');
  final String formatted = formatter.format(now);
  var reply = await Requests.put(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/passenger/',
      json: {
        "passengerId": passengerId,
        "competitor": competitor,
        "scanTime": formatted
      });
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  return data;
}


