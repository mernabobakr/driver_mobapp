import 'dart:convert';
import 'dart:io';

import 'package:busapp/models/driver_signup_model.dart';
import 'package:busapp/utils/const_variables.dart';
import 'package:http/http.dart' as http;

Future<http.Response> signUp(DriverSignupModel model) async {
  final sigUpUrl = ConsVar.baseUrl + ":8040/driver/new";

  return http.post(
    Uri.parse(sigUpUrl),
    body: json.encode(model.toJson),
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    },
  );
}

Future<http.Response> update(DriverSignupModel model, String token) async {
  return http.put(
    ConsVar.baseUrl + "8070/driver/update",
    body: JsonEncoder().convert({
      "firstName": model.getFirstName(),
      "lastName": model.getLastName(),
      "email": model.getEmail(),
      "picUrl": model.getPictureUrl(),
    }),
    headers: {
      "Content-Type": "application/json",
      "auth-x": token,
    },
  );
}
