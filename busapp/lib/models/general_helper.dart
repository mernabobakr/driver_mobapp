import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showSimpleErrorMessage(String msg, context) {
  showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text(msg),
        actions: <Widget>[
          RaisedButton(
            color: Color(0xFF21BFBD),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: Navigator.of(context).pop,
          ),
        ],
      ));
}

Future<String> getTokenFromDisk() async {
  final prefs = await SharedPreferences.getInstance();
  String result = prefs.getString("token");
  return result;
}
