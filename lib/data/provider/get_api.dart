import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import '/core/util/data_loader.dart';

/// GetApi should be a generic Get method that gets us the raw data with proper error handling, and then we
///  use and convert it into desired model in repository layer.
//  but for this challenge I just try to simulate a HTTP request.
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
