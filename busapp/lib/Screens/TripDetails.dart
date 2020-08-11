import 'package:flutter/material.dart';

import '../models/Stop.dart';

class TripDetails extends StatefulWidget {
  static final String id = 'Tripdetails';

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  List<Stop> _stops = [];

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    this._stops = args["stops"];
    // print(this._stops[0].kidId);

    return Scaffold(
        backgroundColor: Color(0xFF21BFBD),
        appBar: new AppBar(
          title: new Text('Driver app'),
        ),
        body: ListView.builder(
          itemCount: this._stops.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  title: Text(this._stops[index].location),
                  subtitle: Text("The expected time to reach is" +
                      this._stops[index].expTime),
                  onTap: () {},
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/location.jpg'),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
