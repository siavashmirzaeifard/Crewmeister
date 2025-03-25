import 'package:crewmeister/data/model/member_absence.dart';
import 'package:equatable/equatable.dart';

abstract class AbsenceState extends Equatable {
  const AbsenceState();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class AbsenceInitial extends AbsenceState {
  const AbsenceInitial();
}

class AbsenceLoading extends AbsenceState {
  const AbsenceLoading();
}

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

class AbsenceFailure extends AbsenceState {
  const AbsenceFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
