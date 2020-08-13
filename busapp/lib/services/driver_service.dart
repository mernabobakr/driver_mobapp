import 'dart:convert';

import 'package:busapp/models/driver_signup_model.dart';
import 'package:http/http.dart' as http;
import 'package:busapp/utils/const_variables.dart';


 Future<http.Response> signUp(
    DriverSignupModel model,String token) async {
   

  return http.post(
    Uri.http(ConsVar.baseUrl, ':8070/driver/new'),
    body: json.encode(model.toJson),
    headers: {
      "Content-Type": "application/json",
      "auth-x": token,
    },
  ).catchError((onError) {
    print(onError);
  });
}

Future<http.Response> getdriverId(String token) {

 
  return http.get(ConsVar.baseUrl+"8070/driver/user" , headers: {"auth-x": token});
}


Future<http.Response> update(DriverSignupModel model, String token) async {
 

  return http.put(
    ConsVar.baseUrl+"8070/driver/update" ,
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
