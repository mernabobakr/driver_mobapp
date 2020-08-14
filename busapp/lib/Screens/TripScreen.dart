import 'dart:convert';

import 'package:busapp/Screens/start_page.dart';
import 'package:busapp/models/credentials.dart';
import 'package:busapp/models/driver_signup_model.dart';
import 'package:busapp/utils/const_variables.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  DriverSignupModel currentUser;

  Future<DriverSignupModel> getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String result = preferences.getString(ConsVar.userKey);
    return DriverSignupModel.fromJson(json.decode(result));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this.idd = Credentials.driverId ?? '1';
      this.date = '2020-01-10';
      print(this.idd);
      print(this.date);
      getUserInfo().then((value) => currentUser = value).whenComplete(() {
        setState(() {});
      });
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
        backgroundColor: Color(0xFF21BFBD),
        title: Text('Your trips for today'),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "${currentUser.getFirstName()} ${currentUser.getLastName()}",
              ),
              accountEmail: Text(
                "${currentUser.getEmail()}",
                style: TextStyle(color: Colors.blueGrey[50]),
              ),
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Image.network(
                  currentUser.getPictureUrl(),
                  fit: BoxFit.cover,
                ),
              ),
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
              title: Text('Help'),
              onTap: null,
            ),
            ListTile(
              title: Text('Sign out'),
              onTap: signOut,
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/poor.png'),
                          radius: 60,
                        ),
                        Text("You have no trips today",
                            style: TextStyle(fontSize: 25))
                      ]))
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
            shadowColor: Color(0xFF21BFBD),
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

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(ConsVar.userKey);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(StartPage.id, (route) => false);
  }
}
