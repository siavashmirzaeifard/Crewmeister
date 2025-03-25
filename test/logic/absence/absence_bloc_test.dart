import 'package:bloc_test/bloc_test.dart';
import 'package:crewmeister/logic/absence/absence_bloc.dart';
import 'package:crewmeister/logic/absence/absence_event.dart';
import 'package:crewmeister/logic/absence/absence_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fake_repository.dart';

void main() {
  group('AbsenceBloc Tests', () {
    group('Success Cases', () {
      late AbsenceBloc absenceBloc;
      late FakeAbsenceRepository repository;

      setUp(() {
        repository = FakeAbsenceRepository();
        absenceBloc = AbsenceBloc(repository: repository);
      });

      blocTest<AbsenceBloc, AbsenceState>(
        'emits AbsenceLoading state + AbsenceSuccess state -> when LoadAbsences is added',
        build: () => absenceBloc,
        act:
            (bloc) => bloc.add(
              LoadAbsences(page: 1, filterType: null, filterDate: null),
            ),
        expect: () => [isA<AbsenceLoading>(), isA<AbsenceSuccess>()],
      );
    });

    group('Error Handling', () {
      late AbsenceBloc absenceBloc;
      late ErrorAbsenceRepository repository;

      setUp(() {
        repository = ErrorAbsenceRepository();
        absenceBloc = AbsenceBloc(repository: repository);
      });

      blocTest<AbsenceBloc, AbsenceState>(
        'emits AbsenceLoading state + AbsenceFailure state -> when repository throws exception',
        build: () => absenceBloc,
        act:
            (bloc) => bloc.add(
              LoadAbsences(page: 1, filterType: null, filterDate: null),
            ),
        expect: () => [isA<AbsenceLoading>(), isA<AbsenceFailure>()],
      );
    });

    group('Empty List', () {
      late AbsenceBloc absenceBloc;
      late EmptyAbsenceRepository repository;

      setUp(() {
        repository = EmptyAbsenceRepository();
        absenceBloc = AbsenceBloc(repository: repository);
      });

      blocTest<AbsenceBloc, AbsenceState>(
        'emits AbsenceLoading state + AbsenceLoaded state -> with empty list when no absence found',
        build: () => absenceBloc,
        act:
            (bloc) => bloc.add(
              LoadAbsences(page: 1, filterType: null, filterDate: null),
            ),
        expect:
            () => [
              isA<AbsenceLoading>(),
              predicate(
                (state) => state is AbsenceSuccess && state.response.isEmpty,
              ),
            ],
      );
    });
  });
}
