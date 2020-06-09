import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/SMS_service.dart' as sms;

import 'package:shared_preferences/shared_preferences.dart';

class VerifyCode extends StatefulWidget {
  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  String verificationCode;
  String phoneNumber;
  bool _isLoading = false;
  void verificationCodeSubmitted() {
    setState(() {
      this._isLoading = true;
    });

    sms.ackToken(this.phoneNumber, this.verificationCode).then((response) {
      if (response.statusCode == 200) {
        var bodyMap = JsonDecoder().convert(response.body);
        this.saveInDisk("token", bodyMap["token"]);
        Navigator.pushReplacementNamed(context, "sign-up",
            arguments: bodyMap["token"] as String);
      } else {
        showSimpleErrorMessage("Wrong verification code");
      }
      setState(() {
        this._isLoading = false;
      });
    }).catchError((err) {
      setState(() {
        this._isLoading = false;
      });
      showSimpleErrorMessage("Something wrong happened! Try again.");
    });
  }

  void saveInDisk(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  void showSimpleErrorMessage(String message) {
    showDialog(
        context: context,
        child: new AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            RaisedButton(
              color: Colors.orange,
              child: Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: Navigator.of(context).pop,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    String phoneNumber = ModalRoute.of(context).settings.arguments as String;
    this.phoneNumber = phoneNumber;
  }
}
