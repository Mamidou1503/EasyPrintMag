import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/screens/details/components/coursCmdCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class Body extends StatefulWidget {
  final List<dynamic> product;
  final List<dynamic> cours;
  final String nc, date;
  const Body({Key key, this.product, this.cours, this.nc, this.date})
      : super(key: key);
  State<StatefulWidget> createState() => _Boddyy(this.product);
}

class _Boddyy extends State<Body> {
  _Boddyy(this.product);
  List<dynamic> product;
  var qte = [];
  var tot = 0;
  int i = 0;
  void setlist() {
    var strings = product.cast<String>().toList();
    while (i < strings.length) {
      setState(() {
        qte.add(strings[i].split(',')[1]);
      });

      i++;
    }
  }

  //List<dynamic> cr;
  var firestore = FirebaseFirestore.instance;

  void settot() {
    int j = 0;
    while (j < qte.length) {
      print(j);
      setState(() {
        tot = tot + int.parse(qte[j]) * 5;
      });

      j++;
    }
  }

  @override
  void initState() {
    super.initState();
    setlist();
    settot();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                left: kDefaultPadding,
                top: kDefaultPadding / 6,
                bottom: kDefaultPadding / 6),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding / 3),
                  child: Text(
                    "N° Commande: " + widget.nc,
                    style: GoogleFonts.montserrat(fontSize: 14),

                    //style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding / 3,
                  ),
                  child: Text(
                    "Commandé le: " + widget.date,
                    style: GoogleFonts.montserrat(fontSize: 14),

                    //style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding / 3,
                  ),
                  child: Text(
                    "Prix total: " + tot.toString() + " D.A",
                    style: TextStyle(
                      fontFamily: 'teen',
                      color: kPrimaryColor,
                      fontSize: 14,
                    ),

                    //style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                //SizedBox(height: kDefaultPadding/2),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Stack(
            children: [
              Container(
                height: size.height * 0.63,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                //margin: EdgeInsets.symmetric(vertical: kDefaultPadding/3),
                child: ListView.builder(
                    // here we use our demo procuts list
                    itemCount: widget.product.length,
                    itemBuilder: (context, index) {
                      return CoursCmdCard(
                        itemIndex: index,
                        cours: widget.product[index].toString().split(',')[0],
                        enseignant:
                            widget.product[index].toString().split(',')[5],
                        module: widget.product[index].toString().split(',')[3],
                        annee: widget.product[index].toString().split(',')[4],
                        prix: (int.parse((widget.product[index]
                                    .toString()
                                    .split(',')[1])) *
                                5)
                            .toString(),
                        copie: widget.product[index].toString().split(',')[1],
                      );
                    }),
              ),
            ],
          ),
          //ProgressButtonHomePage(title: "Valider",),
          Container(
            height: size.height * 0.12,
            child: ProgressButtonHomePage(
              title: "Valider",
              ncc: widget.nc,
              dt: widget.date,
              boddyy: this,
            ),
          )
        ],
      ),
    );
  }
}

class ProgressButtonHomePage extends StatefulWidget {
  ProgressButtonHomePage({
    Key key,
    this.title,
    this.ncc,
    this.dt,
    this.boddyy,
  }) : super(key: key);

  final String title;
  final String ncc;
  final String dt;
  final _Boddyy boddyy;
  @override
  _ProgressButtonHomePageState createState() => _ProgressButtonHomePageState();
}

class _ProgressButtonHomePageState extends State<ProgressButtonHomePage> {
  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

  Widget buildCustomButton() {
    var progressTextButton = ProgressButton(
      stateWidgets: {
        ButtonState.idle: Text(
          "Idle",
          style: TextStyle(color: Colors.white),
        ),
        ButtonState.loading: Text(
          "Loading",
          style: TextStyle(color: kSecondaryColor),
        ),
        ButtonState.fail: Text(
          "Fail",
          style: TextStyle(color: Colors.white),
        ),
        ButtonState.success: Text(
          "Success",
          style: TextStyle(color: Colors.white),
        )
      },
      stateColors: {
        ButtonState.idle: Colors.grey.shade400,
        ButtonState.loading: Colors.blue.shade300,
        ButtonState.fail: Colors.red.shade300,
        ButtonState.success: Colors.green.shade400,
      },
      onPressed: onPressedCustomButton,
      state: stateOnlyText,
      padding: EdgeInsets.all(8.0),
    );
    return progressTextButton;
  }

  Widget buildTextWithIcon() {
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: "Valider",
          icon: Icon(Icons.check, color: Colors.white),
          color: kBlueColor),
      ButtonState.loading: IconedButton(
          text: "Valisation en cours", color: Colors.deepPurple.shade700),
      ButtonState.fail: IconedButton(
          text: "Echec",
          icon: Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300),
      ButtonState.success: IconedButton(
          text: "Validé",
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green.shade400)
    }, onPressed: onPressedIconWithText, state: stateTextWithIcon);
  }

  Future validerpanier(String numc) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('Commande')
        .where("NumC", isEqualTo: numc)
        .where("Date", isEqualTo: widget.dt)
        .get();

    bool validation = true;
    result.docs.forEach((element) {
      element.reference
          .update({
            'EtatCommande': true,
          })
          .then((value) {})
          .catchError((e) {
            print(e);
            validation = false;
          });
    });
    Future.delayed(Duration(seconds: 2), () {
      if (validation) {
        Navigator.pop(
          context,
        );
      }
    });

    // widget.boddyy.setState(() {
    //   widget.boddyy.product = [];
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildTextWithIcon(),
        ],
      ),
    );
  }

  void onPressedCustomButton() {
    setState(() {
      switch (stateOnlyText) {
        case ButtonState.idle:
          stateOnlyText = ButtonState.loading;
          break;
        case ButtonState.loading:
          stateOnlyText = ButtonState.fail;
          break;
        case ButtonState.success:
          stateOnlyText = ButtonState.idle;
          break;
        case ButtonState.fail:
          stateOnlyText = ButtonState.success;
          break;
      }
    });
  }

  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        validerpanier(widget.ncc);
        stateTextWithIcon = ButtonState.loading;
        Future.delayed(Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              stateTextWithIcon = ButtonState.success;
            });
          }
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
  }
}
