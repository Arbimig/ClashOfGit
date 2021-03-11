class ClanInfo {
  String tag;
  String name;
  String type;
  String description;
  Location location;
  BadgeUrls badgeUrls;
  int clanLevel;
  int clanPoints;
  int clanVersusPoints;
  int requiredTrophies;
  String warFrequency;
  int warWinStreak;
  int warWins;
  int warTies;
  int warLosses;
  bool isWarLogPublic;
  WarLeague warLeague;
  int members;
  List<MemberList> memberList;
  List<Label> labels;

  ClanInfo(
      {this.tag,
      this.name,
      this.type,
      this.description,
      this.location,
      this.badgeUrls,
      this.clanLevel,
      this.clanPoints,
      this.clanVersusPoints,
      this.requiredTrophies,
      this.warFrequency,
      this.warWinStreak,
      this.warWins,
      this.warTies,
      this.warLosses,
      this.isWarLogPublic,
      this.warLeague,
      this.members,
      this.memberList,
      this.labels});

  ClanInfo.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    badgeUrls = json['badgeUrls'] != null
        ? new BadgeUrls.fromJson(json['badgeUrls'])
        : null;
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
    warLeague = json['warLeague'] != null
        ? new WarLeague.fromJson(json['warLeague'])
        : null;
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
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
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
    if (this.warLeague != null) {
      data['warLeague'] = this.warLeague.toJson();
    }
    data['members'] = this.members;
    if (this.memberList != null) {
      data['memberList'] = this.memberList.map((v) => v.toJson()).toList();
    }
    if (this.labels != null) {
      data['labels'] = this.labels.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  int id;
  String name;
  bool isCountry;
  String countryCode;

  Location({this.id, this.name, this.isCountry, this.countryCode});

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

class WarLeague {
  int id;
  String name;

  WarLeague({this.id, this.name});

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
  String tag;
  String name;
  String role;
  int expLevel;
  League league;
  int trophies;
  int versusTrophies;
  int clanRank;
  int previousClanRank;
  int donations;
  int donationsReceived;

  MemberList(
      {this.tag,
      this.name,
      this.role,
      this.expLevel,
      this.league,
      this.trophies,
      this.versusTrophies,
      this.clanRank,
      this.previousClanRank,
      this.donations,
      this.donationsReceived});

  MemberList.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    name = json['name'];
    role = json['role'];
    expLevel = json['expLevel'];
    league =
        json['league'] != null ? new League.fromJson(json['league']) : null;
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

class LabelIconUrls {
  String small;
  String medium;

  LabelIconUrls({this.small, this.medium});

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
  int id;
  String name;
  LabelIconUrls iconUrls;
  Label({
    this.id,
    this.name,
    this.iconUrls,
  });

  Label.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconUrls = json['iconUrls'] != null
        ? LabelIconUrls.fromJson(json['iconUrls'])
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
