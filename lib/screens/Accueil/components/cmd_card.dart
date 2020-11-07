import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class CmdCard extends StatefulWidget {
  const CmdCard(
      {Key key,
      this.itemIndex,
      this.id,
      this.qte,
      this.nom,
      this.prenom,
      this.press,
      this.date,
      this.color})
      : super(key: key);

  final int itemIndex;
  final String id;
  final int qte;
  final bool color;
  final String nom, prenom, date;
  final Function press;

  @override
  _CmdCardState createState() => _CmdCardState(this.nom);
}

class _CmdCardState extends State<CmdCard> {
  _CmdCardState(this.id);
  final String id;

  String nom;
  String prenom;
  String nume;
  void getinfos() {
    FirebaseFirestore.instance.collection("Users").doc(id).get().then((value) {
      //setState(() {
      prenom = value.data()['prenom'];
      nom = value.data()['Nom'];
      nume = value.data()['phone'];
      //   });
    });
  }

  @override
  initState() {
    getinfos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      // color: Colors.blueAccent,
      height: 120,
      child: InkWell(
        onTap: widget.press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: widget.color == true
                    ? Colors.greenAccent
                    : Colors.redAccent,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image

            // Product title and price
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 120,
                // our image take 200 width, thats why we set out total width - 200
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "N° Commande: " + widget.id.toString(),
                        style: TextStyle(fontFamily: 'teen'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Commandé le: " + widget.date.toString(),
                        style: TextStyle(fontFamily: 'teen'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Nom: " + nom.toString(),
                        style: TextStyle(fontFamily: 'teen'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Prénom: " + prenom.toString(),
                        style: TextStyle(fontFamily: 'teen'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Num telephone: " + nume.toString(),
                        style: TextStyle(fontFamily: 'teen'),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5, // 30 padding
                        vertical: kDefaultPadding / 4, // 5 top and bottom
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        "${widget.qte.toString()}" + " Cours",
                        style:
                            TextStyle(fontFamily: 'teen', color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
