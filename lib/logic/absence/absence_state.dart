import 'package:equatable/equatable.dart';

import '/data/model/absence.dart';

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
  const AbsenceSuccess({required this.response});

  final List<Absence> response;

  @override
  List<Object?> get props => [response];
}

class AbsenceFailure extends AbsenceState {
  const AbsenceFailure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
