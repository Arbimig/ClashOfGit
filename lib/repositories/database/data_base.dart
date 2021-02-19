import 'dart:convert';
import 'dart:developer';

import 'package:clashofclans/repositories/json/json_players.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SFDataBase {
  addJsonToSF(String playerTag, String playerInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(playerTag, playerInfo);
  }

  void deleteJsonSF(String playerTag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs..remove(playerTag);
  }

  getJsonOfSF(String playerTag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonOfSF = prefs.getString(playerTag);
    // log(prefs.getKeys().toList().toString());
    log(jsonOfSF.toString() + 'json of set +++++++++');
    final PlayerInfo playerInfo = PlayerInfo.fromJson(json.decode(jsonOfSF));
    log(playerInfo.toString() + 'playerinfo -------------');
    return jsonOfSF;
  }

  getSFTagList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tagSF = prefs.getKeys().toList();
    log(tagSF.toList().toString() + '  data_base.dart log of getSFTagList');
    return tagSF;
  }
}

// class SFDataBase {
//   SharedPreferences prefs;
//   getPrefs() async {
//     prefs = await SharedPreferences.getInstance();
//     return prefs;
//   }

//   addJsonToSF(String playerTag, String playerInfo) {
//     prefs = getPrefs();
//     prefs.setString(playerTag, playerInfo);

//     List<String> sharedPrefKeys = prefs.getKeys().toList();
//     print(sharedPrefKeys);
//   }

//   PlayerInfo getJsonOfSF(String playerTag) {
//     prefs = getPrefs();
//     PlayerInfo jsonOfSF = jsonDecode(prefs.getString(playerTag));
//     return jsonOfSF;
//   }

//   List<String> getSFkeyList() {
//     SharedPreferences prefs1 = getPrefs();
//     List<String> keysSF = prefs1.getKeys().toList();
//     log(keysSF.toString());
//     return keysSF;
//   }
// }
