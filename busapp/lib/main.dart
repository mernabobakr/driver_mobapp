import 'package:busapp/Screens/TripScreen.dart';
import 'package:busapp/Screens/start_page.dart';
import 'package:busapp/Screens/verify-code.dart';
import 'package:busapp/di.dart';
import 'package:busapp/utils/const_variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocators();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  String initialRoute;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() {
    SharedPreferences preferences = getIt.get<SharedPreferences>();
    initialRoute = preferences.getString(ConsVar.userKey) == null
        ? VerifyCode.id
        : TripScreen.id;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: ConsVar.appPrimaryColor,
          textTheme: GoogleFonts.ubuntuTextTheme(),
          iconTheme: IconThemeData(color: ConsVar.appPrimaryColor),
          buttonColor: ConsVar.appPrimaryColor,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: ConsVar.appPrimaryColor),
          appBarTheme: AppBarTheme(
            color: ConsVar.appPrimaryColor,
          )),
      initialRoute: initialRoute,
      routes: ConsVar.mapRoutes,
    );
  }
}
