import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/components/search_box.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/screens/details/details_screen.dart';
import 'cmd_card.dart';

class Body extends StatefulWidget {
  @override
  _Boddy createState() => _Boddy();
}
class _Boddy extends State<Body> {
  String v;
  List categories = ["Toute", "En attente", "Traitées"];
  Future getComm(int i ) async {
    QuerySnapshot qr;
    if (i == 0)
      qr = await firestore.collection("Commande")
          .where("Idmagasins",isEqualTo: "micG8nx1YZOtXnN1MZK6")
          .where("EtatPanier", isEqualTo: true)
          //.orderBy('Date')
          .get();
    else if (i == 1)
      qr = await firestore
          .collection("Commande")
          .where("Idmagasins",isEqualTo: "micG8nx1YZOtXnN1MZK6")
          .where("EtatCommande", isEqualTo: false)
          .where("EtatPanier", isEqualTo: true)
          //.orderBy('EtatCommande').orderBy('Date')
          .get();
    else if (i == 2)
      qr = await firestore
          .collection("Commande")
          .where("Idmagasins",isEqualTo: "micG8nx1YZOtXnN1MZK6")
          .where("EtatCommande", isEqualTo: true)
          //.orderBy('EtatCommande').orderBy('Date')
          .get();
    return qr.docs;

  }
  Future getCommm(int i) async {
    QuerySnapshot qr;
    if (i == 0)
      qr = await firestore.collection("Commande")
          .where("Idmagasins",isEqualTo: "micG8nx1YZOtXnN1MZK6")
          .where("EtatPanier", isEqualTo: true)
          //.orderBy('Date')
          .get();
    else if (i == 1)
      qr = await firestore
          .collection("Commande")
          .where("Idmagasins",isEqualTo: "micG8nx1YZOtXnN1MZK6")
          .where("EtatCommande", isEqualTo: false)
          .where("EtatPanier", isEqualTo: true)
          //.orderBy('Date')
          .get();
    else if (i == 2)
      qr = await firestore
          .collection("Commande")
          .where("Idmagasins",isEqualTo: "micG8nx1YZOtXnN1MZK6")
          .where("EtatCommande", isEqualTo: true)
          //.orderBy('Date')
          .get();
    return qr.docs;
  }
  void setentete() {
    getComm(0).then((value) {
      setState(() {
        categories[0] = "Toutes (" + value.length.toString() + ")";
      });
    });
    getComm(1).then((value) {
      setState(() {
        categories[1] = "En attente (" + value.length.toString() + ")";
      });
    });
    getComm(2).then((value) {
      setState(() {
        categories[2] = "Traitées (" + value.length.toString() + ")";
      });
    });
  }
  @override
  initState() {
    setentete();
    super.initState();
  }
  List <dynamic> srch=[];
  String txtSearch="";
  int selectedIndex = 0;
  var firestore = FirebaseFirestore.instance;
  int revenumagasin = 0;
  int revenueasy = 0;
  List<dynamic> pro1 = [];
  List<dynamic> qtte = [];
  /*Future getcommterminee() async {
    List<dynamic> pro = [];
    List<dynamic> list = [];
    FirebaseFirestore.instance
        .collection("Commande")
        .where("EtatCommande", isEqualTo: false)
        .where("EtatPanier",isEqualTo: true)
        .where("Idmagasins",isEqualTo: "micG8nx1YZOtXnN1MZK6")
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      pro1.clear();
      querySnapshot.documents.forEach((document) {
        list = document.data()['Idcours'];
        int i = 0;
        while (i < list.length) {
          pro1.add(list[i].toString().split(',')[0]);
          qtte.add(list[i].toString().split(',')[1]);

          i++;
        }
      });
    });
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Bienvenue',
          style: TextStyle(fontFamily: 'teen', fontSize: 28),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset("assets/images/money.png"),
            onPressed: () async {
              //getlistofcourses();
              await new Future.delayed(const Duration(seconds: 2));
              showDialog(
                  context: context,
                  builder: (BuildContext context) => FancyDialog(
                        okColor: kBlueColor,
                        animationType: FancyAnimation.TOP_BOTTOM,
                        gifPath: "assets/images/icons8-comptabilité-80.png",
                        title: "Revenu hébdomadaire",
                        descreption: "Easy Solution: " +
                            this.revenueasy.toString() +
                            " D.A.",
                      ));
            },
          ),
        ],
      ),
      body: SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              SearchBox(
                  val: v,
                  onChanged:(val) {
                    srch.clear();
                    setState(() {
                      getCommm(0).then((value) {
                        categories[0] ="Toutes (" + value.length.toString() + ")";
                        txtSearch=val;
                      });
                    });
                  },
                  ),
              Container(
                margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 3),
                height: 25,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        print(index);
                        getComm(index);
                        getComm(0).then((value) {
                          categories[0] =
                              "Toutes (" + value.length.toString() + ")";
                        });
                        getComm(1).then((value) {
                          categories[1] =
                              "En attente (" + value.length.toString() + ")";
                        });
                        getComm(2).then((value) {
                          categories[2] =
                              "Traitées (" + value.length.toString() + ")";
                        });
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        left: kDefaultPadding / 4,
                        // At end item it add extra 20 right  padding
                        right: index == categories.length - 1
                            ? kDefaultPadding
                            : 0,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      decoration: BoxDecoration(
                        color: index == selectedIndex
                            ? Colors.white.withOpacity(0.4)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    // Our background
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    StreamBuilder(
                      stream: getComm(selectedIndex).asStream(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.red),
                            strokeWidth: 3.0,
                          );
                        } else {
                          return ListView.builder(
                            // here we use our demo procuts list
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) => CmdCard(
                              itemIndex: index,
                              id: snapshot.data[index].data()["NumC"].toString(),
                              nom: snapshot.data[index].data()["IdEtudiant"],
                              date: snapshot.data[index].data()["Date"],
                              qte: snapshot.data[index].data()["Idcours"].length,
                              color: snapshot.data[index].data()["EtatCommande"],
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      nc: snapshot.data[index].data()["NumC"]
                                          .toString(),
                                      date: snapshot.data[index].data()["Date"],
                                      product:
                                          snapshot.data[index].data()["Idcours"],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

/*AppBar buildAppBar(BuildContext context, int a, int b) {
  return AppBar(
    elevation: 0,
    centerTitle: false,
    title: Text(
      'Bienvenue',
      style: TextStyle(fontFamily: 'teen', fontSize: 28),
    ),
    actions: <Widget>[

      IconButton(
        icon: Image.asset("assets/images/money.png"),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => FancyDialog(
                    okColor: kBlueColor,
                    animationType: FancyAnimation.TOP_BOTTOM,
                    gifPath: "assets/images/icons8-comptabilité-80.png",
                    title: "Revenu hébdomadaire",
                    descreption: "Imprimerie: " +
                        a.toString() +
                        " D.A.\n" +
                        "Easy Solution: " +
                        b.toString() +
                        " D.A.",
                  ));
        },
      ),
    ],
  );
}*/
