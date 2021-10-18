
import 'package:clashofclans/internal/constants.dart';
import 'package:clashofclans/domain/models/player_model.dart';
import 'package:flutter/material.dart';

class AchievementsStatistics extends StatelessWidget {
  final PlayerModel data;
  AchievementsStatistics({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: data.achievements?.length,
          itemBuilder: (context, i) {
            var datar = data.achievements?[i];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  trailing: datar?.stars == 3
                      ? Container(
                          width: deviceWidth * 0.06,
                          child: Image.asset(
                              'assets/icons/achievements/green-check.png'),
                        )
                      : Container(
                          width: deviceWidth * 0.2,
                          child: Text(
                            '${datar?.value} / ${datar?.target}',
                            textAlign: TextAlign.end,
                            style: themeData.textTheme.headline2,
                          )),
                  leading: Container(
                      width: deviceWidth * 0.15,
                      child: Image.asset(
                          'assets/icons/achievements/${datar?.stars}_star_icon.png')),
                  title: Text('${datar?.name}',
                      style: themeData.textTheme.headline1),
                  subtitle: Text(
                    '${datar?.info}',
                    style: themeData.textTheme.headline3,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
