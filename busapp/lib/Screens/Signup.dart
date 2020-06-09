import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static final String id = 'signup';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignUpPage> {
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Driver app'),
        ),
        //resizeToAvoidBottomPadding: false,
        body: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/photo.jpg'),
                fit: BoxFit.cover),
          ),
          child: Container(
            padding: EdgeInsets.only(
                top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Let\'s start with creating your account!',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Pacifico"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                buildTextField("First Name"),
                SizedBox(
                  height: 20.0,
                ),
                buildTextField("Last Name"),
                SizedBox(
                  height: 20.0,
                ),
                buildTextField("Email"),
                SizedBox(
                  height: 20.0,
                ),
                buildTextField("Phonenumber"),
                SizedBox(
                  height: 20.0,
                ),
                buildTextField("Password"),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[],
                  ),
                ),
                SizedBox(height: 20.0),
                buildButtonContainer("Sign up "),
                SizedBox(
                  height: 10.0,
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
      ),
      obscureText: hintText == "Password" ? _isHidden : false,
    );
  }

  Widget buildButtonContainer(String text) {
    return Container(
        height: 80.0,
        width: 160,
        color: Theme.of(context).primaryColor,
        child: Center(
            child: ButtonTheme(
          minWidth: 160,
          height: 80.0,
          child: RaisedButton(
            color: Colors.black,
            onPressed: null,
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
