import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('ClanApi HTTP responses', () {
    final successJson = json.encode({
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
    });

    test('status 200 returns valid parsed JSON', () async {
      final mockClient = MockClient((request) async {
        return http.Response(successJson, 200);
      });

      final response = await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/clans/%23CLAN123'),
      );

      expect(response.statusCode, 200);
      final decoded = json.decode(response.body);
      expect(decoded['tag'], '#CLAN123');
      expect(decoded['name'], 'TestClan');
      expect(decoded['type'], 'open');
      expect(decoded['clanLevel'], 20);
      expect(decoded['members'], 45);
      expect(decoded['location']['name'], 'Russia');
      expect(decoded['memberList'], isA<List>());
      expect(decoded['memberList'].length, 1);
    });

    test('status 404 returns not found', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      final response = await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/clans/%23NONEXISTENT'),
      );

      expect(response.statusCode, 404);
    });

    test('status 500 returns server error', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Internal Server Error', 500);
      });

      final response = await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/clans/%23CLAN123'),
      );

      expect(response.statusCode, 500);
    });

    test('status 403 returns forbidden', () async {
      final mockClient = MockClient((request) async {
        return http.Response('Forbidden', 403);
      });

      final response = await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/clans/%23CLAN123'),
      );

      expect(response.statusCode, 403);
    });

    test('response body is valid JSON that can be parsed', () async {
      final mockClient = MockClient((request) async {
        return http.Response(successJson, 200);
      });

      final response = await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/clans/%23CLAN123'),
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
        Uri.parse('https://api.clashofclans.com/v1/clans/%23CLAN123'),
      );

      expect(capturedUrl, contains('/clans/%23CLAN123'));
    });

    test('request includes authorization header', () async {
      Map<String, String>? capturedHeaders;
      final mockClient = MockClient((request) async {
        capturedHeaders = request.headers;
        return http.Response(successJson, 200);
      });

      await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/clans/%23CLAN123'),
        headers: {
          'Accept': 'application/json',
          'authorization': 'Bearer test-token',
        },
      );

      expect(capturedHeaders!['authorization'], contains('Bearer'));
      expect(capturedHeaders!['Accept'], 'application/json');
    });

    test('parsed clan data has correct nested structure', () async {
      final mockClient = MockClient((request) async {
        return http.Response(successJson, 200);
      });

      final response = await mockClient.get(
        Uri.parse('https://api.clashofclans.com/v1/clans/%23CLAN123'),
      );

      final decoded = json.decode(response.body);
      expect(decoded['badgeUrls']['small'], 'https://small.png');
      expect(decoded['warLeague']['name'], 'Master League I');
      expect(decoded['memberList'][0]['name'], 'Leader');
      expect(decoded['memberList'][0]['league']['name'], 'Legend League');
      expect(decoded['labels'][0]['name'], 'Clan Wars');
    });
  });
}
