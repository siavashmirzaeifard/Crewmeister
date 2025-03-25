import 'dart:convert';

import 'package:http/http.dart' as http;

import '/data/model/member.dart';
import '/data/provider/get_api.dart';

class MemberRepository {
  MemberRepository({required this.api});

  final GetApi api;

  Future<List<Member>> getMembers() async {
    final http.Response response = await api.getRawData(uri: 'members.json');
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final payload = data['payload'] as List;
    return payload.map((e) => Member.fromJson(e)).toList();
  }
}
