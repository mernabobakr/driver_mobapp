import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/trip_service.dart' as tripService;
import 'dart:convert';
import '../models/Stop.dart';
import '../models/trip.dart';

class TripScreen extends StatefulWidget {
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  String id;

  String date;
  String trip_type = "Morning trip";

  bool morning = true;

  List<trip> _trips = [];
  bool _requestSent = false;
  var _isLoading = true;

  void intializeTripssList(http.Response response) {
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> bodyMap = JsonDecoder().convert(response.body);
      var tripsList = bodyMap.map<trip>((e) {
        return trip(
            e["driverId"].toString(),
            e["date"],
            e["status"],
            e["stops"].map<Stop>((o) {
              return Stop(o["stopId"], o["location"], o["exp_time"],
                  o["act_time"], o["kidId"]);
            }).toList());
      }).toList();
      setState(() {
        this._trips = tripsList;

        this._requestSent = true;
      });
    }
  }

  void initState() {
    super.initState();

    /*
     var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    this.id = args["driverId"];
    this.date = args["date"];
    if (!this._requestSent) {
      print("sending request");
      tripService
          .getTripsByDriver(this.id, this.date)
          .then(this.intializeTripssList)
          .then((_) {
   this._isLoading = false;
      });
    }
   */
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    this.id = args["driverId"];
    this.date = args["date"];
    print(this.id);
    print(this.date);
    if (!this._requestSent) {
      print("sending request");
      tripService
          .getTripsByDriver(this.id, this.date)
          .then(this.intializeTripssList)
          .then((_) {
        this._isLoading = false;
      });
    }

    return Scaffold(
        backgroundColor: Color(0xFF21BFBD),
        appBar: new AppBar(
          title: new Text('Your trips for today'),
        ),
        drawer: new Drawer(
            child: new Column(children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new Text("Firstname Lastname",
                style: new TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0)),
            accountEmail: new Text(
              "firstname@lastname.com",
              style: new TextStyle(color: Colors.blueGrey[50]),
            ),
            currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.brown, child: new Text("FL")),
          ),
          new ListTile(
            title: new Text('Your Trips for today '),
            onTap: null,
          ),
          new ListTile(
            title: new Text('Setting'),
            onTap: null,
          ),
          // new Divider(),
          new ListTile(
            title: new Text('Sign out'),
            onTap: null,
          ),

          new ListTile(
            title: new Text('Help'),
            onTap: null,
          ),
        ])),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : 
              
               
                this.buildTripItem(context)
             
              );
  }



  Widget buildTripItem(context) {
    return ListView.builder(
        itemCount: this._trips.length,
        itemBuilder: (context, index) {
          if (this.morning == false) {
            this.trip_type = "Afternoon trip";
          } else {
            this.morning = false;
          }
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  title: Text(this.trip_type),
                  subtitle: Text("Your status is " + this._trips[index].status),
                  onTap: () {},
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/bus2.png'),
                  ),
                ),

                //
              ));
        });
  }
}
