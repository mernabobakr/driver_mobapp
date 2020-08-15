import 'dart:convert';

import 'package:busapp/utils/const_variables.dart';
import 'package:http/http.dart' as http;

Future<http.Response> ackToken(String phoneNumber, String token) {
  return http.post(
    ConsVar.baseUrl + ":8097/sms/ack",
    body: JsonEncoder().convert({"number": phoneNumber, "token": token}),
    headers: {"Content-Type": "application/json"},
  );
}

Future<http.Response> verifyPhoneNumber(String phoneNumber) {
  return http.get(ConsVar.baseUrl + ":8097/sms/verify/" + phoneNumber);
}
