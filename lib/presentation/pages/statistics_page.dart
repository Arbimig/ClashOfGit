import 'package:clashofclans/data/bloc/player_cubit.dart';
import 'package:clashofclans/data/bloc/switch_player_cubit.dart';
import 'package:clashofclans/data/bloc/swith_theme_cubit.dart';
import 'package:clashofclans/presentation/sub_pages/achievements_statistics_subpage.dart';
import 'package:clashofclans/presentation/sub_pages/army_statistics_subpage.dart';
import 'package:clashofclans/presentation/sub_pages/player_statistics_subpage.dart';
import 'package:flutter/material.dart';
import 'package:clashofclans/internal/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../internal/apps_page.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    playerCubitFunc = context.read<PlayerCubit>();
    return BlocBuilder<SwitchPlayerCubit, PlayerIndex>(
        builder: (context, profIndex) {
      if (profIndex is PlayerIndexState) {
        return BlocBuilder<PlayerCubit, PlayerState>(builder: (context, state) {
          if (state is PlayerLoadingState) {
            return FutureBuilder(
                future: playerCubitFunc.fplayerInfo(profIndex.index),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    dynamic data = snapshot.data;
                    return TabBarView(children: [
                      PlayerStatistics(data: data),
                      ArmyStatistics(data: data),
                      AchievementsStatistics(data: data),
                    ]);
                  }
                  return Center(
                    child: Text('add player1'),
                  );
                });
          }
          return Container();
        });
      }
      if (profIndex is NoPlayerIndexState) {
        return TabBarView(children: [
          Center(child: Text('add player')),
          Center(child: Text('add player')),
          Center(child: Text('add player'))
        ]);
      }
      return Container();
    });
  }
}

class StatisticsAppBar extends StatelessWidget with PrefAppBar {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height * 2);
  Widget build(BuildContext context) {
    themeCubit = context.watch<ThemeCubit>();
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: appBarColor,
      bottom: TabBar(
        tabs: [
          Tab(
            child: Text('Player',
                style: themeData.textTheme.subtitle1,
                softWrap: false,
                overflow: TextOverflow.fade),
          ),
          Tab(
            child: Text('Army',
                style: themeData.textTheme.subtitle1,
                softWrap: false,
                overflow: TextOverflow.fade),
          ),
          Tab(
            child: Text(
              'Achievements',
              style: themeData.textTheme.subtitle1,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          )
        ],
      ),
      title: Text(
        'Statistics',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.wb_sunny_outlined),
          onPressed: () {
            themeCubit.toggleTheme();
          },
        ),
      ],
      centerTitle: true,
    );
  }
}
