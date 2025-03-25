import 'dart:convert';

import 'package:crewmeister/core/util/period_calculator.dart';
import 'package:http/http.dart' as http;

import '/data/model/absence.dart';
import '/data/model/member.dart';
import '/data/model/member_absence.dart';
import '/data/provider/get_api.dart';

class AbsenceRepository {
  AbsenceRepository({required this.api});

  final GetApi api;

  Future<List<MemberAbsence>> getAbsences() async {
    // Load absences
    final http.Response absenceResponse = await api.getRawData(
      uri: 'absences.json',
    );
    final absenceData =
        jsonDecode(absenceResponse.body) as Map<String, dynamic>;
    final absences =
        (absenceData['payload'] as List)
            .map((e) => Absence.fromJson(e))
            .toList();

    // Load members
    final http.Response memberResponse = await api.getRawData(
      uri: 'members.json',
    );
    final memberData = jsonDecode(memberResponse.body) as Map<String, dynamic>;
    final members =
        (memberData['payload'] as List).map((e) => Member.fromJson(e)).toList();

    // Merge userId to member name in a map
    final memberMap = {for (var m in members) m.userId: m.name};

    // Merge data into MemberAbsence
    return absences.map((absence) {
      final memberName = memberMap[absence.userId] ?? 'Unknown';
      final period = calculatePeriod(absence.startDate, absence.endDate);
      final status =
          (absence.confirmedAt != null && absence.confirmedAt!.isNotEmpty)
              ? 'Confirmed'
              : (absence.rejectedAt != null && absence.rejectedAt!.isNotEmpty
                  ? 'Rejected'
                  : 'Requested');
      return MemberAbsence(
        id: absence.id,
        userId: absence.userId,
        memberName: memberName,
        type: absence.type,
        period: period,
        memberNote: absence.memberNote,
        status: status,
        admitterNote: absence.admitterNote,
      );
    }).toList();
  }
}
