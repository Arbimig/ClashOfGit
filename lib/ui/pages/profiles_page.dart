import 'dart:developer';

import 'package:clashofclans/bloc/player_cubit_json/player_cubit.dart';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit_state.dart';
import 'package:clashofclans/bloc/swith_theme_cubit.dart';
import 'package:clashofclans/repositories/constants.dart';
import 'package:clashofclans/repositories/database/data_base.dart';
import 'package:clashofclans/ui/pages/apps_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clashofclans/bloc/timer_cubit.dart';

class ProfilesPage extends StatelessWidget {
  final SFDataBase sfDataBase = SFDataBase();
  final TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    playerCubitFunc = context.read<PlayerCubit>();
    return BlocBuilder<PlayerCubit, PlayerState>(builder: (context, state) {
      if (state is PlayerLoadingState) {
        return Column(
          children: [
            addCard(context),
            FutureBuilder(
              future: playerCubitFunc.fplayerInfoList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return infoCard(context, data: snapshot.data);
                }
                return Container();
              },
            ),
          ],
        );
      }
      if (state is PlayerErrorState) {
        return Column(
          children: [
            addCard(context),
            FutureBuilder(
              future: playerCubitFunc.fplayerInfoList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return infoCard(context, data: snapshot.data);
                }
                return Container();
              },
            ),
          ],
        );
      }
      return Container();
    });
  }

  Widget addCard(BuildContext context) {
    return BlocBuilder<TimerCubit, int>(
      builder: (context, time) {
        TimerCubit timer = context.read<TimerCubit>();
        return Card(
          color: time == 0
              ? themeData.cardColor
              : themeData.cardColor.withOpacity(0.5),
          child: InkWell(
            onTap: time == 0
                ? () {
                    _displayTextInputDialog(context, timer);
                  }
                : null,
            child: Center(
                child: Container(
              width: deviceWidth * 0.9,
              height: deviceHeight * 0.07,
              child: Stack(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Add player',
                            style: TextStyle(fontWeight: FontWeight.w300)),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: time != 0
                        ? Text('$time seconds',
                            textAlign: TextAlign.end,
                            style: themeData.textTheme.headline3)
                        : SizedBox(),
                  )
                ],
              ),
            )),
          ),
        );
      },
    );
  }

  Widget infoCard(BuildContext context, {@required var data}) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, i) {
            return Card(
              child: InkWell(
                onTap: () async {
                  var tags = await playerCubitFunc.getTags();
                  var indexwhere =
                      tags.indexWhere((note) => note.startsWith(tags[i]));
                  playerCubitFunc.swith(indexwhere);
                },
                onLongPress: () async {
                  var tags = await playerCubitFunc.getTags();
                  log(tags.toString());
                  showAlertDialog(context, tags[i]);
                },
                child: Center(
                    child: Container(
                  width: deviceWidth * 0.9,
                  height: deviceHeight * 0.1,
                  child: ListTile(
                    trailing: Container(
                        width: deviceHeight * 0.08,
                        height: deviceHeight * 0.08,
                        child:
                            Image.network('${data[i].league.iconUrls.medium}')),
                    title: Text(
                      '${data[i].name}',
                      style: themeData.textTheme.headline1,
                    ),
                    subtitle: Text(
                      '${data[i].tag}',
                      style: themeData.textTheme.headline2,
                    ),
                  ),
                )),
              ),
            );
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, String playerTag) {
    // set up the button
    Widget deleteButton = TextButton(
      child: Text("Delete"),
      onPressed: () {
        playerCubitFunc.delete(playerTag);
        Navigator.pop(context);
      },
    );
    Widget closeButton = TextButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text("This is my message."),
      actions: [
        deleteButton,
        closeButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _displayTextInputDialog(BuildContext context, TimerCubit timer) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Player Tag'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                validator: _validate,
                controller: textEditingController,
                decoration: InputDecoration(
                    hintText: "#XXXXXX",
                    suffix: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _submitForm(context, timer);
                      },
                    )),
              ),
            ),
          );
        });
  }

  void _submitForm(BuildContext context, TimerCubit timer) {
    playerCubitFunc = context.read<PlayerCubit>();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final playerTag = textEditingController.value.text;
      playerCubitFunc.add(playerTag);
      timer.startTimer();
      Navigator.pop(context);
    } else {
      return print('Error validate');
    }
  }

  String _validate(String value) {
    String text = textEditingController.text;
    if (value.isEmpty) {
      return 'Tag cannot be empty';
    } else if (!text.startsWith('#')) {
      return 'Invalid Tag address';
    } else if (text.toUpperCase() != text) {
      return 'Invalid Tag address';
    } else {
      return null;
    }
  }
}

class ProfilesPageAppBar extends StatelessWidget with PrefAppBar {
  @override
  Widget build(BuildContext context) {
        themeCubit = context.watch<ThemeCubit>();
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: appBarColor,
      title: Text(
        'Profiles page',
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
