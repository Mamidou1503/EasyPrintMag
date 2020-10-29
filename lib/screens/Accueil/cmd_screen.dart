import 'package:flutter/material.dart';
import 'package:furniture_app/constants.dart';

import 'components/body.dart';

class CmdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}
