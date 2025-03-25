import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/repository/absence_repository.dart';
import 'absence_event.dart';
import 'absence_state.dart';

class AbsenceBloc extends Bloc<AbsenceEvent, AbsenceState> {
  final AbsenceRepository repository;
  AbsenceBloc({required this.repository}) : super(AbsenceInitial()) {
    on<LoadAbsences>((event, emit) async {
      emit(AbsenceLoading());
      try {
        final absences = await repository.getAbsences();
        emit(AbsenceSuccess(response: absences));
      } catch (e) {
        emit(AbsenceFailure(message: e.toString()));
      }
    });
  }
}
