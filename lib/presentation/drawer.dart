import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clashofclans/data/bloc/navigation_cubit.dart';
import 'package:clashofclans/data/bloc/player_cubit.dart';
// import 'package:clashofclans/data/bloc/player_cubit_json/player_cubit_state.dart';
import 'package:clashofclans/data/bloc/switch_player_cubit.dart';
import 'package:clashofclans/data/bloc/swith_theme_cubit.dart';
import 'package:clashofclans/internal/constants.dart';
import 'package:clashofclans/domain/models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  int pageController;

  MyDrawer({required this.pageController});

  @override
  Widget build(BuildContext context) {
    playerCubitFunc = context.read<PlayerCubit>();
    themeCubit = context.watch<ThemeCubit>();
    var getPage = context.read<NavigationCubit>();
    switchPlayerCubit = context.read<SwitchPlayerCubit>();
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            BlocBuilder<SwitchPlayerCubit, PlayerIndex>(
                builder: (context, profIndex) {
              if (profIndex is PlayerIndexState) {
                return BlocBuilder<PlayerCubit, PlayerState>(
                    builder: (context, state) {
                  if (state is PlayerLoadingState) {
                    return FutureBuilder(
                      future: playerCubitFunc.fplayerInfoList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          dynamic sdata = snapshot.data;
                          PlayerModel data = sdata[profIndex.index];
                          return Column(
                            children: [
                              _playerDriwer(data, getPage, context),
                              _noPlayerDriwer(getPage, context),
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
                });
              }
              if (profIndex is NoPlayerIndexState) {
                return Column(
                  children: [
                    _noPlayerDriwer(getPage, context),
                  ],
                );
              }
              return Container();
            }),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text, style: themeData.textTheme.headline4),
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
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 10.0),
              child: IconButton(
                icon: Icon(Icons.wb_sunny_outlined),
                onPressed: () {
                  themeCubit.toggleTheme();
                },
              ),
            ),
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data.name, style: themeData.textTheme.headline1),
                    Text(data.tag, style: themeData.textTheme.headline3),
                  ],
                ),
              ),
              data.league != null
                  ? Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: deviceWidth * 0.1,
                            width: deviceWidth * 0.1,
                            child: CachedNetworkImage(
                              imageUrl: '${data.league.iconUrls.medium}',
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          Text(data.league.name,
                              style: themeData.textTheme.headline2),
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          )),
        ],
      ),
    );
  }

  Widget _playerDriwer(data, getPage, context) {
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
        // _createDrawerItem(
        //     icon: Icons.contacts_outlined,
        //     text: 'сlan',
        //     onTap: () {
        //       getPage.getClan();
        //       Navigator.pop(context);
        //     }),
        Divider(),
      ],
    );
  }

  Widget _noPlayerDriwer(getPage, context) {
    return Column(
      children: [
        _createDrawerItem(
            icon: Icons.map_outlined,
            text: 'maps',
            onTap: () {
              getPage.getMaps();
              Navigator.pop(context);
            }),
        // _createDrawerItem(
        //     icon: Icons.book_outlined,
        //     text: 'guide',
        //     onTap: () {
        //       getPage.getGuide();
        //       Navigator.pop(context);
        //     }),
        Divider(),
        _createDrawerItem(
            icon: Icons.account_circle_outlined,
            text: 'profiles',
            onTap: () {
              getPage.getProfiles();
              Navigator.pop(context);
            }),
        // _createDrawerItem(
        //     icon: Icons.settings_outlined,
        //     text: 'settings',
        //     onTap: () {
        //       getPage.getSettings();
        //       Navigator.pop(context);
        //     }),
        _createDrawerItem(
            icon: Icons.web_asset_outlined, text: 'disable ads', onTap: () {}),
        ListTile(
          title: Text('0.0.1'),
          onTap: () {},
        ),
      ],
    );
  }
}
