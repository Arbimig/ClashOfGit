import 'dart:developer';
import 'package:clashofclans/config/api_config.dart';
import 'package:clashofclans/domain/models/player_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetPlayerInfo {
  Future<PlayerModel> getData(String nameTag) async {
    var uri = '${ApiConfig.baseUrl}/players/%23$nameTag';
    var res = await http.get(Uri.parse(uri), headers: ApiConfig.headers);
    if (res.statusCode == 200) {
      log(res.body);
      return PlayerModel.fromJson(json.decode(res.body));
    } else {
      print('${res.statusCode}');
      return Future.error('Error response ${res.statusCode}');
    }
  }
}
