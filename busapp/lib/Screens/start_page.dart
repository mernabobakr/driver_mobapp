import 'dart:async';

import 'package:busapp/models/general_helper.dart' as hlp;
import 'package:busapp/services/SMS_service.dart' as sms;
import 'package:flutter/material.dart';

import '../models/slide.dart';
import '../widgets/slide_dots.dart';
import '../widgets/slideitem.dart';
import 'Signup.dart';
import 'verify-code.dart';

class StartPage extends StatefulWidget {
  static final String id = 'startPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<StartPage> {
  String phoneNumber;
  bool _isLoading = false;
  Timer timer;

  //for slider movement
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

//when the app is initialized  and there is a saved token inside the phone sign up screen is entered
  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true; //assuming there is a token saved in device
    });
    hlp.getTokenFromDisk().then(this.tokenFound).catchError(this.phoneError);
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

    hlp.getTokenFromDisk().then(this.tokenFound).catchError(this.phoneError);
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

  void tokenFound(String token) {
    if (token != null && token?.length != 0) {
      print(token);
      Navigator.pushReplacementNamed(context, SignUpPage.id, arguments: token);
    }
    setState(() {
      this._isLoading = false;
    });
  }

  void phoneError(error) {
    setState(() {
      this._isLoading = false;
      print("5araa");
    });
  }

  bool isValidPhoneNumber(String phoneNumber) {
    if (phoneNumber == null) return false;
    if (phoneNumber.length != 11) return false;
    if (!phoneNumber.startsWith("01")) return false;
    return true;
  }

  void phoneSubmitted() {
    print(this.phoneNumber);
    if (!isValidPhoneNumber(this.phoneNumber)) {
      hlp.showSimpleErrorMessage("Invalid phone number", context);
      return;
    }
    setState(() {
      this._isLoading = true;
    });
    sms.verifyPhoneNumber(this.phoneNumber).then((response) {
      setState(() {
        this._isLoading = false;
      });
      if (response.statusCode == 200) {
        Navigator.pushNamed(context, VerifyCode.id, arguments: this.phoneNumber);
      } else {
        hlp.showSimpleErrorMessage(
            "Can't send SMS verification right now. Try again later", context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xFF21BFBD),
      backgroundColor: Colors.white,
      body: Container(
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
            buildTextField("Enter your Phone Number"),
            SizedBox(
              height: 20.0,
            ),
            buildButtonContainer(
                "NEXT", Colors.white, Color(0xFF21BFBD)),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonContainer(
      String text, Color color1, Color color2) {
    return Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: ButtonTheme(
          minWidth: 55.0,
          //MediaQuery.of(context).size.width,
          height: 55.0,
          child: RaisedButton(
             onPressed: this.phoneSubmitted,
           // onPressed: () => Navigator.pushReplacementNamed(context, SignUpPage.id),
            // borderSide:BorderSide(width: 4),
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
      onChanged: (val) => this.phoneNumber = val,
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
