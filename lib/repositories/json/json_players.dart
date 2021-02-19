import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetPlayerInfo {
  Future<PlayerInfo> getData(String nameTag) async {
    var headers = {
      'Accept': 'application/json',
      'authorization':
          'Bearer <eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjY0YWZiMjZiLTI3MTAtNGRlZC1iN2MyLWI5Y2FmYzE1OTVkZiIsImlhdCI6MTYxMjc5MjY3MCwic3ViIjoiZGV2ZWxvcGVyLzA3MDliNDZlLTk2OWItZWQ3My00MzQ0LTk0MGI2MTg2NWI1OSIsInNjb3BlcyI6WyJjbGFzaCJdLCJsaW1pdHMiOlt7InRpZXIiOiJkZXZlbG9wZXIvc2lsdmVyIiwidHlwZSI6InRocm90dGxpbmcifSx7ImNpZHJzIjpbIjM3LjE0NC43Ny41MyJdLCJ0eXBlIjoiY2xpZW50In1dfQ.has2UEczmbsIhqJQlNhHVGFZeBUEdKeZCBd7z5GLiBTDFjHKVEKWseELP0a4hAWiBe5PlKWIBDJXYfVUgsW6fw>',
    };

    var res = await http.get(
        'https://api.clashofclans.com/v1/players/%23$nameTag',
        headers: headers);
    if (res.statusCode == 200) {
      log(res.body);
      return PlayerInfo.fromJson(json.decode(res.body));
    } else {
      print('${res.statusCode}');
      return Future.error('Error response ${res.statusCode}');
    }
  }
}









class PlayerInfo {
  String tag;
  String name;
  int townHallLevel;
  int expLevel;
  int trophies;
  int bestTrophies;
  int warStars;
  int attackWins;
  int defenseWins;
  int builderHallLevel;
  int versusTrophies;
  int bestVersusTrophies;
  int versusBattleWins;
  String role;
  int donations;
  int donationsReceived;
  Clan clan;
  League league;
  List<Achievements> achievements;
  int versusBattleWinCount;
  List<Troops> troops;

  PlayerInfo({
    this.tag,
    this.name,
    this.townHallLevel,
    this.expLevel,
    this.trophies,
    this.bestTrophies,
    this.warStars,
    this.attackWins,
    this.defenseWins,
    this.builderHallLevel,
    this.versusTrophies,
    this.bestVersusTrophies,
    this.versusBattleWins,
    this.role,
    this.donations,
    this.donationsReceived,
    this.clan,
    this.league,
    this.achievements,
    this.versusBattleWinCount,
    this.troops,
  });

  PlayerInfo.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    townHallLevel = json['townHallLevel'];
    expLevel = json['expLevel'];
    trophies = json['trophies'];
    bestTrophies = json['bestTrophies'];
    warStars = json['warStars'];
    attackWins = json['attackWins'];
    defenseWins = json['defenseWins'];
    builderHallLevel = json['builderHallLevel'];
    versusTrophies = json['versusTrophies'];
    bestVersusTrophies = json['bestVersusTrophies'];
    versusBattleWins = json['versusBattleWins'];
    role = json['role'];
    donations = json['donations'];
    donationsReceived = json['donationsReceived'];
    clan = json['clan'] != null ? new Clan.fromJson(json['clan']) : null;
    league =
        json['league'] != null ? new League.fromJson(json['league']) : null;
    if (json['achievements'] != null) {
      achievements = new List<Achievements>();
      json['achievements'].forEach((v) {
        achievements.add(new Achievements.fromJson(v));
      });
    }
    versusBattleWinCount = json['versusBattleWinCount'];

    if (json['troops'] != null) {
      troops = new List<Troops>();
      json['troops'].forEach((v) {
        troops.add(new Troops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['name'] = this.name;
    data['townHallLevel'] = this.townHallLevel;
    data['expLevel'] = this.expLevel;
    data['trophies'] = this.trophies;
    data['bestTrophies'] = this.bestTrophies;
    data['warStars'] = this.warStars;
    data['attackWins'] = this.attackWins;
    data['defenseWins'] = this.defenseWins;
    data['builderHallLevel'] = this.builderHallLevel;
    data['versusTrophies'] = this.versusTrophies;
    data['bestVersusTrophies'] = this.bestVersusTrophies;
    data['versusBattleWins'] = this.versusBattleWins;
    data['role'] = this.role;
    data['donations'] = this.donations;
    data['donationsReceived'] = this.donationsReceived;
    if (this.clan != null) {
      data['clan'] = this.clan.toJson();
    }
    if (this.league != null) {
      data['league'] = this.league.toJson();
    }
    if (this.achievements != null) {
      data['achievements'] = this.achievements.map((v) => v.toJson()).toList();
    }
    if (this.troops != null) {
      data['troops'] = this.troops.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Clan {
  String tag;
  String name;
  int clanLevel;
  BadgeUrls badgeUrls;

  Clan({this.tag, this.name, this.clanLevel, this.badgeUrls});

  Clan.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    clanLevel = json['clanLevel'];
    badgeUrls = json['badgeUrls'] != null
        ? new BadgeUrls.fromJson(json['badgeUrls'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['name'] = this.name;
    data['clanLevel'] = this.clanLevel;
    if (this.badgeUrls != null) {
      data['badgeUrls'] = this.badgeUrls.toJson();
    }
    return data;
  }
}

class BadgeUrls {
  String small;
  String large;
  String medium;

  BadgeUrls({this.small, this.large, this.medium});

  BadgeUrls.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['large'] = this.large;
    data['medium'] = this.medium;
    return data;
  }
}

class League {
  int id;
  String name;
  IconUrls iconUrls;

  League({this.id, this.name, this.iconUrls});

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconUrls = json['iconUrls'] != null
        ? new IconUrls.fromJson(json['iconUrls'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.iconUrls != null) {
      data['iconUrls'] = this.iconUrls.toJson();
    }
    return data;
  }
}

class IconUrls {
  String small;
  String tiny;
  String medium;

  IconUrls({this.small, this.tiny, this.medium});

  IconUrls.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    tiny = json['tiny'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['tiny'] = this.tiny;
    data['medium'] = this.medium;
    return data;
  }
}

class Achievements {
  String name;
  int stars;
  int value;
  int target;
  String info;
  String completionInfo;
  String village;

  Achievements(
      {this.name,
      this.stars,
      this.value,
      this.target,
      this.info,
      this.completionInfo,
      this.village});

  Achievements.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    stars = json['stars'];
    value = json['value'];
    target = json['target'];
    info = json['info'];
    completionInfo = json['completionInfo'];
    village = json['village'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['stars'] = this.stars;
    data['value'] = this.value;
    data['target'] = this.target;
    data['info'] = this.info;
    data['completionInfo'] = this.completionInfo;
    data['village'] = this.village;
    return data;
  }
}

class IconUrls1 {
  String small;
  String medium;

  IconUrls1({this.small, this.medium});

  IconUrls1.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['medium'] = this.medium;
    return data;
  }
}

class Troops {
  String name;
  int level;
  int maxLevel;
  String village;

  Troops({this.name, this.level, this.maxLevel, this.village});

  Troops.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    level = json['level'];
    maxLevel = json['maxLevel'];
    village = json['village'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['level'] = this.level;
    data['maxLevel'] = this.maxLevel;
    data['village'] = this.village;
    return data;
  }
}
