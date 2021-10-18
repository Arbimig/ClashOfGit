import 'package:flutter/material.dart';

import '../../internal/apps_page.dart';

class SettingsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(); 
    // Scaffold(
    //   body: Center(
    //     child: Text('settings'),
    //   ),
    // );
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
