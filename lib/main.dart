import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/screens/Accueil/components/body.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'accueill.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool statuss = prefs.getBool('status');

  String idd = prefs.getString('idd');
  await Firebase.initializeApp();
  runApp(statuss == null ? Infpg() : MyApp(idmag: idd));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final String idmag;
  const MyApp({Key key, this.idmag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EasyPrintMag',
      theme: ThemeData(
        // We set Poppins as our default font
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Body(idm: idmag),
    );
  }
}
