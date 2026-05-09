import 'dart:convert';
import 'dart:developer';
import 'package:clashofclans/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:clashofclans/domain/models/clan_model.dart';

class GetClanInfo {
  Future<ClanModel> getData(String clanTag) async {
    var res = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/clans/%23$clanTag'),
        headers: ApiConfig.headers);
    if (res.statusCode == 200) {
      log(res.body);
      return ClanModel.fromJson(json.decode(res.body));
    } else {
      print('${res.statusCode}');
      return Future.error('Error response ${res.statusCode}');
    }
  }
}
