import 'package:flutter/material.dart';
import 'dart:async';
import './widgets/slideitem.dart';
import './models/slide.dart';
import './widgets/slide_dots.dart';
import './Screens/Login.dart';
import './Screens/Signup.dart';
import './Screens/verify-code.dart';
import './Screens/TripScreen.dart';
import './Screens/TripList.dart';
import './Screens/TripDetails.dart';
import './models/general_helper.dart' as hlp;
import './services/SMS_service.dart' as sms;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      
      theme: ThemeData(primaryColor: Colors.black, fontFamily: "Ubuntu"),
      home: StartPage(),
      routes: {
        "login": (ctx) => Login(),
        "signup": (ctx) => Signup(),
        "trips": (ctx) => TripScreen(),
        "trip": (ctx) => TripList(),
        "Tripdetails": (ctx) => TripDetails(),
        "verifycode": (ctx) => VerifyCode(),
      },
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<StartPage> {
  String phoneNumber;
  bool _isLoading = false;
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
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
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

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void tokenFound(String token) {
    if (token != null && token.length != 0) {
      print(token);
      Navigator.pushReplacementNamed(context, 'signup', arguments: token);
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
        Navigator.pushNamed(context, 'verify', arguments: this.phoneNumber);
      } else {
        hlp.showSimpleErrorMessage(
            "Can't send SMS verification right now. Try again later", context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      
        backgroundColor: Color(0xFF21BFBD),
        
        resizeToAvoidBottomPadding: false,
        body:
        
            Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        itemCount: slideList.length,
                        itemBuilder: (ctx, i) => SlideItem(i),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 35),
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
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                buildTextField("Enter your Phone Number"),
                SizedBox(
                  height: 20.0,
                ),
                buildButtonContainer(
                    "NEXT", Colors.white, Color(0xFF21BFBD), 'login'),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildButtonContainer(
      String text, Color color1, Color color2, String fun) {
    return Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: ButtonTheme(
          minWidth: 55.0,
          //MediaQuery.of(context).size.width,
          height: 55.0,
          child: RaisedButton(
            // onPressed: this.phoneSubmitted,
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
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
        )));
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
