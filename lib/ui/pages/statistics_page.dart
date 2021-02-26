import 'package:clashofclans/bloc/player_cubit_json/player_cubit.dart';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit_state.dart';
import 'package:clashofclans/repositories/constants.dart';
import 'package:clashofclans/repositories/database/data_base.dart';
import 'package:clashofclans/repositories/database/troops_constant.dart';
import 'package:clashofclans/repositories/json/player_info.dart';
import 'package:clashofclans/ui/pages/apps_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsPage extends StatelessWidget {
  final SFDataBase sfDataBase = SFDataBase();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(builder: (context, state) {
      if (state is PlayerLoadingState) {
        return Container(
          child: FutureBuilder(
            future: playerCubitFunc.fplayerInfoList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                PlayerInfo data =
                    snapshot.data[state.index == null ? 0 : state.index];
                return Column(
                  children: [
                    statistics(data),
                    // achievements(data),
                    army(data.troops),
                    army(data.spells),
                    army(data.heroes),
                  ],
                );
              }
              return Container();
            },
          ),
        );
      }

      return Container();
    });
  }

  statistics(PlayerInfo data) => Padding(
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
                            Text(
                              '${data.expLevel}',
                              style: TextStyle(
                                  color: themeData.textTheme.headline1.color,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 30),
                            ),
                            SizedBox(width: 20),
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
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          child:
                              Image.network('${data.league.iconUrls.medium}'),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '${data.clan.clanLevel}',
                              style: TextStyle(
                                  color: themeData.textTheme.headline1.color,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 30),
                            ),
                            SizedBox(width: 20),
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
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          child: Image.network('${data.clan.badgeUrls.large}'),
                        ),
                      ],
                    ),
                  ],
                ),
              )
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
                                      : [null])),
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
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: appBarColor,
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
