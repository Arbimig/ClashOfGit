import 'package:clashofclans/bloc/player_cubit_json/player_cubit.dart';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit_state.dart';
import 'package:clashofclans/repositories/constants.dart';
import 'package:clashofclans/repositories/database/data_base.dart';
import 'package:clashofclans/repositories/json/json_players.dart';
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: Container(
                          height: deviceHeight * 0.2,
                          child: Column(children: [
                            Row(children: [
                              Text(data.expLevel.toString(), style: TextStyle(),)
                            ],)
                          ]),
                        ),
                      ),
                    ),
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
}

class StatisticsAppBar extends StatelessWidget with PrefAppBar {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: appBarColor,
      title: Text(
        'Statistics',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.wb_sunny_outlined),
          onPressed: () {
            themeCubit.toggleTheme();
          },
        ),
        IconButton(icon: Icon(Icons.web),onPressed: () {})
      ],
      centerTitle: true,
    );
  }
}
