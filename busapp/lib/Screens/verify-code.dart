import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/slide.dart';
import '../services/SMS_service.dart' as sms;
import '../widgets/slide_dots.dart';
import '../widgets/slideitem.dart';
import 'Signup.dart';

class VerifyCode extends StatefulWidget {
  static final String id = 'verifycode';

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  String verificationCode;
  String phoneNumber;
  Timer timer;
  bool _isLoading = false;

  //for slider movement
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  // you have to STOP timer after moving to next screen else it will work every 5 second
  stopTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
      print('timer is disposed');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    stopTimer();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void verificationCodeSubmitted() {
    setState(() {
      this._isLoading = true;
    });

    sms.ackToken(this.phoneNumber, this.verificationCode).then((response) {
      if (response.statusCode == 200) {
        var bodyMap = JsonDecoder().convert(response.body);
        this.saveInDisk("token", bodyMap["token"]);
        Navigator.pushReplacementNamed(context, SignUpPage.id,
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
  //  String phoneNumber = ModalRoute.of(context).settings.arguments as String;
    this.phoneNumber = "01273252408";
    print(this.phoneNumber + " aaa  ");
    return Scaffold(
//      backgroundColor: Color(0xFF21BFBD),
      appBar: AppBar(
        title: Text("kidzona driver-app"),
      ),
      backgroundColor: Colors.white,
      body: this._isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
//          padding: const EdgeInsets.all(15),
//          shrinkWrap: true,
                children: <Widget>[
                  Flexible(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: Stack(
                        children: [
                          PageView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: _pageController,
                            onPageChanged: _onPageChanged,
                            itemCount: slideList.length,
                            itemBuilder: (ctx, i) => SlideItem(slideList[i]),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 50,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  for (int i = 0; i < slideList.length; i++)
                                    if (i == _currentPage)
                                      SlideDots(true)
                                    else
                                      SlideDots(false)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  buildTextField("Enter the verification code"),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildButtonContainer("NEXT", Colors.white, Color(0xFF21BFBD)),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildButtonContainer(String text, Color color1, Color color2) {
    return Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: ButtonTheme(
          minWidth: 55.0,
          //MediaQuery.of(context).size.width,
          height: 55.0,
          child: RaisedButton(
            onPressed: this.verificationCodeSubmitted,
            color: color1,
            highlightColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0)),
            child: Text(
              text,
              style: TextStyle(
                color: color2,
                fontSize: 30.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return TextField(
      onChanged: (val) => this.verificationCode = val,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 18.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        prefixIcon: Icon(Icons.phone),
      ),
    );
  }
}
