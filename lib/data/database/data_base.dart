import 'dart:convert';
import 'dart:developer';
import 'package:clashofclans/data/api/service/player_api.dart';
import 'package:clashofclans/domain/models/player_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SFDataBase {
  Future<void> addJsonToSF(String playerTag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PlayerModel _playerInfo =
        await GetPlayerInfo().getData('${playerTag.replaceAll('#', '')}');
    log(_playerInfo.name.toString() + ' player info');
    log(_playerInfo.clan.toString() + ' player info');
    var result = jsonEncode(_playerInfo);
    log(result + ' jsonencode');
    prefs.setString(playerTag, json.encode(_playerInfo));
  }

  Future<void> deleteJsonSF(String playerTag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(playerTag);
  }

  Future<PlayerModel> getJsonOfSF(String playerTag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonOfSF = prefs.getString(playerTag);
    // log(jsonOfSF.toString() + 'json of set +++++++++');
    final PlayerModel playerInfo = PlayerModel.fromJson(json.decode(jsonOfSF!));
    // log(playerInfo.name.toString() + 'playerinfo -------------');
    return playerInfo;
  }

  Future<List<String>> getSFTagList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tagSF = prefs.getKeys().toList();
    //log(tagSF.toList().toString() + '  data_base.dart log of getSFTagList');
    return tagSF;
  }
}
