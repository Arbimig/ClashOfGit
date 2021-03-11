import 'dart:developer';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit.dart';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit_state.dart';
import 'package:clashofclans/bloc/swith_theme_cubit.dart';
import 'package:clashofclans/repositories/constants.dart';
import 'package:clashofclans/repositories/database/data_base.dart';
import 'package:clashofclans/repositories/database/army_constant.dart';
import 'package:clashofclans/repositories/json/player_info.dart';
import 'package:clashofclans/ui/pages/apps_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsPage extends StatelessWidget {
  final SFDataBase sfDataBase = SFDataBase();
  @override
  Widget build(BuildContext context) {
    playerCubitFunc = context.read<PlayerCubit>();
    return BlocBuilder<PlayerCubit, PlayerState>(builder: (context, state) {
      if (state is PlayerLoadingState) {
        return FutureBuilder(
            future: playerCubitFunc
                .fplayerInfo(state.index == null ? 0 : state.index),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                PlayerInfo data = snapshot.data;
                return TabBarView(children: [
                  PlayerStatistics(data: data),
                  ArmyStatistics(data: data),
                  AchievementsStatistics(data: data),
                ]);
              }
              return Center(
                child: Text('add player'),
              );
            });
      }
      return Container();
    });
  }
}

class PlayerStatistics extends StatelessWidget {
  final PlayerInfo data;
  PlayerStatistics({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 4, left: 4),
      child: ListView(children: [
        playerCard(),
        clanCard(),
        homeBaseCard(),
        builderBaseCard(),
      ]),
    );
  }

  Widget playerCard() {
    _playerInfoListTile() => Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                width: 50,
                child: Stack(children: [
                  Center(
                    child:
                        Image.asset('assets/icons/statistics/level-back.png'),
                  ),
                  Center(
                    child: Text(
                      '${data.expLevel}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16),
                    ),
                  ),
                ]),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.name}',
                      style: themeData.textTheme.headline1,
                    ),
                    Text(
                      '${data.tag}',
                      style: themeData.textTheme.headline3,
                    ),
                  ]),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  splashRadius: 20,
                  splashColor: themeData.accentColor,
                  icon: Icon(Icons.share_outlined),
                  iconSize: 18,
                  color: themeData.primaryColor.withOpacity(0.8),
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: data.tag));
                  }),
            ),
          ],
        );
    _labelsInfo() {
      if (data.labels.length != null)
        return Container(
          height: 40,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.labels.length,
              itemBuilder: (context, i) {
                log('${data.labels.length}  data.labels.length');
                var labels = data.labels[i];
                return Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Image.network('${labels.iconUrls.medium}'),
                );
              }),
        );
      else {
        return SizedBox();
      }
    }

    _donationsOnfo() =>
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'DONATIONS' + ' ${data.donations}',
            style: themeData.textTheme.headline3,
          ),
          Text(
            'DONATIONS RECEIVED' + ' ${data.donationsReceived}',
            style: themeData.textTheme.headline3,
          )
        ]);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3.0,
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 15.0),
          _playerInfoListTile(),
          SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '${data.role}',
              style: themeData.textTheme.headline2,
            ),
          ),
          SizedBox(height: 15.0),
          Padding(
              padding: const EdgeInsets.only(left: 10.0), child: _labelsInfo()),
          SizedBox(height: 15.0),
          _donationsOnfo(),
          SizedBox(height: 15.0),
        ]),
      ),
    );
  }

  Widget clanCard() {
    _playerInfoListTile() => Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                width: 50,
                child: Image.network(data.clan.badgeUrls.medium),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.clan.name}',
                      style: themeData.textTheme.headline1,
                    ),
                    Text(
                      '${data.clan.tag}',
                      style: themeData.textTheme.headline3,
                    ),
                  ]),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  splashRadius: 20,
                  splashColor: themeData.accentColor,
                  icon: Icon(Icons.share_outlined),
                  iconSize: 18,
                  color: themeData.primaryColor.withOpacity(0.8),
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: data.clan.tag));
                  }),
            ),
          ],
        );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3.0,
      child: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 15.0),
          _playerInfoListTile(),
          SizedBox(height: 15.0),
        ]),
      ),
    );
  }

  Widget homeBaseCard() {
    thInfo() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  height: 50,
                  width: 50,
                  child: Image.asset(data.townHallWeaponLevel == null
                      ? 'assets/icons/home_base/Town_Hall${data.townHallLevel}.png'
                      : 'assets/icons/home_base/Town_Hall${data.townHallLevel}-${data.townHallWeaponLevel}.png')),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('TH LVL', style: themeData.textTheme.headline2),
                  Text('${data.townHallLevel}',
                      style: themeData.textTheme.headline2),
                ],
              ),
            ),
            data.townHallWeaponLevel != null
                ? Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('TH WEAPON LVL',
                            style: themeData.textTheme.headline2),
                        Text('${data.townHallWeaponLevel}',
                            style: themeData.textTheme.headline2),
                      ],
                    ),
                  )
                : Expanded(flex: 2, child: Container()),
          ],
        );
    leagueInfo() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  height: 50,
                  width: 50,
                  child: Image.network(data.league.iconUrls.medium)),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${data.league.name.toUpperCase()}',
                      style: themeData.textTheme.headline2),
                  Text('${data.trophies}',
                      style: themeData.textTheme.headline2),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('BEST TROPHIES', style: themeData.textTheme.headline2),
                  Text('${data.bestTrophies}',
                      style: themeData.textTheme.headline2),
                ],
              ),
            )
          ],
        );
    attackInfo() =>
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'ATTACK WINS' + ' ${data.attackWins}',
            style: themeData.textTheme.headline3,
          ),
          Text(
            'WAR STARS' + ' ${data.warStars}',
            style: themeData.textTheme.headline3,
          ),
          Text(
            'DEFENSE WINS' + ' ${data.defenseWins}',
            style: themeData.textTheme.headline3,
          )
        ]);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3.0,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text(
                'HOME BASE',
                style: themeData.textTheme.headline2,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            thInfo(),
            SizedBox(
              height: 15,
            ),
            leagueInfo(),
            SizedBox(
              height: 15,
            ),
            attackInfo(),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget builderBaseCard() {
    bthInfo() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                      'assets/icons/builder_base/Builder_Hall${data.builderHallLevel}.png')),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('BTH LVL', style: themeData.textTheme.headline2),
                  Text('${data.builderHallLevel}',
                      style: themeData.textTheme.headline2),
                ],
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        );
    vLeagueInfo() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 40,
                width: 40,
                child: Image.asset('assets/icons/builder_base/double-axe.png'),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('VERSUS LEAGUE', style: themeData.textTheme.headline2),
                  Text('${data.versusTrophies}',
                      style: themeData.textTheme.headline2),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('BEST TROPHIES', style: themeData.textTheme.headline2),
                  Text('${data.bestVersusTrophies}',
                      style: themeData.textTheme.headline2),
                ],
              ),
            )
          ],
        );
    battleInfo() =>
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            'VS BATTLE WINS' + ' ${data.versusBattleWins}',
            style: themeData.textTheme.headline3,
          ),
        ]);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3.0,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text(
                'BUILDER BASE',
                style: themeData.textTheme.headline2,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            bthInfo(),
            SizedBox(
              height: 15,
            ),
            vLeagueInfo(),
            SizedBox(
              height: 15,
            ),
            battleInfo(),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class ArmyStatistics extends StatelessWidget {
  final PlayerInfo data;
  const ArmyStatistics({this.data});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverToBoxAdapter(
          child: ListTile(
              title: Text(
            'Troops',
            style: themeData.textTheme.headline1,
          )),
        ),
        armySliverGrid(context, data.troops),
        SliverToBoxAdapter(
          child: ListTile(
              title: Text(
            'Spells',
            style: themeData.textTheme.headline1,
          )),
        ),
        armySliverGrid(context, data.spells),
        SliverToBoxAdapter(
          child: ListTile(
              title: Text(
            'Heroes',
            style: themeData.textTheme.headline1,
          )),
        ),
        armySliverGrid(context, data.heroes),
      ],
    );
  }

  Widget armySliverGrid(context, List<Army> data) {
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                mediaQueryData.orientation == Orientation.portrait ? 4 : 8),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            var datat = data[index];
            return Container(
              padding: EdgeInsets.all(1),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Image.asset(
                        data is List<Troops>
                            ? troopsDB[datat.name]
                            : data is List<Spells>
                                ? spellsDB[datat.name]
                                : data is List<Heroes>
                                    ? heroesDB[datat.name]
                                    : troopsDB[datat.name],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: datat.level == datat.maxLevel
                                    ? [
                                        Colors.yellow[800].withOpacity(0.2),
                                        Colors.yellow[600].withOpacity(0.05),
                                      ]
                                    : [
                                        Colors.black.withOpacity(0),
                                        Colors.black.withOpacity(0)
                                      ])),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                              Colors.black45,
                              Colors.black.withOpacity(0),
                            ])),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            boxShadow: datat.level == datat.maxLevel
                                ? [
                                    BoxShadow(
                                      color: Colors.yellow[600],
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : [
                                    BoxShadow(
                                      color: themeData.accentColor
                                          .withOpacity(0.5),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ],
                            borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: datat.level == datat.maxLevel
                                    ? [
                                        Colors.yellow[600].withOpacity(0.2),
                                        Colors.yellow[800]
                                      ]
                                    : [
                                        themeData.accentColor.withOpacity(0.5),
                                        themeData.accentColor,
                                      ]),
                          ),
                          child: Center(
                            child: Text(
                              '${datat.level}',
                              style: themeData.textTheme.caption,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        left: 3,
                        child: Text(
                          '${datat.name}',
                          style: themeData.textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          childCount: data.length,
        ));
  }
}

class AchievementsStatistics extends StatelessWidget {
  final PlayerInfo data;
  AchievementsStatistics({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: data.achievements.length,
          itemBuilder: (context, i) {
            var datar = data.achievements[i];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  trailing: datar.stars == 3
                      ? Container(
                          width: deviceWidth * 0.06,
                          child: Image.asset(
                              'assets/icons/achievements/green-check.png'),
                        )
                      : Container(
                          width: deviceWidth * 0.2,
                          child: Text(
                            '${datar.value} / ${datar.target}',
                            textAlign: TextAlign.end,
                            style: themeData.textTheme.headline2,
                          )),
                  leading: Container(
                      width: deviceWidth * 0.15,
                      child: Image.asset(
                          'assets/icons/achievements/${datar.stars}_star_icon.png')),
                  title: Text('${datar.name}',
                      style: themeData.textTheme.headline1),
                  subtitle: Text(
                    '${datar.info}',
                    style: themeData.textTheme.headline3,
                  ),
                ),
              ),
            );
          }),
    );
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
