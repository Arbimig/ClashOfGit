import 'package:flutter_test/flutter_test.dart';
import 'package:clashofclans/domain/models/clan_model.dart';

void main() {
  group('ClanModel', () {
    final fullJson = {
      'tag': '#CLAN123',
      'name': 'TestClan',
      'type': 'open',
      'description': 'A test clan',
      'location': {
        'id': 32000000,
        'name': 'Russia',
        'isCountry': true,
        'countryCode': 'RU',
      },
      'badgeUrls': {
        'small': 'https://small.png',
        'large': 'https://large.png',
        'medium': 'https://medium.png',
      },
      'clanLevel': 20,
      'clanPoints': 50000,
      'clanVersusPoints': 40000,
      'requiredTrophies': 2000,
      'warFrequency': 'always',
      'warWinStreak': 5,
      'warWins': 100,
      'warTies': 10,
      'warLosses': 50,
      'isWarLogPublic': true,
      'warLeague': {
        'id': 29000010,
        'name': 'Master League I',
      },
      'members': 45,
      'memberList': [
        {
          'tag': '#P1',
          'name': 'Leader',
          'role': 'leader',
          'expLevel': 200,
          'league': {
            'id': 29000022,
            'name': 'Legend League',
            'iconUrls': {
              'small': 'https://s.png',
              'tiny': 'https://t.png',
              'medium': 'https://m.png',
            }
          },
          'trophies': 5000,
          'versusTrophies': 4000,
          'clanRank': 1,
          'previousClanRank': 1,
          'donations': 1000,
          'donationsReceived': 500,
        }
      ],
      'labels': [
        {
          'id': 1,
          'name': 'Clan Wars',
          'iconUrls': {
            'small': 'https://ls.png',
            'medium': 'https://lm.png',
          }
        }
      ],
    };

    group('fromJson', () {
      test('parses all fields correctly', () {
        final clan = ClanModel.fromJson(fullJson);

        expect(clan.tag, '#CLAN123');
        expect(clan.name, 'TestClan');
        expect(clan.type, 'open');
        expect(clan.description, 'A test clan');
        expect(clan.clanLevel, 20);
        expect(clan.clanPoints, 50000);
        expect(clan.clanVersusPoints, 40000);
        expect(clan.requiredTrophies, 2000);
        expect(clan.warFrequency, 'always');
        expect(clan.warWinStreak, 5);
        expect(clan.warWins, 100);
        expect(clan.warTies, 10);
        expect(clan.warLosses, 50);
        expect(clan.isWarLogPublic, true);
        expect(clan.members, 45);
      });

      test('parses nested Location correctly', () {
        final clan = ClanModel.fromJson(fullJson);
        final location = clan.location;

        expect(location.id, 32000000);
        expect(location.name, 'Russia');
        expect(location.isCountry, true);
        expect(location.countryCode, 'RU');
      });

      test('parses nested BadgeUrls correctly', () {
        final clan = ClanModel.fromJson(fullJson);
        final badge = clan.badgeUrls;

        expect(badge.small, 'https://small.png');
        expect(badge.large, 'https://large.png');
        expect(badge.medium, 'https://medium.png');
      });

      test('parses nested WarLeague correctly', () {
        final clan = ClanModel.fromJson(fullJson);
        final warLeague = clan.warLeague;

        expect(warLeague.id, 29000010);
        expect(warLeague.name, 'Master League I');
      });

      test('parses memberList correctly', () {
        final clan = ClanModel.fromJson(fullJson);
        final members = clan.memberList;

        expect(members.length, 1);
        expect(members[0].tag, '#P1');
        expect(members[0].name, 'Leader');
        expect(members[0].role, 'leader');
        expect(members[0].expLevel, 200);
        expect(members[0].trophies, 5000);
        expect(members[0].versusTrophies, 4000);
        expect(members[0].clanRank, 1);
        expect(members[0].previousClanRank, 1);
        expect(members[0].donations, 1000);
        expect(members[0].donationsReceived, 500);
      });

      test('parses member league correctly', () {
        final clan = ClanModel.fromJson(fullJson);
        final memberLeague = clan.memberList[0].league;

        expect(memberLeague.id, 29000022);
        expect(memberLeague.name, 'Legend League');
        expect(memberLeague.iconUrls.small, 'https://s.png');
        expect(memberLeague.iconUrls.tiny, 'https://t.png');
        expect(memberLeague.iconUrls.medium, 'https://m.png');
      });

      test('parses labels correctly', () {
        final clan = ClanModel.fromJson(fullJson);
        final labels = clan.labels;

        expect(labels.length, 1);
        expect(labels[0].id, 1);
        expect(labels[0].name, 'Clan Wars');
        expect(labels[0].iconUrls.small, 'https://ls.png');
        expect(labels[0].iconUrls.medium, 'https://lm.png');
      });

      test('handles empty memberList', () {
        final json = Map<String, dynamic>.from(fullJson);
        json['memberList'] = [];

        final clan = ClanModel.fromJson(json);
        expect(clan.memberList.length, 0);
      });

      test('handles empty labels', () {
        final json = Map<String, dynamic>.from(fullJson);
        json['labels'] = [];

        final clan = ClanModel.fromJson(json);
        expect(clan.labels.length, 0);
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final clan = ClanModel.fromJson(fullJson);
        final result = clan.toJson();

        expect(result['tag'], '#CLAN123');
        expect(result['name'], 'TestClan');
        expect(result['type'], 'open');
        expect(result['description'], 'A test clan');
        expect(result['clanLevel'], 20);
        expect(result['clanPoints'], 50000);
        expect(result['clanVersusPoints'], 40000);
        expect(result['requiredTrophies'], 2000);
        expect(result['warFrequency'], 'always');
        expect(result['warWinStreak'], 5);
        expect(result['warWins'], 100);
        expect(result['warTies'], 10);
        expect(result['warLosses'], 50);
        expect(result['isWarLogPublic'], true);
        expect(result['members'], 45);
      });

      test('serializes nested Location correctly', () {
        final clan = ClanModel.fromJson(fullJson);
        final result = clan.toJson();

        expect(result['location']['id'], 32000000);
        expect(result['location']['name'], 'Russia');
        expect(result['location']['isCountry'], true);
        expect(result['location']['countryCode'], 'RU');
      });

      test('serializes nested BadgeUrls correctly', () {
        final clan = ClanModel.fromJson(fullJson);
        final result = clan.toJson();

        expect(result['badgeUrls']['small'], 'https://small.png');
        expect(result['badgeUrls']['large'], 'https://large.png');
        expect(result['badgeUrls']['medium'], 'https://medium.png');
      });

      test('serializes WarLeague correctly', () {
        final clan = ClanModel.fromJson(fullJson);
        final result = clan.toJson();

        expect(result['warLeague']['id'], 29000010);
        expect(result['warLeague']['name'], 'Master League I');
      });

      test('serializes memberList correctly', () {
        final clan = ClanModel.fromJson(fullJson);
        final result = clan.toJson();

        expect(result['memberList'], isA<List>());
        expect(result['memberList'].length, 1);
        expect(result['memberList'][0]['tag'], '#P1');
        expect(result['memberList'][0]['name'], 'Leader');
        expect(result['memberList'][0]['role'], 'leader');
        expect(result['memberList'][0]['expLevel'], 200);
        expect(result['memberList'][0]['trophies'], 5000);
      });

      test('serializes labels correctly', () {
        final clan = ClanModel.fromJson(fullJson);
        final result = clan.toJson();

        expect(result['labels'], isA<List>());
        expect(result['labels'].length, 1);
        expect(result['labels'][0]['id'], 1);
        expect(result['labels'][0]['name'], 'Clan Wars');
      });

      test('round-trip: fromJson -> toJson -> fromJson preserves data', () {
        final clan1 = ClanModel.fromJson(fullJson);
        final serialized = clan1.toJson();
        final clan2 = ClanModel.fromJson(serialized);

        expect(clan2.tag, clan1.tag);
        expect(clan2.name, clan1.name);
        expect(clan2.type, clan1.type);
        expect(clan2.description, clan1.description);
        expect(clan2.clanLevel, clan1.clanLevel);
        expect(clan2.clanPoints, clan1.clanPoints);
        expect(clan2.clanVersusPoints, clan1.clanVersusPoints);
        expect(clan2.requiredTrophies, clan1.requiredTrophies);
        expect(clan2.warFrequency, clan1.warFrequency);
        expect(clan2.warWinStreak, clan1.warWinStreak);
        expect(clan2.warWins, clan1.warWins);
        expect(clan2.warTies, clan1.warTies);
        expect(clan2.warLosses, clan1.warLosses);
        expect(clan2.isWarLogPublic, clan1.isWarLogPublic);
        expect(clan2.members, clan1.members);
        expect(clan2.location.id, clan1.location.id);
        expect(clan2.location.name, clan1.location.name);
        expect(clan2.badgeUrls.small, clan1.badgeUrls.small);
        expect(clan2.warLeague.id, clan1.warLeague.id);
        expect(clan2.warLeague.name, clan1.warLeague.name);
        expect(clan2.memberList.length, clan1.memberList.length);
        expect(clan2.labels.length, clan1.labels.length);
      });
    });
  });

  group('Location', () {
    test('fromJson and toJson', () {
      final json = {
        'id': 32000000,
        'name': 'International',
        'isCountry': false,
        'countryCode': '',
      };

      final location = Location.fromJson(json);
      expect(location.id, 32000000);
      expect(location.name, 'International');
      expect(location.isCountry, false);
      expect(location.countryCode, '');

      final result = location.toJson();
      expect(result['id'], 32000000);
      expect(result['name'], 'International');
      expect(result['isCountry'], false);
      expect(result['countryCode'], '');
    });
  });

  group('BadgeUrls (ClanModel)', () {
    test('fromJson and toJson', () {
      final json = {
        'small': 'https://s.png',
        'large': 'https://l.png',
        'medium': 'https://m.png',
      };

      final badge = BadgeUrls.fromJson(json);
      expect(badge.small, 'https://s.png');
      expect(badge.large, 'https://l.png');
      expect(badge.medium, 'https://m.png');

      final result = badge.toJson();
      expect(result['small'], 'https://s.png');
      expect(result['large'], 'https://l.png');
      expect(result['medium'], 'https://m.png');
    });
  });

  group('WarLeague', () {
    test('fromJson and toJson', () {
      final json = {'id': 29000000, 'name': 'Bronze League I'};
      final league = WarLeague.fromJson(json);
      expect(league.id, 29000000);
      expect(league.name, 'Bronze League I');

      final result = league.toJson();
      expect(result['id'], 29000000);
      expect(result['name'], 'Bronze League I');
    });
  });

  group('MemberList', () {
    test('fromJson parses correctly', () {
      final json = {
        'tag': '#MEMBER',
        'name': 'MemberName',
        'role': 'member',
        'expLevel': 100,
        'league': {
          'id': 29000015,
          'name': 'Crystal League I',
          'iconUrls': {
            'small': 'https://s.png',
            'tiny': 'https://t.png',
            'medium': 'https://m.png',
          }
        },
        'trophies': 3000,
        'versusTrophies': 2000,
        'clanRank': 10,
        'previousClanRank': 12,
        'donations': 500,
        'donationsReceived': 300,
      };

      final member = MemberList.fromJson(json);
      expect(member.tag, '#MEMBER');
      expect(member.name, 'MemberName');
      expect(member.role, 'member');
      expect(member.expLevel, 100);
      expect(member.trophies, 3000);
      expect(member.versusTrophies, 2000);
      expect(member.clanRank, 10);
      expect(member.previousClanRank, 12);
      expect(member.donations, 500);
      expect(member.donationsReceived, 300);
    });

    test('toJson serializes correctly', () {
      final json = {
        'tag': '#MEMBER',
        'name': 'MemberName',
        'role': 'member',
        'expLevel': 100,
        'league': {
          'id': 29000015,
          'name': 'Crystal League I',
          'iconUrls': {
            'small': 'https://s.png',
            'tiny': 'https://t.png',
            'medium': 'https://m.png',
          }
        },
        'trophies': 3000,
        'versusTrophies': 2000,
        'clanRank': 10,
        'previousClanRank': 12,
        'donations': 500,
        'donationsReceived': 300,
      };

      final member = MemberList.fromJson(json);
      final result = member.toJson();

      expect(result['tag'], '#MEMBER');
      expect(result['name'], 'MemberName');
      expect(result['role'], 'member');
      expect(result['expLevel'], 100);
      expect(result['trophies'], 3000);
      expect(result['league']['id'], 29000015);
      expect(result['league']['name'], 'Crystal League I');
    });
  });

  group('League (ClanModel)', () {
    test('fromJson and toJson', () {
      final json = {
        'id': 29000022,
        'name': 'Legend League',
        'iconUrls': {
          'small': 'https://s.png',
          'tiny': 'https://t.png',
          'medium': 'https://m.png',
        }
      };

      final league = League.fromJson(json);
      expect(league.id, 29000022);
      expect(league.name, 'Legend League');
      expect(league.iconUrls.small, 'https://s.png');
      expect(league.iconUrls.tiny, 'https://t.png');
      expect(league.iconUrls.medium, 'https://m.png');

      final result = league.toJson();
      expect(result['id'], 29000022);
      expect(result['name'], 'Legend League');
      expect(result['iconUrls']['small'], 'https://s.png');
    });
  });

  group('IconUrls (ClanModel)', () {
    test('fromJson and toJson', () {
      final json = {
        'small': 'https://s.png',
        'tiny': 'https://t.png',
        'medium': 'https://m.png',
      };

      final icon = IconUrls.fromJson(json);
      expect(icon.small, 'https://s.png');
      expect(icon.tiny, 'https://t.png');
      expect(icon.medium, 'https://m.png');

      final result = icon.toJson();
      expect(result['small'], 'https://s.png');
      expect(result['tiny'], 'https://t.png');
      expect(result['medium'], 'https://m.png');
    });
  });

  group('LabelIconUrls', () {
    test('fromJson and toJson', () {
      final json = {
        'small': 'https://s.png',
        'medium': 'https://m.png',
      };

      final icon = LabelIconUrls.fromJson(json);
      expect(icon.small, 'https://s.png');
      expect(icon.medium, 'https://m.png');

      final result = icon.toJson();
      expect(result['small'], 'https://s.png');
      expect(result['medium'], 'https://m.png');
    });
  });

  group('Label (ClanModel)', () {
    test('fromJson and toJson', () {
      final json = {
        'id': 1,
        'name': 'Clan Wars',
        'iconUrls': {
          'small': 'https://s.png',
          'medium': 'https://m.png',
        }
      };

      final label = Label.fromJson(json);
      expect(label.id, 1);
      expect(label.name, 'Clan Wars');
      expect(label.iconUrls.small, 'https://s.png');
      expect(label.iconUrls.medium, 'https://m.png');

      final result = label.toJson();
      expect(result['id'], 1);
      expect(result['name'], 'Clan Wars');
      expect(result['iconUrls']['small'], 'https://s.png');
      expect(result['iconUrls']['medium'], 'https://m.png');
    });
  });
}
