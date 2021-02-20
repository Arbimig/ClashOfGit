import 'package:clashofclans/bloc/player_cubit_json/player_cubit.dart';
import 'package:clashofclans/bloc/player_cubit_json/player_cubit_state.dart';
import 'package:clashofclans/repositories/constants.dart';
import 'package:clashofclans/repositories/database/data_base.dart';
import 'package:clashofclans/ui/pages/apps_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsPage extends StatelessWidget {
  final SFDataBase sfDataBase = SFDataBase();
  final TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(builder: (context, state) {
      if (state is PlayerLoadingState) {
        return Column(
          children: [
            addCard(context),
          ],
        );
      }
      if (state is PlayerLoadedState) {
        var data = state.playersInfoList;
        return Column(
          children: [
            addCard(context),
            Expanded(
              child: Container(
                child: infoCard(context, data: data),
              ),
            ),
          ],
        );
      }
      return Container();
    });
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

  Widget infoCard(BuildContext context, {@required var data}) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, i) {
        return Card(
          child: InkWell(
            onLongPress: () async {
              var tags = await playerCubitFunc.getTags();
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
                    child: Image.network('${data[i].league.iconUrls.medium}')),
                title: Text(
                  '${data[i].name}',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                subtitle: Text(
                  '${data[i].tag}',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
            )),
          ),
        );
      },
    );
  }

  showAlertDialog(BuildContext context, String playerTag) {
    // set up the button
    Widget deleteButton = FlatButton(
      child: Text("Delete"),
      onPressed: () {
        playerCubitFunc.delete(playerTag);
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
      playerCubitFunc.add(playerTag);
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
