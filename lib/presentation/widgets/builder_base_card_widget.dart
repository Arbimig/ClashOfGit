
import 'package:clashofclans/internal/constants.dart';
import 'package:clashofclans/domain/models/player_model.dart';
import 'package:flutter/material.dart';

class BuilderBaseCardWidget extends StatelessWidget {
  final PlayerModel data;
  const BuilderBaseCardWidget({required this.data});

  @override
  Widget build(BuildContext context) {
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
