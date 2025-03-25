import 'package:equatable/equatable.dart';

import '/data/model/member_absence.dart';

/// Base class for all absence states. I used Equatable for easier comparisons.
abstract class AbsenceState extends Equatable {
  const AbsenceState();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

// The initial state of the AbsenceBloc.
class AbsenceInitial extends AbsenceState {
  const AbsenceInitial();
}

// Loading state of the AbsenceBloc.
class AbsenceLoading extends AbsenceState {
  const AbsenceLoading();
}

// Successful state of the AbsenceBloc where absence data has been loaded and
//  contains the list of absences, the current page, and the total count.
class AbsenceSuccess extends AbsenceState {
  const AbsenceSuccess({
    required this.response,
    required this.page,
    required this.total,
  });

  final List<MemberAbsence> response;
  final int page, total;

  @override
  List<Object?> get props => [response, page, total];
}

// Failure state of the AbsenceBloc with an error message.
class AbsenceFailure extends AbsenceState {
  const AbsenceFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
