import 'package:flutter/material.dart';
import 'package:furniture_app/constants.dart';
import 'components/body.dart';
class DetailsScreen extends StatefulWidget {
  final List<dynamic> product;
  final String nc, date;
  const DetailsScreen({Key key, this.product, this.nc, this.date})
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
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: Icon(
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
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
