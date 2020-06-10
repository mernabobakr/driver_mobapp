import 'package:busapp/Screens/TripScreen.dart';
import 'package:flutter/widgets.dart';


import '../Screens/Login.dart';
import '../Screens/Signup.dart';
import '../Screens/TripDetails.dart';
import '../Screens/TripList.dart';
import '../Screens/verify-code.dart';

class ConsVar {
  static final String baseUrl =
      "http://ec2-54-198-140-29.compute-1.amazonaws.com:9090/";

  static Map<String, WidgetBuilder> get mapRoutes => {
        Login.id: (_) => Login(),
        SignUpPage.id: (_) => SignUpPage(),
        TripScreen.id: (_) => TripScreen(),
        TripList.id: (_) => TripList(),
        TripDetails.id: (_) => TripDetails(),
        VerifyCode.id: (_) => VerifyCode(),
      };
}
