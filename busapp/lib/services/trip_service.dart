import 'dart:convert';

import 'package:busapp/utils/const_variables.dart';
import 'package:http/http.dart' as http;

import '../models/trip.dart';

class TripService {
  static Future<List<Trip>> getTripsByDriver(
      String driverId, String date) async {
    String url = '${ConsVar.baseUrl}trips/$date/driver/$driverId/';
    print(url);
    final http.Response response = await http.get(url);

    List<Trip> tripList = [];
    if (response?.statusCode == 200) {
      List<dynamic> bodyMap = json.decode(response.body);
      tripList = Trip.tripList(bodyMap);
    } else {
      tripList = [];
    }
    return tripList;
  }
}
