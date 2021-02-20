import 'dart:convert';
import 'package:clashofclans/repositories/json/json_players.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SFDataBase {
  Future<void> addJsonToSF(String playerTag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PlayerInfo _playerInfo = await GetPlayerInfo().getData('$playerTag');
    prefs.setString(playerTag, jsonEncode(_playerInfo));
  }

  Future<void> deleteJsonSF(String playerTag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(playerTag);
  }

  Future<PlayerInfo> getJsonOfSF(String playerTag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonOfSF = prefs.getString(playerTag);
    // log(jsonOfSF.toString() + 'json of set +++++++++');
    final PlayerInfo playerInfo = PlayerInfo.fromJson(json.decode(jsonOfSF));
    // log(playerInfo.name.toString() + 'playerinfo -------------');
    return playerInfo;
  }

  Future<List<String>> getSFTagList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tagSF = prefs.getKeys().toList();
    // log(tagSF.toList().toString() + '  data_base.dart log of getSFTagList');
    return tagSF;
  }
}
