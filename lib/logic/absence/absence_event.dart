import 'package:equatable/equatable.dart';

/// Base class for all absence events. I used Equatable for easier comparisons.
abstract class AbsenceEvent extends Equatable {
  const AbsenceEvent();

  // List of properties to use for equality checks.
  @override
  List<Object?> get props => [];

  // This one enables string representation for debugging.
  @override
  bool? get stringify => true;
}

// Event to load absences, with support for pagination and optional filtering.
class LoadAbsences extends AbsenceEvent {
  const LoadAbsences({required this.page, this.filterType, this.filterDate});

  final int page; // Current page number for pagination.
  final String? filterType; // Optional filter for absence types.
  final DateTime? filterDate; // Optional filter for a specific date.

  // Include above properties in equality checks.
  @override
  List<Object?> get props => [page, filterType, filterDate];
}
