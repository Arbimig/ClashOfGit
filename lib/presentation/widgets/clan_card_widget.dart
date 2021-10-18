import 'package:cached_network_image/cached_network_image.dart';
import 'package:clashofclans/internal/constants.dart';
import 'package:clashofclans/domain/models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClanCardWidget extends StatelessWidget {
  final PlayerModel data;
  const ClanCardWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    void snackBar(context) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Clan tag copied"),
      ));
    }

    _playerInfoListTile(context) => Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                width: 50,
                child: CachedNetworkImage(
                  // fit: BoxFit.cover,
                  imageUrl: '${data.clan!.badgeUrls!.medium}',
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                // Image.network(data.clan.badgeUrls.medium),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.clan!.name}',
                      style: themeData.textTheme.headline1,
                    ),
                    Text(
                      '${data.clan!.tag}',
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
                    Clipboard.setData(new ClipboardData(text: data.clan!.tag));
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
          _playerInfoListTile(context),
          SizedBox(height: 15.0),
        ]),
      ),
    );
  }
}
