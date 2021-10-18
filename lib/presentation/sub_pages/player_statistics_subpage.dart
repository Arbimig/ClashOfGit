import 'package:clashofclans/presentation/widgets/builder_base_card_widget.dart';
import 'package:clashofclans/presentation/widgets/clan_card_widget.dart';
import 'package:clashofclans/presentation/widgets/home_base_card_widget.dart';
import 'package:clashofclans/presentation/widgets/player_card_widget.dart';
import 'package:clashofclans/domain/models/player_model.dart';
import 'package:flutter/material.dart';

class PlayerStatistics extends StatelessWidget {
  final PlayerModel data;
  PlayerStatistics({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 4, left: 4),
      child: ListView(children: [
        PlayerCardWidget(
          data: data,
        ),
        data.clan != null
            ? ClanCardWidget(
                data: data,
              )
            : Container(),
        HomeBaseCardWidget(
          data: data,
        ),
        BuilderBaseCardWidget(
          data: data,
        ),
      ]),
    );
  }
}
