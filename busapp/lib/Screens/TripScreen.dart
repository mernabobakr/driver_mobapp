import 'package:busapp/models/credentials.dart';
import 'package:flutter/material.dart';

import '../models/trip.dart';
import '../services/trip_service.dart';

class TripScreen extends StatefulWidget {
  static final String id = 'trips';

  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
 String idd;

  String date;
  String trip_type = "Morning trip";

  bool morning = true;

  List<Trip> _trips = [];
  var _isLoading = true;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    

      this.idd =  '1';
      this.date =  '2020-01-10';
      print(this.idd);
      print(this.date);

      TripService.getTripsByDriver(this.idd, this.date)
          .then((value) => this._trips = value)
          .catchError((onError) {
        print(onError);
      }).whenComplete(() {
        setState(() {
          this._isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:Color(0xFF21BFBD),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Your trips for today'),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("first name",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0)),
              accountEmail: Text(
                "email",
                style: TextStyle(color: Colors.blueGrey[50]),
              ),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.brown, child: Text("FL")),
            ),
            ListTile(
              title: Text('Your Trips for today '),
              onTap: null,
            ),
            ListTile(
              title: Text('Setting'),
              onTap: null,
            ),
            //  Divider(),
            ListTile(
              title: Text('Sign out'),
              onTap: null,
            ),

            ListTile(
              title: Text('Help'),
              onTap: null,
            ),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _isLoading
            ? Center(child: const CircularProgressIndicator())
            : _trips.isEmpty
                ? Center(
                    child: Text('You have no trips'),
                  )
                : buildTripItem(),
      ),
    );
  }

  Widget buildTripItem() {
    return ListView.builder(
      itemCount: this._trips.length,
      itemBuilder: (context, index) {
        if (!this.morning) {
          this.trip_type = "Afternoon trip";
        } else {
          this.morning = false;
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
          child: Card(
            child: ListTile(
              title: Text(this.trip_type),
              subtitle: Text("Your status is " + this._trips[index].status),
              onTap: () {
                Navigator.pushNamed(context, "Tripdetails", arguments: {
                  "stops": this._trips[index].stops,
                });
              },
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/bus2.png'),
              ),
            ),
          ),
        );
      },
    );
  }
}

