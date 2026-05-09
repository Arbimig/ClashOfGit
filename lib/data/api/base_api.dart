import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:clashofclans/config/api_config.dart';

class BaseApi {
  Future<dynamic> get(String endpoint) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      final res = await http.get(uri, headers: ApiConfig.headers)
          .timeout(const Duration(seconds: 10));

      if (res.statusCode == 200) {
        return json.decode(res.body);
      } else {
        log('API error: ${res.statusCode} - ${res.body}');
        throw ApiException('Error response ${res.statusCode}', res.statusCode);
      }
    } on SocketException {
      log('API: No internet connection');
      throw ApiException('No internet connection. Please check your network.');
    } on TimeoutException {
      log('API: Request timed out');
      throw ApiException('Request timed out. Please try again.');
    } on FormatException {
      log('API: Invalid response format');
      throw ApiException('Invalid response from server.');
    } catch (e) {
      if (e is ApiException) rethrow;
      log('API request failed: $e');
      throw ApiException('An unexpected error occurred: $e');
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message';
}
