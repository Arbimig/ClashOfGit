import 'package:flutter/material.dart';

import '../../internal/apps_page.dart';

class GuidePage extends StatelessWidget {

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