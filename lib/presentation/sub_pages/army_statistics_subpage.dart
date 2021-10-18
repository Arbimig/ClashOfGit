import 'package:clashofclans/data/database/army_constant.dart';
import 'package:clashofclans/internal/constants.dart';
import 'package:clashofclans/domain/models/player_model.dart';
import 'package:flutter/material.dart';

class ArmyStatistics extends StatelessWidget {
  final PlayerModel data;
  const ArmyStatistics({required this.data});

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

  Widget armySliverGrid(context, List<Army>? data) {
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                mediaQueryData.orientation == Orientation.portrait ? 4 : 8),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            var _data = data![index];
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
                            ? troopsDB[_data.name]!
                            : data is List<Spells>
                                ? spellsDB[_data.name]!
                                : data is List<Heroes>
                                    ? heroesDB[_data.name]!
                                    : troopsDB[_data.name]!,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: _data.level == _data.maxLevel
                                    ? [
                                        //TODO: Заменить цвет на RGBO
                                        Colors.yellow[800]!.withOpacity(0.2),
                                        Colors.yellow[600]!.withOpacity(0.05),
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
                            boxShadow: _data.level == _data.maxLevel
                                ? [
                                    //TODO: Заменить цвет на RGBO
                                    BoxShadow(
                                      color: Colors.yellow[600]!,
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
                                colors: _data.level == _data.maxLevel
                                    ? [
                                        Colors.yellow[600]!.withOpacity(0.2),
                                      ]
                                    : [
                                        themeData.accentColor.withOpacity(0.5),
                                        themeData.accentColor,
                                      ]),
                          ),
                          child: Center(
                            child: Text(
                              '${_data.level}',
                              style: themeData.textTheme.caption,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        left: 3,
                        child: Text(
                          '${_data.name}',
                          style: themeData.textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          childCount: data!.length,
        ));
  }
}
