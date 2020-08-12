import 'package:busapp/utils/const_variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/start_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF21BFBD),
          textTheme: GoogleFonts.ubuntuTextTheme(),
          appBarTheme: AppBarTheme(color: Colors.black)),
      home: StartPage(),
      routes: ConsVar.mapRoutes,
    );
  }
}
