import 'package:cached_network_image/cached_network_image.dart';
import 'package:clashofclans/internal/constants.dart';
import 'package:clashofclans/domain/models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayerCardWidget extends StatelessWidget {
  final PlayerModel data;
  PlayerCardWidget({required this.data});
  @override
  Widget build(BuildContext context) {
    void snackBar(context) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Player tag copied"),
      ));
    }

    _playerInfoListTile(context) => Row(
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
                    snackBar(context);
                    Clipboard.setData(new ClipboardData(text: data.tag));
                  }),
            ),
          ],
        );

    _labelsInfo() {
      if (data.labels != null) {
        return Container(
          height: 40,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.labels!.length,
              itemBuilder: (context, i) {
                var labels = data.labels![i];
                // log('${data.labels.length}  data.labels.length');
                return Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: CachedNetworkImage(
                    // fit: BoxFit.cover,
                    imageUrl: '${labels.iconUrls!.medium}',
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
                // Image.network('${labels.iconUrls.medium}'));
              }),
        );
      } else {
        return SizedBox();
      }
    }

    _donationsInfo() =>
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
          _playerInfoListTile(context),
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
          _donationsInfo(),
          SizedBox(height: 15.0),
        ]),
      ),
    );
  }
}
