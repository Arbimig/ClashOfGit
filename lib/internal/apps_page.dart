import 'package:clashofclans/data/bloc/switch_th_lvl_cubit.dart';
import 'package:clashofclans/data/bloc/navigation_cubit.dart';
import 'package:clashofclans/presentation/pages/statistics_page.dart';
import 'package:clashofclans/presentation/drawer.dart';
import 'package:clashofclans/internal/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/pages/clan_page.dart';
import '../presentation/pages/guide_page.dart';
import '../presentation/pages/maps_page.dart';
import '../presentation/pages/profiles_page.dart';
import '../presentation/pages/settings_page.dart';

class AppsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    mediaQueryData = MediaQuery.of(context);
    return BlocBuilder<ThLevlel, String>(
      builder: (context, thlvlstate) {
        return BlocBuilder<NavigationCubit, int>(
          builder: (context, index) {
            return Scaffold(
              //TODO: swith player cubit
              drawer: MyDrawer(pageController: 0,),
              appBar: _buildAppBar(index, thlvlstate),
              body: _buildBody(index, thlvlstate),
            );
          },
        );
      },
    );
  }

  PrefAppBar? _buildAppBar(int index, String thlvlstate) {
    final _buildAppBarMap = {
      0: StatisticsAppBar(),
      1: ClanPageAppBar(),
      2: MapsPageAppBar(thlvlstate),
      3: GuidePageAppBar(),
      4: ProfilesPageAppBar(),
      5: SettingsPageAppBar(),
    };
    return _buildAppBarMap[index];
  }

  Widget? _buildBody(int index, String thlvlstate) {
    final _buildBodyMap = {
      0: StatisticsPage(),
      1: ClanPage(),
      2: MapsPage(thlvlstate),
      3: GuidePage(),
      4: ProfilesPage(),
      5: SettingsPage(),
    };
    return _buildBodyMap[index];
  }
}

abstract class PrefAppBar implements PreferredSizeWidget {
  final Color appBarColor = themeData.accentColor;
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
