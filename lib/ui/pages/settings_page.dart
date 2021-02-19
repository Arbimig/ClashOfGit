import 'package:clashofclans/ui/pages/apps_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('settings'),
      ),
    );
  }
}

class SettingsPageAppBar extends StatelessWidget with PrefAppBar {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      title: Text('SettingsPageAppBar'),
    );
  }
}
