import 'package:clashofclans/data/api/base_api.dart';
import 'package:clashofclans/domain/models/clan_model.dart';

class GetClanInfo {
  final BaseApi _api = BaseApi();

  Future<ClanModel> getData(String clanTag) async {
    final json = await _api.get('/clans/%23$clanTag');
    return ClanModel.fromJson(json);
  }
}
