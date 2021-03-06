import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';

class CoursCmdCard extends StatelessWidget {
  const CoursCmdCard(
      {Key key,
      this.id,
      this.itemIndex,
      this.press,
      this.annee,
      this.module,
      this.cours,
      this.enseignant,
      this.copie,
      this.prix})
      : super(key: key);
  final String id;
  final int itemIndex;
  final String annee, copie;
  final String module;
  final String cours;
  final String enseignant;
  final String prix;
  final Function press;

  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      // color: Colors.blueAccent,
      //height: 120,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: kBlueColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 190,
                // our image take 200 width, thats why we set out total width - 200
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: kDefaultPadding / 1.6,
                          right: kDefaultPadding * 2.5),
                      child: Text(
                        "Module : " + module + " " + annee,
                        style: GoogleFonts.montserrat(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: kDefaultPadding / 1.6,
                          right: kDefaultPadding * 2.5),
                      child: Text(
                        "Cours : " + cours,
                        style: GoogleFonts.montserrat(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: kDefaultPadding / 1.6,
                          right: kDefaultPadding * 2.5),
                      child: Text(
                        "Enseignant : " + enseignant,
                        style: GoogleFonts.montserrat(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: kDefaultPadding / 1.6,
                          right: kDefaultPadding * 2.5),
                      child: Text(
                        "Nombre de copie : " + copie,
                        style: GoogleFonts.montserrat(),
                      ),
                    ),
                    // it use the available space
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5, // 30 padding
                        vertical: kDefaultPadding / 4, // 5 top and bottom
                      ),
                      decoration: const BoxDecoration(
                        color: kBlueColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        " D.A.",
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
