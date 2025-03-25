import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import '/core/util/data_loader.dart';

class GetApi {
  const GetApi({required this.loader});

  final DataLoader loader;

  Future<http.Response> getRawData({required String uri}) async {
    final url = Uri.parse(uri);
    await Future.delayed(const Duration(seconds: 1));
    try {
      return await loader.load(url);
    } on TimeoutException {
      return http.Response('{"error": "Timed out"}', 500);
    } on SocketException {
      return http.Response('{"error": "No Internet"}', 500);
    } on HttpException {
      return http.Response('{"error": "No Service Found"}', 500);
    } on FormatException {
      return http.Response('{"error": "Invalid Data Format"}', 500);
    } catch (e) {
      return http.Response('{"error": "${e.toString()}"}', 500);
    }
  }
}
