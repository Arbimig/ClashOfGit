import 'package:clashofclans/bloc/player_cubit_json/player_cubit.dart';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit_state.dart';
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
    return BlocBuilder<PlayerCubit, PlayerState>(builder: (context, state) {
      if (state is PlayerLoadingState) {
        return TabBarView(children: [
          homePage(state),
          builderBasePage(state),
          clanPage(state),
          achievementsPage(state),
        ]);
      }
      return Container();
    });
  }

  Widget clanPage(state) {
    return Container(
      child: FutureBuilder(
        future: playerCubitFunc.fplayerInfoList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PlayerInfo data =
                snapshot.data[state.index == null ? 0 : state.index];
            return Column(
              children: [
                clanStatistics(data),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget homePage(state) {
    return Container(
      child: FutureBuilder(
        future: playerCubitFunc.fplayerInfoList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PlayerInfo data =
                snapshot.data[state.index == null ? 0 : state.index];

            return CustomScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverToBoxAdapter(
                  child: playerStatistics(data),
                ),
                SliverToBoxAdapter(
                  child: ListTile(
                      title: Text(
                    'Troops',
                    style: themeData.textTheme.headline1,
                  )),
                ),
                armySliverGrid(context, data.troops, 'home'),
                SliverToBoxAdapter(
                  child: ListTile(
                      title: Text(
                    'Spells',
                    style: themeData.textTheme.headline1,
                  )),
                ),
                armySliverGrid(context, data.spells, 'home'),
                SliverToBoxAdapter(
                  child: ListTile(
                      title: Text(
                    'Heroes',
                    style: themeData.textTheme.headline1,
                  )),
                ),
                armySliverGrid(context, data.heroes, 'home'),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget builderBasePage(state) {
    return Container(
      child: FutureBuilder(
        future: playerCubitFunc.fplayerInfoList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PlayerInfo data =
                snapshot.data[state.index == null ? 0 : state.index];

            return CustomScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverToBoxAdapter(
                  child: playerStatistics(data),
                ),
                SliverToBoxAdapter(
                  child: ListTile(
                      title: Text(
                    'Troops',
                    style: themeData.textTheme.headline1,
                  )),
                ),
                armySliverGrid(context, data.troops, 'builderBase'),
                SliverToBoxAdapter(
                  child: ListTile(
                      title: Text(
                    'Spells',
                    style: themeData.textTheme.headline1,
                  )),
                ),
                armySliverGrid(context, data.spells, 'builderBase'),
                SliverToBoxAdapter(
                  child: ListTile(
                      title: Text(
                    'Heroes',
                    style: themeData.textTheme.headline1,
                  )),
                ),
                armySliverGrid(context, data.heroes, 'builderBase'),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget achievementsPage(state) {
    return Container(
      child: FutureBuilder(
        future: playerCubitFunc.fplayerInfoList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PlayerInfo data =
                snapshot.data[state.index == null ? 0 : state.index];
            return Column(
              children: [
                achievements(data),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget armySliverGrid(
      BuildContext context, List<dynamic> data, String village) {
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                mediaQueryData.orientation == Orientation.portrait ? 4 : 8),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            if (data[index].village == village) {
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
                                          themeData.accentColor
                                              .withOpacity(0.5),
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
            } else{
              return Container();
            }
          },
          childCount: data.length,
        ));
  }

  homeVillage(PlayerInfo data) => Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          height: deviceHeight * 0.3,
          width: deviceWidth * 0.35,
          child: Column(
            children: [
              Container(
                height: 50,
                width: 50,
                child: Image.network(data.league.iconUrls.medium),
              ),
              SizedBox(height: 10),
              Text(
                'townHall level ${data.townHallLevel}',
                style: themeData.textTheme.headline2,
              ),
              SizedBox(height: 10),
              Text(
                'trophies ${data.trophies}',
                style: themeData.textTheme.headline2,
              ),
              SizedBox(height: 10),
              Text(
                'best trophies ${data.bestTrophies}',
                style: themeData.textTheme.headline2,
              ),
            ],
          ),
        ),
      );

  clanStatistics(PlayerInfo data) => Card(
        child: Container(
          color: Colors.grey[600],
          height: deviceHeight * 0.2,
          width: deviceWidth * 0.95,
          child: Column(children: [
            Row(
              children: [
                Container(
                  width: deviceWidth * 0.5,
                  color: Colors.grey[400],
                  child: ListTile(
                    title: Text(
                      '${data.clan.name}',
                      style: themeData.textTheme.headline1,
                    ),
                    subtitle: Text(
                      '${data.clan.tag}',
                      style: themeData.textTheme.headline3,
                    ),
                    leading: Container(
                        height: 50,
                        width: 50,
                        child: Image.network('${data.clan.badgeUrls.large}')),
                    trailing: IconButton(
                        splashRadius: 20,
                        splashColor: themeData.accentColor,
                        icon: Icon(Icons.share_outlined),
                        iconSize: 18,
                        color: themeData.primaryColor.withOpacity(0.8),
                        onPressed: () {
                          Clipboard.setData(
                              new ClipboardData(text: data.clan.tag));
                        }),
                  ),
                ),
                // Container(
                //    width: deviceWidth * 0.4,
                //   color: Colors.grey[500],
                //   child: ListTile(
                //     title: Text(
                //       '${data.clan.name}',
                //       style: themeData.textTheme.headline1,
                //     ),
                //     subtitle: Text(
                //       '${data.clan.tag}',
                //       style: themeData.textTheme.headline3,
                //     ),
                //     leading: Container(
                //       height: 50,
                //       width: 50,
                //       child: Image.network('${data.clan.badgeUrls.large}')),
                //     trailing: IconButton(
                //         splashRadius: 20,
                //         splashColor: themeData.accentColor,
                //         icon: Icon(Icons.share_outlined),
                //         iconSize: 18,
                //         color: themeData.primaryColor.withOpacity(0.8),
                //         onPressed: () {
                //           Clipboard.setData(
                //               new ClipboardData(text: data.clan.tag));
                //         }),
                //   ),
                // ),
              ],
            ),
            // data.labels.length != null
            //     ? Expanded(
            //         child: Container(
            //           padding: EdgeInsets.all(5),
            //           child: ListView.builder(
            //               scrollDirection: Axis.horizontal,
            //               itemCount: data.labels.length,
            //               itemBuilder: (context, i) {
            //                 var labels = data.labels[i];
            //                 return Padding(
            //                   padding: const EdgeInsets.all(4.0),
            //                   child: Container(
            //                     height: 40,
            //                     width: 40,
            //                     child: Image.network(
            //                         '${labels.iconUrls.medium}'),
            //                   ),
            //                 );
            //               }),
            //         ),
            //       )
            //     : SizedBox(),
          ]),
        ),
      );

  playerStatistics(PlayerInfo data) => Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Card(
          elevation: 2.0,
          child: Container(
            width: deviceWidth * 0.9,
            height: deviceHeight * 0.2,
            child: Column(children: [
              ListTile(
                title: Text(
                  '${data.name}',
                  style: themeData.textTheme.headline1,
                ),
                subtitle: Text(
                  '${data.tag}',
                  style: themeData.textTheme.headline3,
                ),
                leading: Container(
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
                trailing: IconButton(
                    splashRadius: 20,
                    splashColor: themeData.accentColor,
                    icon: Icon(Icons.share_outlined),
                    iconSize: 18,
                    color: themeData.primaryColor.withOpacity(0.8),
                    onPressed: () {
                      Clipboard.setData(new ClipboardData(text: data.clan.tag));
                    }),
              ),
              data.labels.length != null
                  ? Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.labels.length,
                            itemBuilder: (context, i) {
                              var labels = data.labels[i];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.network(
                                      '${labels.iconUrls.medium}'),
                                ),
                              );
                            }),
                      ),
                    )
                  : SizedBox(),
            ]),
          ),
        ),
      );

  statistics1(PlayerInfo data) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: Container(
            height: deviceHeight * 0.2,
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Stack(children: [
                                Center(
                                  child: Image.asset(
                                      'assets/icons/statistics/level-back.png'),
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
                            SizedBox(width: 5),
                            Column(
                              children: [
                                Text(
                                  '${data.name}',
                                  style: themeData.textTheme.headline1,
                                ),
                                Text(
                                  '${data.tag}',
                                  style: themeData.textTheme.headline3,
                                ),
                              ],
                            ),
                            IconButton(
                                icon: Icon(Icons.share_outlined),
                                splashRadius: 20,
                                splashColor: themeData.accentColor,
                                iconSize: 18,
                                color: themeData.primaryColor.withOpacity(0.8),
                                onPressed: () {
                                  Clipboard.setData(
                                      new ClipboardData(text: data.tag));
                                }),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child:
                                  Image.network('${data.clan.badgeUrls.large}'),
                            ),
                            SizedBox(width: 5),
                            Column(
                              children: [
                                Text(
                                  '${data.clan.name}',
                                  style: themeData.textTheme.headline1,
                                ),
                                Text(
                                  '${data.clan.tag}',
                                  style: themeData.textTheme.headline3,
                                ),
                              ],
                            ),
                            IconButton(
                                splashRadius: 20,
                                splashColor: themeData.accentColor,
                                icon: Icon(Icons.share_outlined),
                                iconSize: 18,
                                color: themeData.primaryColor.withOpacity(0.8),
                                onPressed: () {
                                  Clipboard.setData(
                                      new ClipboardData(text: data.clan.tag));
                                })
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              data.labels.length != null
                  ? Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.labels.length,
                            itemBuilder: (context, i) {
                              var labels = data.labels[i];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.network(
                                      '${labels.iconUrls.medium}'),
                                ),
                              );
                            }),
                      ),
                    )
                  : SizedBox(),
            ]),
          ),
        ),
      );

  achievements(PlayerInfo data) => Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: data.achievements.length,
              itemBuilder: (context, i) {
                var datar = data.achievements[i];
                return Card(
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
                );
              }),
        ),
      );

  army(List<dynamic> data) => Expanded(
        ///Takes values `Heroes`, `Spells`,  `Troops`.
        child: Container(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemCount: data.length,
            itemBuilder: (context, i) {
              var datat = data[i];
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
                                          themeData.accentColor
                                              .withOpacity(0.5),
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
          ),
        ),
      );
}

class StatisticsAppBar extends StatelessWidget with PrefAppBar {
  @override
  Size get preferredSize =>
      Size.fromHeight(AppBar().preferredSize.height * 1.5);
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: appBarColor,
      bottom: TabBar(
        tabs: [
          Tab(
            text: 'Home',
          ),
          Tab(
            text: 'Bulder base',
          ),
          Tab(
            text: 'Clan',
          ),
          Tab(
            text: 'Achievements',
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
        IconButton(icon: Icon(Icons.web), onPressed: () {})
      ],
      centerTitle: true,
    );
  }
}
