import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Infpg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InfoPage(),
    );
  }
}

class InfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<InfoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final CollectionReference magCollection =
      FirebaseFirestore.instance.collection("Magasin");

  @override
  void dispose() {
    // TODO: implement dispose

    nameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kTextColor,
          title: Text('Authentification ', style: GoogleFonts.pacifico()),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'EasyPrint',
                      style: GoogleFonts.pacifico(
                          color: kTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Imprimerie :',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: false,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mot de passe :',
                    ),
                  ),
                ),
                Container(
                    height: 60,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                        textColor: Colors.white,
                        color: kTextColor,
                        child: Text('Se-Connecter.'),
                        onPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await magCollection
                              .where("Magasin", isEqualTo: nameController.text)
                              .where("pass", isEqualTo: passwordController.text)
                              .get()
                              .then((value) => {
                                    value.docs.forEach((element) {
                                      if (element.exists) {
                                        String idd = element.id.toString();
                                        prefs.setBool('status', true);
                                        prefs.setString('idd', idd);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyApp(
                                                    idmag: idd,
                                                  )),
                                        );
                                      }
                                    }),
                                    if (value.docs.isEmpty)
                                      dialogg("Nom ou mot de passe incorrecte.")
                                  });
                        })),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
                    child: Text(
                      'EasyPrint..',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ))
              ],
            )));
  }

  void dialogg(String message) async {
    await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: new Text('Information incomplète.'),
        content: Text(message),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
  }
}
