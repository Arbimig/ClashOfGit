import 'dart:convert';
import 'dart:developer';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit.dart';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit_state.dart';
import 'package:clashofclans/repositories/constants.dart';
import 'package:clashofclans/repositories/database/data_base.dart';
import 'package:clashofclans/repositories/json/json_players.dart';
import 'package:clashofclans/ui/pages/apps_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ProfilesPage extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  SFDataBase sfDataBase = SFDataBase();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(
      builder: (BuildContext context, state) {
        if (state is PlayerEmptyState) {
          return Column(
            children: [
              addCard(context),
              sfDataBasePlayerList(context),
            ],
          );
        }
        if (state is PlayerLoadingState) {
          return Column(children: [
            Card(
              child: Center(
                child: Container(
                  width: deviceWidth * 0.9,
                  height: deviceHeight * 0.1,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            sfDataBasePlayerList(context, state: state)
          ]);
        }
        if (state is PlayerLoadedState) {
          var data = state.playersInfo;
          return Column(
            children: [
              addCard(context),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: InkWell(
                            onLongPress: () {
                              List<String> keys = sfDataBase.getSFTagList();
                              showAlertDialog(context, keys[index]);
                            },
                            child: Center(
                                child: Container(
                              width: deviceWidth * 0.9,
                              height: deviceHeight * 0.1,
                              child: ListTile(
                                trailing: Container(
                                    width: deviceHeight * 0.08,
                                    height: deviceHeight * 0.08,
                                    child: Image.network(
                                        '${data[index].league.iconUrls.medium}')),
                                title: Text(
                                  '${data[index].name}',
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                                subtitle: Text(
                                  '${data[index].tag}',
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ),
                            )),
                          ),
                        );
                      }),
                ),
              ),
            ],
          );
        }
        if (state is PlayerErrorState) {
          return Column(
            children: [
              addCard(context),
              sfDataBasePlayerList(context),
            ],
          );
        }
        return Center(child: Text('Error'));
      },
    );
  }

  Widget sfDataBasePlayerList(BuildContext context, {PlayerState state}) {
    return Expanded(
      child: Container(
        child: FutureBuilder(
          future: sfDataBase.getSFTagList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            var keysLenght = snapshot.data.toList().length;
            var keys = snapshot.data.toList();
            log(keysLenght.toString() + '  futurebuilderLenght');
            log(keys.toString() + '  futurebuilderkeys');
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: keysLenght,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: sfDataBase.getJsonOfSF('${keys[index]}'),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        final PlayerInfo _playerInfo =
                            PlayerInfo.fromJson(json.decode(snapshot.data));
                        PlayerInfo data = _playerInfo;
                        return Card(
                          child: InkWell(
                            onLongPress: () {
                              showAlertDialog(context, keys[index]);
                              log(keys[index] + 'showAlertDialog PlayerTag');
                            },
                            child: Center(
                                child: Container(
                              width: deviceWidth * 0.9,
                              height: deviceHeight * 0.1,
                              child: ListTile(
                                trailing: Container(
                                    width: deviceHeight * 0.08,
                                    height: deviceHeight * 0.08,
                                    child: Image.network(
                                        '${data.league.iconUrls.medium}')),
                                title: Text(
                                  '${data.name}',
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                                subtitle: Text(
                                  '${data.tag}',
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ),
                            )),
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  );
                },
              );
            } else {
              return Center(child: Text('error'));
            }
          },
        ),
      ),
    );
  }

  Widget addCard(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          _displayTextInputDialog(context);
        },
        child: Center(
            child: Container(
          width: deviceWidth * 0.9,
          height: deviceHeight * 0.07,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add player', style: TextStyle(fontWeight: FontWeight.w300)),
              Icon(Icons.add),
            ],
          ),
        )),
      ),
    );
  }

  showAlertDialog(BuildContext context, String playerTag) {
    // set up the button
    Widget deleteButton = FlatButton(
      child: Text("Delete"),
      onPressed: () {
        playerCubitFunc.deletePlayer(playerTag);
        Navigator.pop(context);
      },
    );
    Widget closeButton = FlatButton(
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

  void _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Player Tag'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                // onChanged: (value) {},

                validator: _validate,
                controller: textEditingController,
                decoration: InputDecoration(
                    hintText: "#XXXXXX",
                    suffix: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _submitForm(context);
                      },
                    )),
              ),
            ),
          );
        });
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final playerTag = textEditingController.value.text.replaceAll('#', '');

      playerCubitFunc.fetchPlayer(playerTag);
      print(playerTag);
      Navigator.pop(context);
    } else {
      return print('Error validate');
    }
  }

  String _validate(String value) {
    if (value.isEmpty) {
      return 'Tag cannot be empty';
    } else if (!textEditingController.text.startsWith('#')) {
      return 'Invalid Tag address';
    } else {
      return null;
    }
  }
}

class ProfilesPageAppBar extends StatelessWidget with PrefAppBar {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      title: Text('Profiles page'),
      actions: [],
      centerTitle: true,
    );
  }
}
