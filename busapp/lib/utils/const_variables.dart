import 'package:busapp/Screens/TripScreen.dart';
import 'package:flutter/widgets.dart';



import '../Screens/Signup.dart';
import '../Screens/TripDetails.dart';
import '../Screens/TripList.dart';
import '../Screens/verify-code.dart';

class ConsVar {
  //static final String baseUrl =
      //"http://ec2-100-26-224-179.compute-1.amazonaws.com:9090/";

  static final String baseUrl =
      "http://ec2-100-26-224-179.compute-1.amazonaws.com:";

  static Map<String, WidgetBuilder> get mapRoutes => {
        
        SignUpPage.id: (_) => SignUpPage(),
        TripScreen.id: (_) => TripScreen(),
        TripList.id: (_) => TripList(),
        TripDetails.id: (_) => TripDetails(),
        VerifyCode.id: (_) => VerifyCode(),
      };
}