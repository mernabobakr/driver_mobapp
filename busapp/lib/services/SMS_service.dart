import 'package:http/http.dart' as http;
import 'dart:convert';

const String url = "http://http://ec2-54-198-140-29.compute-1.amazonaws.com:8097";
Future<http.Response> ackToken(String phoneNumber, String token) {
  return http.post(
    url + "/sms/ack",
    body: JsonEncoder().convert(
        {"number": phoneNumber, "token": token}),
    headers: {"Content-Type": "application/json"},
  );
}

Future<http.Response> verifyPhoneNumber(String phoneNumber) {
  return http.get(
    url + "/sms/verify/" + phoneNumber
  );
}
