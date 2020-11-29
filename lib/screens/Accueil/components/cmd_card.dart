import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';

class CmdCard extends StatefulWidget {
  const CmdCard(
      {Key key,
      this.itemIndex,
      this.id,
      this.qte,
      this.idetd,
      this.press,
      this.date,
      this.color})
      : super(key: key);

  final int itemIndex;
  final String id, idetd, date;
  final int qte;
  final bool color;
  final Function press;

  @override
  _CmdCardState createState() => _CmdCardState();
}

class _CmdCardState extends State<CmdCard> {
  _CmdCardState();
  String nom = "";
  String prenom = "";
  String nume = "";
  void getinfos() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.idetd)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          nom = value.data()['Nom'];
          prenom = value.data()['prenom'];
          nume = value.data()['phone'];
        });
      } else {
        return;
      }
    });
  }

  @override
  initState() {
    super.initState();
    getinfos();
  }

  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    //getinfos();
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
                        "N° Commande:   " + widget.id.toString(),
                        style: GoogleFonts.montserrat(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Commandé le:   " + widget.date.toString(),
                        style: GoogleFonts.montserrat(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Nom:   " + nom.toString(),
                        style: GoogleFonts.montserrat(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Prénom:   " + prenom.toString(),
                        style: GoogleFonts.montserrat(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Num telephone:   " + nume.toString(),
                        style: GoogleFonts.montserrat(),
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
                        style: GoogleFonts.montserrat(color: Colors.white),
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
