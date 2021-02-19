import 'package:clashofclans/ui/pages/apps_page.dart';
import 'package:flutter/material.dart';
class MapsPage extends StatelessWidget {
  const MapsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'MapsPage',
      style: TextStyle(fontWeight: FontWeight.w300),
    ));
  }
}

class MapsPageAppBar extends StatelessWidget with PrefAppBar {
  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: appBarColor, title: Text('MapsPageAppBar'));
  }
}
