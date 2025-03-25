import 'dart:convert';

import 'package:http/http.dart' as http;

import '/data/model/absence.dart';
import '/data/provider/get_api.dart';

class AbsenceRepository {
  AbsenceRepository({required this.api});

  final GetApi api;

  Future<List<Absence>> getAbsences() async {
    final http.Response response = await api.getRawData(uri: 'absences.json');
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final payload = data['payload'] as List;
    return payload.map((e) => Absence.fromJson(e)).toList();
  }
}
