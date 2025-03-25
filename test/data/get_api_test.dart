import 'dart:async';

import 'package:crewmeister/core/util/data_loader.dart';
import 'package:crewmeister/data/provider/get_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

class FakeDataLoader extends DataLoader {
  final String responseBody;
  final int statusCode;
  final bool throwTimeout;
  FakeDataLoader({
    required this.responseBody,
    required this.statusCode,
    this.throwTimeout = false,
  });

  @override
  Future<http.Response> load(Uri url) async {
    if (throwTimeout) {
      throw TimeoutException('Timeout');
    }
    return http.Response(responseBody, statusCode);
  }
}

void main() {
  group('GetApi', () {
    test('returns raw data -> when loader succeeds with status 200', () async {
      final fakeLoader = FakeDataLoader(
        responseBody: '{"payload": []}',
        statusCode: 200,
      );
      final api = GetApi(loader: fakeLoader);
      final response = await api.getRawData(uri: 'my.json');
      expect(response.statusCode, 200);
      expect(response.body, '{"payload": []}');
    });

    test(
      'returns error -> when loader returns status code is not between 200 and 399',
      () async {
        final fakeLoader = FakeDataLoader(
          responseBody: '{"error": "Error"}',
          statusCode: 500,
        );
        final api = GetApi(loader: fakeLoader);
        final response = await api.getRawData(uri: 'my.json');
        expect(response.statusCode, 500);
      },
    );

    test(
      'returns error response -> when loader for instance throws TimeoutException',
      () async {
        final fakeLoader = FakeDataLoader(
          responseBody: '{"error": "Timed out"}',
          statusCode: 500,
          throwTimeout: true,
        );
        final api = GetApi(loader: fakeLoader);
        final response = await api.getRawData(uri: 'my.json');
        expect(response.statusCode, 500);
        expect(response.body, '{"error": "Timed out"}');
      },
    );
  });
}
