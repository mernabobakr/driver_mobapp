import 'dart:convert';

import 'package:busapp/models/driver_signup_model.dart';
import 'package:http/http.dart' as http;

import '../utils/const_variables.dart';


 Future<http.Response> signUp(
    DriverSignupModel model) async {
    String url = "http://localhost:8070/driver/new";

  return http.post(
    Uri.http('http://localhost:8070', '/driver/new'),
    body: json.encode(model.toJson),
    headers: {
      "Content-Type": "application/json",
      // "auth-x": token,
    },
  ).catchError((onError) {
    print(onError);
  });
}

Future<http.Response> update(DriverSignupModel model, String token) async {
  String url = "http://localhost:8070/driver/update";

  return http.put(
    Uri.http('http://localhost:8070', '/driver/update'),
    body: JsonEncoder().convert({
      "firstName": model.getFirstName(),
      "lastName": model.getLastName(),
      "email": model.getEmail(),
      //"pictureUrl": model.getPictureUrl(),
    }),
    headers: {
      "Content-Type": "application/json",
      "auth-x": token,
    },
  );
}
