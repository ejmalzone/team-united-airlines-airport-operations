import 'package:requests/requests.dart';

Future<String> testRequest() async {
  var reply = await Requests.get(
      'http://ec2-52-3-243-69.compute-1.amazonaws.com:5000/api/event/',
      json: {});
  reply.raiseForStatus();
  String body = reply.content();
  return body;
}
