class ClanModel {
  late String tag;
  late String name;
  late String type;
  late String description;
  late Location location;
  late BadgeUrls badgeUrls;
  late int clanLevel;
  late int clanPoints;
  late int clanVersusPoints;
  late int requiredTrophies;
  late String warFrequency;
  late int warWinStreak;
  late int warWins;
  late int warTies;
  late int warLosses;
  late bool isWarLogPublic;
  late WarLeague warLeague;
  late int members;
  late List<MemberList> memberList;
  late List<Label> labels;

  ClanModel(
      {required this.tag,
      required this.name,
      required this.type,
      required this.description,
      required this.location,
      required this.badgeUrls,
      required this.clanLevel,
      required this.clanPoints,
      required this.clanVersusPoints,
      required this.requiredTrophies,
      required this.warFrequency,
      required this.warWinStreak,
      required this.warWins,
      required this.warTies,
      required this.warLosses,
      required this.isWarLogPublic,
      required this.warLeague,
      required this.members,
      required this.memberList,
      required this.labels});

  ClanModel.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    location = (json['location'] != null
        ? new Location.fromJson(json['location'])
        : null)!;
    badgeUrls = (json['badgeUrls'] != null
        ? new BadgeUrls.fromJson(json['badgeUrls'])
        : null)!;
    clanLevel = json['clanLevel'];
    clanPoints = json['clanPoints'];
    clanVersusPoints = json['clanVersusPoints'];
    requiredTrophies = json['requiredTrophies'];
    warFrequency = json['warFrequency'];
    warWinStreak = json['warWinStreak'];
    warWins = json['warWins'];
    warTies = json['warTies'];
    warLosses = json['warLosses'];
    isWarLogPublic = json['isWarLogPublic'];
    warLeague = (json['warLeague'] != null
        ? new WarLeague.fromJson(json['warLeague'])
        : null)!;
    members = json['members'];
    if (json['memberList'] != null) {
      memberList = <MemberList>[];
      json['memberList'].forEach((v) {
        memberList.add(new MemberList.fromJson(v));
      });
    }
    if (json['labels'] != null) {
      labels = <Label>[];
      json['labels'].forEach((v) {
        labels.add(new Label.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['name'] = this.name;
    data['type'] = this.type;
    data['description'] = this.description;
    // ignore: unnecessary_null_comparison
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    // ignore: unnecessary_null_comparison
    if (this.badgeUrls != null) {
      data['badgeUrls'] = this.badgeUrls.toJson();
    }
    data['clanLevel'] = this.clanLevel;
    data['clanPoints'] = this.clanPoints;
    data['clanVersusPoints'] = this.clanVersusPoints;
    data['requiredTrophies'] = this.requiredTrophies;
    data['warFrequency'] = this.warFrequency;
    data['warWinStreak'] = this.warWinStreak;
    data['warWins'] = this.warWins;
    data['warTies'] = this.warTies;
    data['warLosses'] = this.warLosses;
    data['isWarLogPublic'] = this.isWarLogPublic;
    // ignore: unnecessary_null_comparison
    if (this.warLeague != null) {
      data['warLeague'] = this.warLeague.toJson();
    }
    data['members'] = this.members;
    // ignore: unnecessary_null_comparison
    if (this.memberList != null) {
      data['memberList'] = this.memberList.map((v) => v.toJson()).toList();
    }
    // ignore: unnecessary_null_comparison
    if (this.labels != null) {
      data['labels'] = this.labels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  late int id;
  late String name;
  late bool isCountry;
  late String countryCode;

  Location({required this.id, required this.name, required this.isCountry, required this.countryCode});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isCountry = json['isCountry'];
    countryCode = json['countryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isCountry'] = this.isCountry;
    data['countryCode'] = this.countryCode;
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

class WarLeague {
  late int id;
  late String name;

  WarLeague({required this.id, required this.name});

  WarLeague.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class MemberList {
  late String tag;
  late String name;
  late String role;
  late int expLevel;
  late League league;
  late int trophies;
  late int versusTrophies;
  late int clanRank;
  late int previousClanRank;
  late int donations;
  late int donationsReceived;

  MemberList(
      {required this.tag,
      required this.name,
      required this.role,
      required this.expLevel,
      required this.league,
      required this.trophies,
      required this.versusTrophies,
      required this.clanRank,
      required this.previousClanRank,
      required this.donations,
      required this.donationsReceived});

  MemberList.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    role = json['role'];
    expLevel = json['expLevel'];
    league =
        (json['league'] != null ? new League.fromJson(json['league']) : null)!;
    trophies = json['trophies'];
    versusTrophies = json['versusTrophies'];
    clanRank = json['clanRank'];
    previousClanRank = json['previousClanRank'];
    donations = json['donations'];
    donationsReceived = json['donationsReceived'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['name'] = this.name;
    data['role'] = this.role;
    data['expLevel'] = this.expLevel;
    // ignore: unnecessary_null_comparison
    if (this.league != null) {
      data['league'] = this.league.toJson();
    }
    data['trophies'] = this.trophies;
    data['versusTrophies'] = this.versusTrophies;
    data['clanRank'] = this.clanRank;
    data['previousClanRank'] = this.previousClanRank;
    data['donations'] = this.donations;
    data['donationsReceived'] = this.donationsReceived;
    return data;
  }
}

class League {
  late int id;
  late String name;
  late IconUrls iconUrls;

  League({required this.id, required this.name, required this.iconUrls});

  League.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconUrls = (json['iconUrls'] != null
        ? new IconUrls.fromJson(json['iconUrls'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    // ignore: unnecessary_null_comparison
    if (this.iconUrls != null) {
      data['iconUrls'] = this.iconUrls.toJson();
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

class LabelIconUrls {
  late String small;
  late String medium;

  LabelIconUrls({required this.small, required this.medium});

  LabelIconUrls.fromJson(Map<String, dynamic> json) {
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

class Label {
  late int id;
  late String name;
  late LabelIconUrls iconUrls;
  Label({
    required this.id,
    required this.name,
    required this.iconUrls,
  });

  Label.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconUrls = (json['iconUrls'] != null
        ? LabelIconUrls.fromJson(json['iconUrls'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    // ignore: unnecessary_null_comparison
    if (this.iconUrls != null) {
      data['iconUrls'] = this.iconUrls.toJson();
    }
    return data;
  }
}
