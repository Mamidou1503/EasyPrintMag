import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/accueill.dart';
import 'package:furniture_app/screens/Accueil/components/body.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  final SharedPreferences prefs =await SharedPreferences.getInstance();
  bool statuss = prefs.getBool('status');
  runApp(statuss == null ? MaterialApp(home:InfoPage()) : MaterialApp(home: MyApp()));
}*/
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
  final CollectionReference magCollection = FirebaseFirestore.instance.collection("Magasin");

@override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kTextColor,
          title: Text('Authentification '),
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
                      style: TextStyle(
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
                      labelText: 'Nom',
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
                      labelText: 'Prenom',
                    ),

                  ),
                ),

                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                        textColor: Colors.white,
                        color: kTextColor,
                        child: Text('Confirmer'),
                        onPressed: () async {

                          final SharedPreferences prefs =await SharedPreferences.getInstance();
                          await magCollection
                          .where("Magasin",isEqualTo: nameController.text)
                          .where("pass",isEqualTo: passwordController.text).get().then((value) =>
                          {
                            value.docs.forEach((element) {
                              if(element.exists){
                              String idd=element.id.toString();
                              prefs.setBool('status',true);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>MyApp(idmag: idd,)),);
                              }

                            }),
                          if (value.docs.isEmpty)
                          dialogg("Nom ou mot de passe incorrecte.")
                          });
                        }
                        )
                ),
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
