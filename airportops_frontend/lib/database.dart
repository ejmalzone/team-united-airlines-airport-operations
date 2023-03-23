// ignore_for_file: non_constant_identifier_names

import 'package:requests/requests.dart';
import 'dart:convert';

//Future<String> testRequest() async {
Future<Map<String, dynamic>> testRequest() async {
  var reply = await Requests.get(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/event/');
  reply.raiseForStatus();
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  return data;
}

Future<Map<String, dynamic>> passengerRequest() async {
  var reply = await Requests.get(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/passenger/');
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

Future<Map<String, dynamic>> eventRequest() async {
  var reply = await Requests.get(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/event/');
  String body = reply.content();
// decoding with convert
  Map<String, dynamic> data = jsonDecode(body);
  print(data);
  return (data);
}

Future<Map<String, dynamic>> signupRequest() async {
  var reply = await Requests.post(
    'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/admin/signup');
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  return (data);
}

Future<Map<String, dynamic>> loginRequest(String username, String password) async {
  var reply = await Requests.post(
    'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/admin/login', json: {"username": username, "password": password});
  String body = reply.content();
  Map<String, dynamic> data = jsonDecode(body);
  return (data);
}