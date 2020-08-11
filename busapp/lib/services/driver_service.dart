import 'dart:convert';
import 'package:busapp/models/driver_signup_model.dart';
import 'package:busapp/utils/const_variables.dart';
import 'package:http/http.dart' as http;
import '../models/trip.dart';



 Future<http.Response> signUp(
    DriverSignupModel model, String token) async {
    String url = "http://localhost:8070/driver/new";

return http.post(
    url ,
      body: JsonEncoder().convert({
      "firstName": model.getFirstName(),
      "lastName": model.getLastName(),
      "email": model.getEmail(),
      "pictureUrl": model.getPictureUrl(),
    }),
    headers: {
      "Content-Type": "application/json",
      "auth-x": token,
    },
   
  );

}

 Future<http.Response> update(
    DriverSignupModel model, String token) async {
    String url = "http://localhost:8070/driver/update";

return http.post(
    url ,
      body: JsonEncoder().convert({
      "firstName": model.getFirstName(),
      "lastName": model.getLastName(),
      "email": model.getEmail(),
      "pictureUrl": model.getPictureUrl(),
    }),
    headers: {
      "Content-Type": "application/json",
      "auth-x": token,
    },
   
  );

}

