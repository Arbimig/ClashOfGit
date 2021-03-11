import 'dart:developer';

import 'package:clashofclans/bloc/navigation_cubit.dart';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit.dart';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit_state.dart';
import 'package:clashofclans/repositories/constants.dart';
import 'package:clashofclans/repositories/json/player_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  int pageController;

  MyDrawer({this.pageController});

  @override
  Widget build(BuildContext context) {
    playerCubitFunc = context.read<PlayerCubit>();
    
    var getPage = context.read<NavigationCubit>();
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            BlocBuilder<PlayerCubit, PlayerState>(builder: (context, state) {
              if (state is PlayerLoadingState) {
                return FutureBuilder(
                  future: playerCubitFunc.fplayerInfoList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      PlayerInfo data =
                          snapshot.data[state.index == null ? 0 : state.index];
                      return Column(
                        children: [
                          _createHeader(data),
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
                      log('drawer playerinfo hassError');
                      return Container();
                    }
                  },
                );
              }
              return Container();
            }),
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
                style: themeData.textTheme.headline4),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  // ignore: unused_element
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
                  style:themeData.textTheme.headline1),
              Text(data.tag,
                  style: themeData.textTheme.headline3),
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
                  style: themeData.textTheme.headline2),
            ],
          ),
        ],
      )),
    );
  }
}
