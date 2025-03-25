import 'package:equatable/equatable.dart';

abstract class AbsenceEvent extends Equatable {
  const AbsenceEvent();

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class LoadAbsences extends AbsenceEvent {
  const LoadAbsences({required this.page, this.filterType, this.filterDate});

  final int page;
  final String? filterType;
  final DateTime? filterDate;

  @override
  List<Object?> get props => [page, filterType, filterDate];
}
