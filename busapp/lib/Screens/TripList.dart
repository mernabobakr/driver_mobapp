import 'package:http/http.dart' as http;
import '../services/trip_service.dart' as tripService;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/trip.dart';

class TripList extends StatefulWidget {
  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  String id = '1';
  String date = '2020-01-30';

  List<trip> _stops = [];
  Map<String, dynamic> _tripMap;
  void intializeTripssList(http.Response response) {
    print('started');
    print(response.statusCode);
    if (response.statusCode == 200) {
      _tripMap = JsonDecoder().convert(response.body);

      //print('gwa d');

     // print(this._tripMap);

      //print(_tripMap["date"]);

   //   print(this._stops);
      print('finished');
    }
  }

  void listKids() {
    tripService.getTripsByDriver(id, date).then(this.intializeTripssList);
    print('gwa listkid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ho'),
      ),
      body: RaisedButton(
        child: Text("Submit"),
        onPressed: this.listKids,
        color: Colors.orange[400],
      ),
    );
  }
}
