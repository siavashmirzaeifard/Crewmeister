import 'package:bloc_test/bloc_test.dart';
import 'package:crewmeister/logic/member/member_bloc.dart';
import 'package:crewmeister/logic/member/member_event.dart';
import 'package:crewmeister/logic/member/member_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fake_repository.dart';

void main() {
  group('MemberBloc Tests', () {
    group('Success Cases', () {
      late MemberBloc memberBloc;
      late FakeMemberRepository repository;

      setUp(() {
        repository = FakeMemberRepository();
        memberBloc = MemberBloc(repository: repository);
      });

      blocTest<MemberBloc, MemberState>(
        'emits MemberLoading state + MemberSuccess state -> when LoadMembers is added',
        build: () => memberBloc,
        act: (bloc) => bloc.add(LoadMembers()),
        expect: () => [isA<MemberLoading>(), isA<MemberSuccess>()],
      );
    });

    group('Error Handling', () {
      late MemberBloc memberBloc;
      late ErrorMemberRepository repository;

      setUp(() {
        repository = ErrorMemberRepository();
        memberBloc = MemberBloc(repository: repository);
      });

      blocTest<MemberBloc, MemberState>(
        'emits MemberLoading state + MemberFailure state -> when repository throws exception',
        build: () => memberBloc,
        act: (bloc) => bloc.add(LoadMembers()),
        expect: () => [isA<MemberLoading>(), isA<MemberFailure>()],
      );
    });

    group('Empty Data', () {
      late MemberBloc memberBloc;
      late EmptyMemberRepository repository;

      setUp(() {
        repository = EmptyMemberRepository();
        memberBloc = MemberBloc(repository: repository);
      });

      blocTest<MemberBloc, MemberState>(
        'emits MemberLoading state plus MemberSuccess state -> with empty list when no members found',
        build: () => memberBloc,
        act: (bloc) => bloc.add(LoadMembers()),
        expect:
            () => [
              isA<MemberLoading>(),
              predicate(
                (state) => state is MemberSuccess && state.response.isEmpty,
              ),
            ],
      );
    });
  });
}
