import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_app/screens/Accueil/components/cmd_card.dart';
import 'package:furniture_app/screens/details/details_screen.dart';

import '../constants.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
    this.val,
    this.onChanged,
  }) : super(key: key);
  final String val;
  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {

    return Container(
        margin: EdgeInsets.all(kDefaultPadding),
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 4, // 5 top and bottom
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                autofocus: false,
                keyboardType: TextInputType.text,
                onChanged: onChanged,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  icon: SvgPicture.asset("assets/icons/search.svg"),
                  hintText: 'N° Commande',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            IconButton(
                color: Colors.white,
                icon: Icon(
                  Icons.search,
                  color: kPrimaryColor,
                ),
              onPressed: (){},
                )
               ],
        )

        /*TextField(
        autofocus: false,
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: SvgPicture.asset("assets/icons/search.svg"),
          hintText: 'N° Commande',
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),*/
        );
  }
}
