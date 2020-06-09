import 'package:flutter/material.dart';
import '../models/Stop.dart';
class TripDetails extends StatefulWidget {
  @override
  _TripDetailsState createState() => _TripDetailsState();
}
class _TripDetailsState  extends State<TripDetails> {
  List<Stop> _stops = [];
  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    this._stops = args["stops"];
    print(this._stops[0].kidId);
    

 /*return Scaffold(
      appBar: AppBar(
        title: Text("My Kids"),
      ),
      body: 
      */
      
      
       return Scaffold(
      
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
      backgroundColor: Color(0xFF21BFBD),
        appBar: new AppBar(
          title: new Text('Driver app'),
        ),
    );
      
      
      
      
      
      
      
      
      /*Center(
          child: ListView(
        children: this._stops.map<Widget>((stop) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(stop.location),
                Text(stop.act_time),
                Container(
                 
                  width: 50,
                  height: 50,
                ),
                Text(stop.act_time),
              ],
            ),
          );
        }).toList(),
      ))
    );
*/
  }



}