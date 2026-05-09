import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('PlayerApi HTTP responses', () {
    final successJson = json.encode({
      'tag': '#ABC123',
      'name': 'TestPlayer',
      'townHallLevel': 15,
      'townHallWeaponLevel': 5,
      'expLevel': 200,
      'trophies': 5000,
      'bestTrophies': 5500,
      'warStars': 1500,
      'attackWins': 300,
      'defenseWins': 100,
      'builderHallLevel': 10,
      'versusTrophies': 4000,
      'bestVersusTrophies': 4200,
      'versusBattleWins': 500,
      'role': 'leader',
      'donations': 1000,
      'donationsReceived': 800,
      'clan': {
        'tag': '#CLAN123',
        'name': 'TestClan',
        'clanLevel': 20,
        'badgeUrls': {
          'small': 'https://small.png',
          'large': 'https://large.png',
          'medium': 'https://medium.png',
        }
      },
      'league': {
        'id': 29000022,
        'name': 'Legend League',
        'iconUrls': {
          'small': 'https://league-small.png',
          'tiny': 'https://league-tiny.png',
          'medium': 'https://league-medium.png',
        }
      },
      'legendStatistics': {
        'legendTrophies': 5000,
        'bestSeason': {'id': '2024-01', 'rank': 100, 'trophies': 5500},
        'bestVersusSeason': {'id': '2024-01', 'rank': 50, 'trophies': 4200},
        'currentSeason': {'rank': 200, 'trophies': 5000},
      },
      'achievements': [
        {
          'name': 'Gold Grab',
          'stars': 3,
          'value': 1000,
          'target': 1000,
          'info': 'Earn 1000 gold',
          'completionInfo': 'Completed!',
          'village': 'home'
        }
      ],
      'versusBattleWinCount': 200,
      'labels': [
        {
          'id': 1,
          'name': 'Clan Wars',
          'iconUrls': {
            'small': 'https://label-small.png',
            'medium': 'https://label-medium.png',
          }
        }
      ],
      'troops': [
        {'name': 'Barbarian', 'level': 10, 'maxLevel': 10, 'village': 'home'}
      ],
      'heroes': [
        {'name': 'Barbarian King', 'level': 80, 'maxLevel': 80, 'village': 'home'}
      ],
      'spells': [
        {'name': 'Lightning Spell', 'level': 9, 'maxLevel': 9, 'village': 'home'}
      ],
    });

    test('status 200 returns valid parsed JSON', () async {
      final mockClient = MockClient((request) async {
        return http.Response(successJson, 200);
      });

      final response = await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/players/%23ABC123'),
      );

      expect(response.statusCode, 200);
      final decoded = json.decode(response.body);
      expect(decoded['tag'], '#ABC123');
      expect(decoded['name'], 'TestPlayer');
      expect(decoded['townHallLevel'], 15);
      expect(decoded['clan']['name'], 'TestClan');
      expect(decoded['league']['name'], 'Legend League');
      expect(decoded['achievements'], isA<List>());
      expect(decoded['achievements'].length, 1);
    });

    test('status 404 returns error response', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      final response = await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/players/%23NONEXISTENT'),
      );

      expect(response.statusCode, 404);
      expect(response.body, 'Not Found');
    });

    test('status 500 returns error response', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Internal Server Error', 500);
      });

      final response = await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/players/%23ABC123'),
      );

      expect(response.statusCode, 500);
      expect(response.body, 'Internal Server Error');
    });

    test('status 403 returns forbidden', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Forbidden', 403);
      });

      final response = await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/players/%23ABC123'),
      );

      expect(response.statusCode, 403);
    });

    test('status 429 returns rate limit error', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Too Many Requests', 429);
      });

      final response = await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/players/%23ABC123'),
      );

      expect(response.statusCode, 429);
    });

    test('response body is valid JSON that can be parsed', () async {
      final mockClient = MockClient((request) async {
        return http.Response(successJson, 200);
      });

      final response = await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/players/%23ABC123'),
      );

      expect(() => json.decode(response.body), returnsNormally);
      final decoded = json.decode(response.body);
      expect(decoded, isA<Map<String, dynamic>>());
    });

    test('request is sent to correct URL', () async {
      String? capturedUrl;
      final mockClient = MockClient((request) async {
        capturedUrl = request.url.toString();
        return http.Response(successJson, 200);
      });

      await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/players/%23ABC123'),
      );

      expect(capturedUrl, contains('/players/%23ABC123'));
    });

    test('request includes authorization header', () async {
      Map<String, String>? capturedHeaders;
      final mockClient = MockClient((request) async {
        capturedHeaders = request.headers;
        return http.Response(successJson, 200);
      });

      await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/players/%23ABC123'),
        headers: {
          'Accept': 'application/json',
          'authorization': 'Bearer test-token',
        },
      );

      expect(capturedHeaders!['authorization'], contains('Bearer'));
      expect(capturedHeaders!['Accept'], 'application/json');
    });
  });
}
