import 'package:cached_network_image/cached_network_image.dart';
import 'package:clashofclans/internal/constants.dart';
import 'package:clashofclans/domain/models/player_model.dart';
import 'package:flutter/material.dart';

class HomeBaseCardWidget extends StatelessWidget {
  final PlayerModel data;
  const HomeBaseCardWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    thInfo() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  height: 50,
                  width: 50,
                  // ignore: unnecessary_null_comparison
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
            // ignore: unnecessary_null_comparison
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
                child: data.league != null
                    ? CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: '${data.league!.iconUrls!.medium}',
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    : Container(),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  data.league != null
                      ? Text('${data.league!.name.toUpperCase()}',
                          style: themeData.textTheme.headline2)
                      : Container(),
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
            // ignore: unnecessary_null_comparison
            data.league != null ? leagueInfo() : SizedBox(),
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
}
