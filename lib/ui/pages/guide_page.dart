import 'package:clashofclans/ui/pages/apps_page.dart';
import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(child: Text('guide'),),
    );
  }
}

class GuidePageAppBar extends StatelessWidget with PrefAppBar {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      title: Text('GuidePageAppBar'));
  }
}