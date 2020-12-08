import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/screens/details/details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cmd_card.dart';

class Body extends StatefulWidget {
  final String idm;

  const Body({Key key, this.idm}) : super(key: key);
  @override
  _Boddy createState() => _Boddy();
}

class _Boddy extends State<Body> {
  String v;
  List categories = ["Toute", "En attente", "Traitées"];
  final CollectionReference commCollection =
      FirebaseFirestore.instance.collection("Commande");
  final DateTime now = DateTime.now();

  void deleteComm() {
    // String dt = now.year.toString() +
    //     "-" +
    //     now.month.toString() +
    //     "-" +
    //     (now.day - 7).toString();
    //print(dt.toString());
    DateTime weekAgo = now.subtract(Duration(days: 7));

    print("weekAgo: $weekAgo");
    String dt = weekAgo.year.toString() +
        "-" +
        weekAgo.month.toString() +
        "-" +
        ((weekAgo.day < 10)
            ? "0" + weekAgo.day.toString()
            : weekAgo.day.toString());
//one day timestamp = 86400
    print("dt: $dt");

    commCollection
        .where('Date', isLessThan: dt)
        .where('Idmagasins', isEqualTo: widget.idm)
        .snapshots()
        .forEach((element) {
      for (DocumentSnapshot dc in element.docs) {
        dc.reference.delete();
      }
    });
  }

  FutureOr onGoBack(dynamic value) {
    if (mounted) {
      setState(() {
        list1.clear();
        setentete();
        revenu();
      });
    }
  }

  Stream<QuerySnapshot> getCommSync(int i) {
    Stream<QuerySnapshot> qr;
    //setentete();

    if (i == 0)
      qr = firestore
          .where("Idmagasins", isEqualTo: widget.idm)
          .where("EtatPanier", isEqualTo: true)
          .orderBy('Date', descending: false)
          .snapshots();
    else if (i == 1)
      qr = firestore
          .where("Idmagasins", isEqualTo: widget.idm)
          .where("EtatCommande", isEqualTo: false)
          .where("EtatPanier", isEqualTo: true)
          .orderBy('Date')
          .snapshots();
    else if (i == 2)
      qr = firestore
          .where("Idmagasins", isEqualTo: widget.idm)
          .where("EtatCommande", isEqualTo: true)
          .orderBy('Date', descending: false)
          .snapshots();
    return qr;
  }

  void setentete() async {
    firestore
        .where("Idmagasins", isEqualTo: widget.idm)
        .where("EtatPanier", isEqualTo: true)
        .snapshots()
        .forEach((querySnapshot) {
      int t = 0, f = 0;
      print("calling setEntete ");

      querySnapshot.docs.forEach((doc) {
        // Do something with change
        var etatCmd = doc.data()["EtatCommande"];

        if (etatCmd == false)
          f++;
        else
          t++;
      });

      if (mounted) {
        setState(() {
          categories[0] = "Toutes(" + (f + t).toString() + ")";
          categories[1] = "En attente(" + f.toString() + ")";
          categories[2] = "Traitées(" + t.toString() + ")";
        });
      }
    });
  }

  void revenu() async {
    list1 = [];
    cmdTrait = 0;

    final CollectionReference magasin =
        FirebaseFirestore.instance.collection('Magasin');

    print(widget.idm);
    magasin.doc(widget.idm).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        cmdTrait = documentSnapshot['EasyPrix'];
        print(
            'Document exists on the database ${documentSnapshot['EasyPrix']}');
      }
    }).catchError((error) {
      print("Failed to get EasyPrix: $error");
    });

    // firestore
    //     .where("Idmagasins", isEqualTo: widget.idm)
    //     .where("EtatCommande", isEqualTo: true)
    //     .snapshots()
    //     .listen((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((element) {
    //     list1 = element.data()['Idcours'];
    //     for (int i = 0; i < list1.length; i++) {
    //       cmdTrait = cmdTrait + int.parse(list1[i].toString().split(",")[1]);
    //     }
    //   });
    // });
  }

  @override
  initState() {
    super.initState();

    list1.clear();
    setentete();
    //revenu();
    deleteComm();
  }

  List<dynamic> list1 = [];
  int cmdTrait;
  String txtSearch = "";
  int selectedIndex = 0;
  var firestore = FirebaseFirestore.instance.collection("Commande");

  @override
  void didUpdateWidget(covariant Body oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    setentete();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 3));
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Bienvenue',
          style: GoogleFonts.pacifico(fontSize: 26, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset("assets/images/money.png"),
            onPressed: () async {
              revenu();
              await new Future.delayed(const Duration(seconds: 1));
              showDialog(
                  context: context,
                  builder: (BuildContext context) => FancyDialog(
                        okColor: kBlueColor,
                        animationType: FancyAnimation.TOP_BOTTOM,
                        gifPath: "assets/images/icons8-comptabilité-80.png",
                        title: "Revenu hébdomadaire",
                        descreption: "Easy Solution: " +
                            (this.cmdTrait).toString() +
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
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding / 3),
                height: 30,
                child: ListView.builder(
                  //physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        print(index);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        left: kDefaultPadding / 4,
                        // At end item it add extra 20 right  padding
                        right: index == categories.length - 1
                            ? kDefaultPadding / 4
                            : 0,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      decoration: BoxDecoration(
                        color: index == selectedIndex
                            ? Colors.white.withOpacity(0.4)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        categories[index],
                        style: const TextStyle(color: Colors.white),
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
                      margin: const EdgeInsets.only(top: 60),
                      decoration: const BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: getCommSync(selectedIndex),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: const CircularProgressIndicator(
                              valueColor:
                                  const AlwaysStoppedAnimation(Colors.red),
                              strokeWidth: 3.0,
                            ),
                          );
                        } else {
                          return ListView.builder(
                            // here we use our demo procuts list
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (_, index) => CmdCard(
                              itemIndex: index,
                              id: snapshot.data.docs[index]
                                  .data()["NumC"]
                                  .toString(),
                              idetd: snapshot.data.docs[index]
                                  .data()["IdEtudiant"],
                              date: snapshot.data.docs[index].data()["Date"],
                              qte: snapshot.data.docs[index]
                                  .data()["Idcours"]
                                  .length,
                              color: snapshot.data.docs[index]
                                  .data()["EtatCommande"],
                              press: () {
                                // if (snapshot.data.docs[index]
                                //         .data()["EtatCommande"] ==
                                //     false) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      nc: snapshot.data.docs[index]
                                          .data()["NumC"]
                                          .toString(),
                                      date: snapshot.data.docs[index]
                                          .data()["Date"],
                                      product: snapshot.data.docs[index]
                                          .data()["Idcours"],
                                      etatCmd: snapshot.data.docs[index]
                                          .data()["EtatCommande"],
                                    ),
                                  ),
                                ); //.then(onGoBack);
                                // }
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
