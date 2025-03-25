import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

/// DataLoader class is responsible for loading data from assets as if it was an HTTP response.
class DataLoader {
  // Loads the content from the given asset (somehow I wanted to simulate a HTTP request).
  Future<http.Response> load(Uri url) async {
    final path = url.toString();
    final content = await rootBundle.loadString('assets/$path');
    return http.Response(content, 200);
  }
}
