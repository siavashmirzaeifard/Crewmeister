import 'package:crewmeister/core/util/data_loader.dart';
import 'package:crewmeister/data/model/member_absence.dart';
import 'package:crewmeister/data/provider/get_api.dart';
import 'package:crewmeister/data/repository/absence_repository.dart';

class DummyDataLoader extends DataLoader {}

final dummyApi = GetApi(loader: DummyDataLoader());

class FakeAbsenceRepository extends AbsenceRepository {
  FakeAbsenceRepository() : super(api: dummyApi);

  @override
  Future<List<MemberAbsence>> getAbsences() async {
    return [
      MemberAbsence(
        id: 1,
        userId: 123,
        memberName: 'Siavash Miryaei-Fard',
        type: 'vacation',
        period: '2025-03-25 - 2025-03-26',
        memberNote: 'some notes here ;)',
        status: 'Confirmed',
        admitterNote: '',
      ),
    ];
  }
}

class ErrorAbsenceRepository extends FakeAbsenceRepository {
  @override
  Future<List<MemberAbsence>> getAbsences() async {
    throw Exception('Absence Error');
  }
}

class EmptyAbsenceRepository extends FakeAbsenceRepository {
  @override
  Future<List<MemberAbsence>> getAbsences() async {
    return [];
  }
}
