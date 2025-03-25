import 'package:crewmeister/core/util/data_loader.dart';
import 'package:crewmeister/data/model/absence.dart';
import 'package:crewmeister/data/model/member.dart';
import 'package:crewmeister/data/provider/get_api.dart';
import 'package:crewmeister/data/repository/absence_repository.dart';
import 'package:crewmeister/data/repository/member_repository.dart';

class DummyDataLoader extends DataLoader {}

final dummyApi = GetApi(loader: DummyDataLoader());

// Absence fake repos
class FakeAbsenceRepository extends AbsenceRepository {
  FakeAbsenceRepository() : super(api: dummyApi);

  @override
  Future<List<Absence>> getAbsences() async {
    return [
      Absence(
        id: 1,
        userId: 123,
        type: 'vacation',
        startDate: '2025-03-25',
        endDate: '2025-03-26',
        createdAt: '2025-03-01T00:00:00',
        confirmedAt: '2025-03-01T00:00:01',
        rejectedAt: null,
        crewId: 1,
        memberNote: 'some notes here ;)',
        admitterId: null,
        admitterNote: '',
      ),
    ];
  }
}

class ErrorAbsenceRepository extends FakeAbsenceRepository {
  @override
  Future<List<Absence>> getAbsences() async {
    throw Exception('Absence Error');
  }
}

class EmptyAbsenceRepository extends FakeAbsenceRepository {
  @override
  Future<List<Absence>> getAbsences() async {
    return [];
  }
}

// Member fake repos
class FakeMemberRepository extends MemberRepository {
  FakeMemberRepository() : super(api: dummyApi);

  @override
  Future<List<Member>> getMembers() async {
    return [
      Member(
        id: 1,
        userId: 123,
        crewId: 1,
        name: 'Siavash Mirzaei-Fard',
        image: 'my-photo.jpg ;)',
      ),
    ];
  }
}

class ErrorMemberRepository extends FakeMemberRepository {
  @override
  Future<List<Member>> getMembers() async {
    throw Exception('Member Error');
  }
}

class EmptyMemberRepository extends FakeMemberRepository {
  @override
  Future<List<Member>> getMembers() async {
    return [];
  }
}
