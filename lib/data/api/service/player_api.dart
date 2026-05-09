import 'package:clashofclans/data/api/base_api.dart';
import 'package:clashofclans/domain/models/player_model.dart';

class GetPlayerInfo {
  final BaseApi _api = BaseApi();

  Future<PlayerModel> getData(String nameTag) async {
    final json = await _api.get('/players/%23$nameTag');
    return PlayerModel.fromJson(json);
  }
}
