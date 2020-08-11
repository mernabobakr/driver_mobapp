import 'package:flutter/material.dart';

import '../models/trip.dart';
import '../services/trip_service.dart';

class TripList extends StatefulWidget {
  static final String id = 'trip';

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  String id = '1';
  String date = '2020-01-30';

  List<Trip> _stops = [];

  void listKids() {
    TripService.getTripsByDriver(id, date).then((value) => _stops = value);
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
