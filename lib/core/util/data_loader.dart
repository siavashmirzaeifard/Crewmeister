import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class DataLoader {
  Future<http.Response> load(Uri url) async {
    final path = url.toString();
    final content = await rootBundle.loadString('assets/$path');
    return http.Response(content, 200);
  }
}
