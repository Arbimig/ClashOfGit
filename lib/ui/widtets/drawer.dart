import 'package:clashofclans/bloc/navigation_cubit.dart';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit.dart';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit_state.dart';
import 'package:clashofclans/repositories/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  int pageController;

  MyDrawer({this.pageController});

  @override
  Widget build(BuildContext context) {
    var getPage = context.read<NavigationCubit>();
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            BlocBuilder<PlayerCubit, PlayerState>(
              builder: (context, state) {
                if (state is PlayerLoadedState) {
                  print('state is playerLoadedState');
                  return Column(
                    children: [
                      _createHeader(state.playersInfo[0]),
                      _createDrawerItem(
                          icon: Icons.analytics_outlined,
                          text: 'statistics',
                          onTap: () {
                            getPage.getStat();
                            Navigator.pop(context);
                          }),
                      _createDrawerItem(
                          icon: Icons.contacts_outlined,
                          text: 'сlan',
                          onTap: () {
                            getPage.getClan();
                            Navigator.pop(context);
                          }),
                      Divider(),
                    ],
                  );
                } else {
                  return Container(
                    height: deviceHeight * 0.01,
                  );
                }
              },
            ),
            _createDrawerItem(
                icon: Icons.map_outlined,
                text: 'maps',
                onTap: () {
                  getPage.getMaps();
                  Navigator.pop(context);
                }),
            _createDrawerItem(
                icon: Icons.book_outlined,
                text: 'guide',
                onTap: () {
                  getPage.getGuide();
                  Navigator.pop(context);
                }),
            Divider(),
            _createDrawerItem(
                icon: Icons.account_circle_outlined,
                text: 'profiles',
                onTap: () {
                  getPage.getProfiles();
                  Navigator.pop(context);
                }),
            _createDrawerItem(
                icon: Icons.settings_outlined,
                text: 'settings',
                onTap: () {
                  getPage.getSettings();
                  Navigator.pop(context);
                }),
            _createDrawerItem(
                icon: Icons.web_asset_outlined, text: 'disable ads'),
            ListTile(
              title: Text('0.0.1'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300)),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createHeader(data) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(data.name,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300)),
              Text(data.tag,
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w300)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: deviceWidth * 0.1,
                width: deviceWidth * 0.1,
                child: Image.network('${data.league.iconUrls.medium}'),
              ),
              Text(data.league.name,
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300)),
            ],
          ),
        ],
      )),
    );
  }
}
