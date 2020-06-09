import 'package:flutter/material.dart';
import './TripScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  bool _isHidden = true;
  String id = '1';
  String date = '2020-01-10';

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void getTripsIfIdFound() {
    Navigator.pushNamed(context, "trips", arguments: {
      "driverId": this.id,
      "date": this.date,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Driver app'),
      ),
      resizeToAvoidBottomPadding: false,
      body:  DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/photo.jpg'),
                fit: BoxFit.cover),
      ),
     child: Container(
        padding:
            EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Please sign in!',
              style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Pacifico"),
            ),
            SizedBox(
              height: 20.0,
            ),
            /*
            Text(
              "LOGIN",
              style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),*/
            SizedBox(
              height: 40.0,
            ),
            buildTextField("Email"),
            SizedBox(
              height: 20.0,
            ),
            buildTextField("Password"),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Forgotten Password?",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.0),
            buildButtonContainer("Sign ", 'trips'),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("SIGN UP",
                        style: TextStyle(
                          color: Colors.black,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildTextField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: hintText == "Email" ? Icon(Icons.email) : Icon(Icons.lock),
        suffixIcon: hintText == "Password"
            ? IconButton(
                onPressed: _toggleVisibility,
                icon: _isHidden
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              )
            : null,
      ),
      obscureText: hintText == "Password" ? _isHidden : false,
    );
  }

  Widget buildButtonContainer(String text, String fun) {
    return Container(
        height: 80.0,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        child: Center(
            child: ButtonTheme(
          minWidth: MediaQuery.of(context).size.width,
          height: 80.0,

          child: RaisedButton(
            color: Colors.black,
            onPressed: () => Navigator.pushNamed(context, fun, arguments: {
              "driverId": this.id,
              "date": this.date,
            }),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        )));
  }
}
