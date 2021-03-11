class PlayerInfo {
  String tag;
  String name;
  int townHallLevel;
  int townHallWeaponLevel;
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
  LegendStatistics legendStatistics;
  List<Achievements> achievements;
  int versusBattleWinCount;
  List<Labels> labels;
  List<Troops> troops;
  List<Heroes> heroes;
  List<Spells> spells;

  PlayerInfo(
      {this.tag,
      this.name,
      this.townHallLevel,
      this.townHallWeaponLevel,
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
      this.legendStatistics,
      this.achievements,
      this.versusBattleWinCount,
      this.labels,
      this.troops,
      this.heroes,
      this.spells});

  PlayerInfo.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    townHallLevel = json['townHallLevel'];
    townHallWeaponLevel = json['townHallWeaponLevel'];
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
    legendStatistics = json['legendStatistics'] != null
        ? new LegendStatistics.fromJson(json['legendStatistics'])
        : null;
    if (json['achievements'] != null) {
      achievements = <Achievements>[];
      json['achievements'].forEach((v) {
        achievements.add(new Achievements.fromJson(v));
      });
    }
    versusBattleWinCount = json['versusBattleWinCount'];
    if (json['labels'] != null) {
      labels = <Labels>[];
      json['labels'].forEach((v) {
        labels.add(new Labels.fromJson(v));
      });
    }
    if (json['troops'] != null) {
      troops = <Troops>[];
      json['troops'].forEach((v) {
        troops.add(new Troops.fromJson(v));
      });
    }
    if (json['heroes'] != null) {
      heroes = <Heroes>[];
      json['heroes'].forEach((v) {
        heroes.add(new Heroes.fromJson(v));
      });
    }
    if (json['spells'] != null) {
      spells = <Spells>[];
      json['spells'].forEach((v) {
        spells.add(new Spells.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['name'] = this.name;
    data['townHallLevel'] = this.townHallLevel;
    data['townHallWeaponLevel'] = this.townHallWeaponLevel;
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
    if (this.legendStatistics != null) {
      data['legendStatistics'] = this.legendStatistics.toJson();
    }
    if (this.achievements != null) {
      data['achievements'] = this.achievements.map((v) => v.toJson()).toList();
    }
    data['versusBattleWinCount'] = this.versusBattleWinCount;
    if (this.labels != null) {
      data['labels'] = this.labels.map((v) => v.toJson()).toList();
    }
    if (this.troops != null) {
      data['troops'] = this.troops.map((v) => v.toJson()).toList();
    }
    if (this.heroes != null) {
      data['heroes'] = this.heroes.map((v) => v.toJson()).toList();
    }
    if (this.spells != null) {
      data['spells'] = this.spells.map((v) => v.toJson()).toList();
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
  IconUrlsLeague iconUrls;

  League({this.id, this.name, this.iconUrls});

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconUrls = json['iconUrls'] != null
        ? new IconUrlsLeague.fromJson(json['iconUrls'])
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

class LegendStatistics {
  int legendTrophies;
  BestSeason bestSeason;
  BestSeason bestVersusSeason;
  CurrentSeason currentSeason;

  LegendStatistics(
      {this.legendTrophies,
      this.bestSeason,
      this.bestVersusSeason,
      this.currentSeason});

  LegendStatistics.fromJson(Map<String, dynamic> json) {
    legendTrophies = json['legendTrophies'];
    bestSeason = json['bestSeason'] != null
        ? new BestSeason.fromJson(json['bestSeason'])
        : null;
    bestVersusSeason = json['bestVersusSeason'] != null
        ? new BestSeason.fromJson(json['bestVersusSeason'])
        : null;
    currentSeason = json['currentSeason'] != null
        ? new CurrentSeason.fromJson(json['currentSeason'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['legendTrophies'] = this.legendTrophies;
    if (this.bestSeason != null) {
      data['bestSeason'] = this.bestSeason.toJson();
    }
    if (this.bestVersusSeason != null) {
      data['bestVersusSeason'] = this.bestVersusSeason.toJson();
    }
    if (this.currentSeason != null) {
      data['currentSeason'] = this.currentSeason.toJson();
    }
    return data;
  }
}

class BestSeason {
  String id;
  int rank;
  int trophies;

  BestSeason({this.id, this.rank, this.trophies});

  BestSeason.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rank = json['rank'];
    trophies = json['trophies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rank'] = this.rank;
    data['trophies'] = this.trophies;
    return data;
  }
}

class CurrentSeason {
  int rank;
  int trophies;

  CurrentSeason({this.rank, this.trophies});

  CurrentSeason.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    trophies = json['trophies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rank'] = this.rank;
    data['trophies'] = this.trophies;
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

class Troops extends Army {
  Troops({name, level, maxLevel, village});

  Troops.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    level = json['level'];
    maxLevel = json['maxLevel'];
    village = json['village'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['level'] = level;
    data['maxLevel'] = maxLevel;
    data['village'] = village;
    return data;
  }
}

abstract class Army {
  String name;
  int level;
  int maxLevel;
  String village;
}

class Heroes extends Army {
  // String name;
  // int level;
  // int maxLevel;
  // String village;

  Heroes({name, level, maxLevel, village});

  Heroes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    level = json['level'];
    maxLevel = json['maxLevel'];
    village = json['village'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['level'] = level;
    data['maxLevel'] = maxLevel;
    data['village'] = village;
    return data;
  }
}

class Spells extends Army {
  Spells({name, level, maxLevel, village});

  Spells.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    level = json['level'];
    maxLevel = json['maxLevel'];
    village = json['village'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['level'] = level;
    data['maxLevel'] = maxLevel;
    data['village'] = village;
    return data;
  }
}

class Labels {
  num id;
  String name;
  IconUrlsLabels iconUrls;

  Labels({this.id, this.name, this.iconUrls});

  Labels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconUrls = json['iconUrls'] != null
        ? new IconUrlsLabels.fromJson(json['iconUrls'])
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

class IconUrlsLabels {
  String small;
  String medium;

  IconUrlsLabels({this.small, this.medium});

  IconUrlsLabels.fromJson(Map<String, dynamic> json) {
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

class IconUrlsLeague {
  String small;
  String tiny;
  String medium;

  IconUrlsLeague({this.small, this.tiny, this.medium});

  IconUrlsLeague.fromJson(Map<String, dynamic> json) {
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
