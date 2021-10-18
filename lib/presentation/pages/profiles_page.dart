import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clashofclans/data/bloc/player_cubit.dart';
import 'package:clashofclans/data/bloc/swith_theme_cubit.dart';
import 'package:clashofclans/data/bloc/timer_cubit.dart';
import 'package:clashofclans/domain/models/player_model.dart';
import 'package:clashofclans/internal/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../internal/apps_page.dart';



class Modal {
  mainBottomSheet(BuildContext context, String data) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<TimerCubit, int>(
            builder: (BuildContext context, time) {
              if (time == 0) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _createTile(
                      context,
                      'Update',
                      Icons.arrow_upward_outlined,
                      _update,
                      data,
                    ),
                    _createTile(
                      context,
                      'Delete',
                      Icons.delete_outline,
                      _remove,
                      data,
                    ),
                  ],
                );
              }
              if (time > 0) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _createTile(
                      context,
                      'Delete',
                      Icons.delete_outline,
                      _remove,
                      data,
                    ),
                  ],
                );
              }
              return Container();
            },
          );
        });
  }

  ListTile _createTile(
    BuildContext context,
    String name,
    IconData icon,
    Function action,
    String playerTag,
  ) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(
        name,
        style: themeData.textTheme.headline2,
      ),
      onTap: action(context, playerTag),
    );
  }

  _update(context, String playerTag) {
    print('Modal.dart action2 updateCar');
    // playerCubitFunc.update(playerTag);
    // Navigator.pop(context);
  }

  _remove(context, String playerTag) {
    print('Modal.dart action3 removeCar');
    // playerCubitFunc.delete(playerTag);
    // Navigator.pop(context);
  }
}

class ProfilesPage extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Modal modal = new Modal();
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
                  dynamic sdata = snapshot.data;
                  List<PlayerModel> data = sdata;
                  return Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return infoCard(context, data, i);
                        },
                      ),
                    ),
                  );
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
                  dynamic data = snapshot.data;
                  return Expanded(
                    child: Container(
                      child: ListView.builder(
                        itemCount: data.lenght,
                        itemBuilder: (context, i) {
                          return infoCard(context, data, i);
                        },
                      ),
                    ),
                  );
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

  Widget infoCard(BuildContext context, var data, int i) {
    return Card(
      child: InkWell(
        onTap: () async {
          switchPlayerCubit.switchPlayer(i);
        },
        onLongPress: () async {
          var tags = await playerCubitFunc.getTags();
          log(tags.toString());
          modal.mainBottomSheet(context, tags[i]);
        },
        child: Center(
            child: Container(
          width: deviceWidth * 0.9,
          height: deviceHeight * 0.1,
          child: ListTile(
            trailing: Container(
              width: deviceHeight * 0.08,
              height: deviceHeight * 0.08,
              child: data[i].league != null
                  ? CachedNetworkImage(
                      // fit: BoxFit.cover,
                      imageUrl: '${data[i].league.iconUrls.medium}',
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : SizedBox(),
            ),
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
                style: TextStyle(color: themeData.primaryColor),
                cursorColor: themeData.primaryColor,
                validator: _validate,
                controller: textEditingController,
                decoration: InputDecoration(
                    fillColor: Colors.red,
                    focusColor: Colors.red,
                    hoverColor: Colors.red,
                    hintText: "#XXXXXX",
                    suffix: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: themeData.primaryColor,
                      ),
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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final playerTag = textEditingController.value.text;
      playerCubitFunc.add(playerTag);
      timer.startTimer();
      Navigator.pop(context);
    } else {
      return print('Error validate');
    }
  }

  String? _validate(String? value) {
    String text = textEditingController.text;
    if (value!.isEmpty) {
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
