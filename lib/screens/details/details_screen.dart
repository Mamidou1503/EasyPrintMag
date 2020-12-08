import 'package:flutter/material.dart';
import 'package:furniture_app/constants.dart';
import 'components/body.dart';

class DetailsScreen extends StatefulWidget {
  final List<dynamic> product;
  final String nc, date;
  final bool etatCmd;
  const DetailsScreen({Key key, this.product, this.nc, this.date, this.etatCmd})
      : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState(this.nc, this.date);
}

class _DetailsScreenState extends State<DetailsScreen> {
  _DetailsScreenState(this.nc, this.date);
  String nc;
  String date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: buildAppBar(context),
      ),
      body: Body(
        nc: nc,
        date: date,
        product: widget.product,
        etatCmd: widget.etatCmd,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        'Détail'.toUpperCase(),
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
