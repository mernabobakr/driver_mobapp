import 'dart:convert';

import 'package:busapp/models/driver_signup_model.dart';
import 'package:http/http.dart' as http;
import 'package:busapp/utils/const_variables.dart';


 Future<http.Response> signUp(
    DriverSignupModel model) async {
   

  return http.post(
    ("http://localhost:8040/driver/new"),
    body: json.encode(model.toJson),
    headers: {
      "Content-Type": "application/json",
      
    },
  );
}




Future<http.Response> update(DriverSignupModel model, String token) async {
 

  return http.put(
    ConsVar.baseUrl+"8070/driver/update" ,
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
