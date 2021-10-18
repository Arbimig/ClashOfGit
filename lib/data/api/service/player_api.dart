import 'dart:developer';
import 'package:clashofclans/domain/models/player_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetPlayerInfo {
  Future<PlayerModel> getData(String nameTag) async {
    var headers = {
      'Accept': 'application/json',
      'authorization':
          'Bearer <eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjQ1MDM1NDMyLTg5ZGMtNDE1Yy04MWIzLWUzZDNjY2YxZDZhZiIsImlhdCI6MTYyODc3NDQzMCwic3ViIjoiZGV2ZWxvcGVyLzA3MDliNDZlLTk2OWItZWQ3My00MzQ0LTk0MGI2MTg2NWI1OSIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjM3LjE0NC43My4yMzYiXSwidHlwZSI6ImNsaWVudCJ9XX0.5KfWU8-dpJ7Vm_r1N2hrrRYZeieBNJo2LSQjxElA0gXMQ-5tJc7PPyboqX5Bi_J-_xXo3pUID2-q-SbjEDFM3g>',
    };
    var uri = 'https://api.clashofclans.com/v1/players/%23$nameTag';
    var res = await http.get(Uri.parse(uri), headers: headers);
    if (res.statusCode == 200) {
      log(res.body);
      return PlayerModel.fromJson(json.decode(res.body));
    } else {
      print('${res.statusCode}');
      return Future.error('Error response ${res.statusCode}');
    }
  }
}
