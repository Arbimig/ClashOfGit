class PlayerModel {
  late String tag;
  late String name;
  late int townHallLevel;
  late int? townHallWeaponLevel;
  late int? expLevel;
  late int? trophies;
  late int? bestTrophies;
  late int? warStars;
  late int? attackWins;
  late int? defenseWins;
  late int? builderHallLevel;
  late int? versusTrophies;
  late int? bestVersusTrophies;
  late int? versusBattleWins;
  late String? role;
  late int? donations;
  late int? donationsReceived;
  late Clan? clan;
  late League? league;
  late LegendStatistics? legendStatistics;
  late List<Achievements>? achievements;
  late int? versusBattleWinCount;
  late List<Labels>? labels;
  late List<Troops>? troops;
  late List<Heroes>? heroes;
  late List<Spells>? spells;

  PlayerModel(
      {required this.tag,
      required this.name,
      required this.townHallLevel,
      required this.townHallWeaponLevel,
      required this.expLevel,
      required this.trophies,
      required this.bestTrophies,
      required this.warStars,
      required this.attackWins,
      required this.defenseWins,
      required this.builderHallLevel,
      required this.versusTrophies,
      required this.bestVersusTrophies,
      required this.versusBattleWins,
      required this.role,
      required this.donations,
      required this.donationsReceived,
      required this.clan,
      required this.league,
      required this.legendStatistics,
      required this.achievements,
      required this.versusBattleWinCount,
      required this.labels,
      required this.troops,
      required this.heroes,
      required this.spells});

  PlayerModel.fromJson(Map<String, dynamic> json) {
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
        achievements!.add(new Achievements.fromJson(v));
      });
    }
    versusBattleWinCount = json['versusBattleWinCount'];
    if (json['labels'] != null) {
      labels = <Labels>[];
      json['labels'].forEach((v) {
        labels!.add(new Labels.fromJson(v));
      });
    }
    if (json['troops'] != null) {
      troops = <Troops>[];
      json['troops'].forEach((v) {
        troops!.add(new Troops.fromJson(v));
      });
    }
    if (json['heroes'] != null) {
      heroes = <Heroes>[];
      json['heroes'].forEach((v) {
        heroes!.add(new Heroes.fromJson(v));
      });
    }
    if (json['spells'] != null) {
      spells = <Spells>[];
      json['spells'].forEach((v) {
        spells!.add(new Spells.fromJson(v));
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
      data['clan'] = this.clan!.toJson();
    }
    if (this.league != null) {
      data['league'] = this.league!.toJson();
    }
    if (this.legendStatistics != null) {
      data['legendStatistics'] = this.legendStatistics!.toJson();
    }
    if (this.achievements != null) {
      data['achievements'] = this.achievements!.map((v) => v.toJson()).toList();
    }
    data['versusBattleWinCount'] = this.versusBattleWinCount;
    if (this.labels != null) {
      data['labels'] = this.labels!.map((v) => v.toJson()).toList();
    }
    if (this.troops != null) {
      data['troops'] = this.troops!.map((v) => v.toJson()).toList();
    }
    if (this.heroes != null) {
      data['heroes'] = this.heroes!.map((v) => v.toJson()).toList();
    }
    if (this.spells != null) {
      data['spells'] = this.spells!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clan {
  late String tag;
  late String name;
  late int clanLevel;
  late BadgeUrls? badgeUrls;

  Clan(
      {required this.tag,
      required this.name,
      required this.clanLevel,
      required this.badgeUrls});

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
      data['badgeUrls'] = this.badgeUrls!.toJson();
    }
    return data;
  }
}

class BadgeUrls {
  late String small;
  late String large;
  late String medium;

  BadgeUrls({required this.small, required this.large, required this.medium});

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
  late int id;
  late String name;
  late IconUrlsLeague? iconUrls;

  League({required this.id, required this.name, required this.iconUrls});

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
      data['iconUrls'] = this.iconUrls!.toJson();
    }
    return data;
  }
}

class IconUrls {
  late String small;
  late String tiny;
  late String medium;

  IconUrls({required this.small, required this.tiny, required this.medium});

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
  late int legendTrophies;
  late BestSeason? bestSeason;
  late BestSeason? bestVersusSeason;
  late CurrentSeason? currentSeason;

  LegendStatistics(
      {required this.legendTrophies,
      required this.bestSeason,
      required this.bestVersusSeason,
      required this.currentSeason});

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
      data['bestSeason'] = this.bestSeason!.toJson();
    }
    if (this.bestVersusSeason != null) {
      data['bestVersusSeason'] = this.bestVersusSeason!.toJson();
    }
    if (this.currentSeason != null) {
      data['currentSeason'] = this.currentSeason!.toJson();
    }
    return data;
  }
}

class BestSeason {
  late String id;
  late int rank;
  late int trophies;

  BestSeason({required this.id, required this.rank, required this.trophies});

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
  late int rank;
  late int trophies;

  CurrentSeason({required this.rank, required this.trophies});

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
  late String? name;
  late int? stars;
  late int? value;
  late int? target;
  late String? info;
  late String? completionInfo;
  late String? village;

  Achievements(
      {required this.name,
      required this.stars,
      required this.value,
      required this.target,
      required this.info,
      required this.completionInfo,
      required this.village});

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

abstract class Army {
  late String name;
  late int level;
  late int maxLevel;
  late String village;
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

class Heroes extends Army {
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
  late num id;
  late String name;
  late IconUrlsLabels? iconUrls;

  Labels({required this.id, required this.name, required this.iconUrls});

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
      data['iconUrls'] = this.iconUrls!.toJson();
    }
    return data;
  }
}

class IconUrlsLabels {
  late String small;
  late String medium;

  IconUrlsLabels({required this.small, required this.medium});

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
  late String small;
  late String tiny;
  late String medium;

  IconUrlsLeague(
      {required this.small, required this.tiny, required this.medium});

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
