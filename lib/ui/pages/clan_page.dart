import 'package:clashofclans/ui/pages/apps_page.dart';
import 'package:flutter/material.dart';

class ClanPage extends StatelessWidget {
  const ClanPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(child: Text('clan'),),
    );
  }
}

class ClanPageAppBar extends StatelessWidget with PrefAppBar {


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      title: Text('ClanPageAppBar'));
  }
}