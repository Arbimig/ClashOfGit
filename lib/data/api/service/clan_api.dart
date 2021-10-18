import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:clashofclans/domain/models/clan_model.dart';

class GetClanInfo {
  Future<ClanModel> getData(String clanTag) async {
    var headers = {
      'Accept': 'application/json',
      'authorization':
          'Bearer <eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjY0YWZiMjZiLTI3MTAtNGRlZC1iN2MyLWI5Y2FmYzE1OTVkZiIsImlhdCI6MTYxMjc5MjY3MCwic3ViIjoiZGV2ZWxvcGVyLzA3MDliNDZlLTk2OWItZWQ3My00MzQ0LTk0MGI2MTg2NWI1OSIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjM3LjE0NC43Ny41MyJdLCJ0eXBlIjoiY2xpZW50In1dfQ.has2UEczmbsIhqJQlNhHVGFZeBUEdKeZCBd7z5GLiBTDFjHKVEKWseELP0a4hAWiBe5PlKWIBDJXYfVUgsW6fw>',
    };
    
    var res = await http.get(
         Uri.parse('https://api.clashofclans.com/v1/clans/%23$clanTag'),
        headers: headers);
    if (res.statusCode != 200) {
      log(res.body);
      return ClanModel.fromJson(json.decode(res.body));
    } else {
      print('${res.statusCode}');
      return Future.error('Error response ${res.statusCode}');
    }
  }
}
