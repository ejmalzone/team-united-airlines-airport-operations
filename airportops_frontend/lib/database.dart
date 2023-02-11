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
