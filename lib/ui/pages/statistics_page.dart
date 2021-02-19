import 'package:clashofclans/bloc/player_cubit_json/player_cubit.dart';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit_state.dart';
import 'package:clashofclans/repositories/constants.dart';
import 'package:clashofclans/ui/pages/apps_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<PlayerCubit, PlayerState>(builder: (context, state) {
        if (state is PlayerEmptyState) {
          return Center(
            child: Text(
              'No data received.',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          );
        }
        if (state is PlayerLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is PlayerLoadedState) {
          return Card(
              child: Container(
            padding: EdgeInsets.all(10),
            height: deviceHeight * 0.4,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text('${state.playersInfo[0].name}'),
                    subtitle: Text('${state.playersInfo[0].tag}'),
                    trailing: Column(
                      children: [
                        Text(state.playersInfo[0].league.name),
                      ],
                    ),
                    leading: Text('${state.playersInfo[0].expLevel}'),
                  ),
                ]),
          ));
        }
        if (state is PlayerErrorState) {
          return Center(
            child: Text(
              'Error fetching UserInfo',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }
        return null;
      }),
    );
  }
}

class StatisticsAppBar extends StatelessWidget with PrefAppBar {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      backgroundColor: appBarColor,
      title: Text('Clash of clans'),
      actions: [
        IconButton(
          icon: Icon(Icons.wb_sunny),
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
