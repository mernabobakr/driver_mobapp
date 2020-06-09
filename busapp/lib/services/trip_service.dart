import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:busapp/models/trip.dart';

const String url = "http://ec2-54-198-140-29.compute-1.amazonaws.com:9090/trips/";
Future<http.Response> getTripsByDriver( String driverId,String date) {
  return http.get(
    url + date + "/driver/"+ driverId+"/",
    
  ); 
}