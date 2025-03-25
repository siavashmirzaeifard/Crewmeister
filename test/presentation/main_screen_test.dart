import 'package:crewmeister/data/model/member_absence.dart';
import 'package:crewmeister/data/provider/get_api.dart';
import 'package:crewmeister/data/repository/absence_repository.dart';
import 'package:crewmeister/logic/absence/absence_bloc.dart';
import 'package:crewmeister/logic/absence/absence_event.dart';
import 'package:crewmeister/logic/absence/absence_state.dart';
import 'package:crewmeister/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class _DummyAbsenceRepository implements AbsenceRepository {
  @override
  Future<List<MemberAbsence>> getAbsences() async {
    throw UnimplementedError();
  }

  @override
  GetApi get api {
    throw UnimplementedError();
  }
}

class FakeAbsenceBloc extends Cubit<AbsenceState> implements AbsenceBloc {
  final AbsenceRepository _repository;

  FakeAbsenceBloc(super.initialState, {AbsenceRepository? repository})
    : _repository = repository ?? _DummyAbsenceRepository();

  @override
  AbsenceRepository get repository => _repository;

  @override
  int get itemsPerPage => 10;

  @override
  void add(AbsenceEvent event) {}

  @override
  void onEvent(AbsenceEvent event) {}

  @override
  void onTransition(Transition<AbsenceEvent, AbsenceState> transition) {}

  @override
  void onError(Object error, StackTrace stackTrace) {}

  @override
  void on<E extends AbsenceEvent>(
    void Function(E event, Emitter<AbsenceState> emit) handler, {
    EventTransformer<E>? transformer,
  }) {}
}

void main() {
  group('MainScreen Widget Tests', () {
    testWidgets('displays loading indicator', (WidgetTester tester) async {
      final fakeBloc = FakeAbsenceBloc(const AbsenceLoading());
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AbsenceBloc>.value(
            value: fakeBloc,
            child: const MainScreen(),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays error message', (WidgetTester tester) async {
      final fakeBloc = FakeAbsenceBloc(
        const AbsenceFailure(message: 'Test error'),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AbsenceBloc>.value(
            value: fakeBloc,
            child: const MainScreen(),
          ),
        ),
      );
      expect(find.text('Error: Test error'), findsOneWidget);
    });

    testWidgets('displays --No absences found-- text', (
      WidgetTester tester,
    ) async {
      final fakeBloc = FakeAbsenceBloc(
        const AbsenceSuccess(response: [], page: 1, total: 0),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AbsenceBloc>.value(
            value: fakeBloc,
            child: const MainScreen(),
          ),
        ),
      );
      expect(find.text('No absences found'), findsOneWidget);
    });

    testWidgets('displays list of absences and pagination', (
      WidgetTester tester,
    ) async {
      final absences = [
        MemberAbsence(
          id: 1,
          userId: 123,
          memberName: 'Siavash Mirzaei-Fard',
          type: 'vacation',
          period: '2025-03-25 - 2025-03-26',
          memberNote: 'On holiday',
          status: 'Confirmed',
          admitterNote: '',
        ),
        MemberAbsence(
          id: 2,
          userId: 456,
          memberName: 'Mirzaei-Fard Siavash',
          type: 'sickness',
          period: '2025-04-01 - 2025-04-03',
          memberNote: '',
          status: 'Requested',
          admitterNote: 'Provide certificate',
        ),
      ];
      final fakeBloc = FakeAbsenceBloc(
        AbsenceSuccess(response: absences, page: 1, total: absences.length),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AbsenceBloc>.value(
            value: fakeBloc,
            child: const MainScreen(),
          ),
        ),
      );
      expect(find.text('Siavash Mirzaei-Fard'), findsOneWidget);
      expect(find.text('Mirzaei-Fard Siavash'), findsOneWidget);
      expect(find.text('Total Absences: ${absences.length}'), findsOneWidget);
      expect(find.textContaining('Page'), findsOneWidget);
      expect(find.text('Previous'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    });
  });
}
