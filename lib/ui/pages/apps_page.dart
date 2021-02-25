import 'package:clashofclans/bloc/navigation_cubit.dart';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit.dart';
import 'package:clashofclans/bloc/swith_theme_cubit.dart';
import 'package:clashofclans/repositories/constants.dart';
import 'package:clashofclans/ui/pages/clan_page.dart';
import 'package:clashofclans/ui/pages/guide_page.dart';
import 'package:clashofclans/ui/pages/maps_page.dart';
import 'package:clashofclans/ui/pages/profiles_page.dart';
import 'package:clashofclans/ui/pages/settings_page.dart';
import 'package:clashofclans/ui/pages/statistics_page.dart';
import 'package:clashofclans/ui/widtets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppsPage extends StatelessWidget {
  const AppsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    themeCubit = context.watch<ThemeCubit>();
    playerCubitFunc = context.read<PlayerCubit>();
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        return Scaffold(
          drawer: MyDrawer(),
          appBar: _buildAppBar(state),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildAppBar(int index) {
    final _buildAppBarMap = {
      0: StatisticsAppBar(),
      1: ClanPageAppBar(),
      2: MapsPageAppBar(),
      3: GuidePageAppBar(),
      4: ProfilesPageAppBar(),
      5: SettingsPageAppBar(),
    };
    return _buildAppBarMap[index];
  }

  Widget _buildBody(int index) {
    final _buildBodyMap = {
      0: StatisticsPage(),
      1: ClanPage(),
      2: MapsPage(),
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
