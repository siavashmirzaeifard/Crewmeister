import 'package:crewmeister/data/model/member_absence.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/repository/absence_repository.dart';
import 'absence_event.dart';
import 'absence_state.dart';

class AbsenceBloc extends Bloc<AbsenceEvent, AbsenceState> {
  final AbsenceRepository repository;
  final int itemsPerPage;

  AbsenceBloc({required this.repository, this.itemsPerPage = 10})
    : super(AbsenceInitial()) {
    on<LoadAbsences>((event, emit) async {
      emit(const AbsenceLoading());
      try {
        final allDetails = await repository.getAbsences();

        // Filter by type
        List<MemberAbsence> filtered = allDetails;
        if (event.filterType != null) {
          filtered =
              filtered
                  .where(
                    (detail) =>
                        detail.type.toLowerCase() ==
                        event.filterType!.toLowerCase(),
                  )
                  .toList();
        }
        // Filter by date
        if (event.filterDate != null) {
          filtered =
              filtered.where((detail) {
                final parts = detail.period.split(' - ');
                if (parts.length != 2) return false;
                final start = DateTime.tryParse(parts[0]);
                final end = DateTime.tryParse(parts[1]);
                if (start == null || end == null) return false;
                return event.filterDate!.isAfter(
                      start.subtract(const Duration(days: 1)),
                    ) &&
                    event.filterDate!.isBefore(
                      end.add(const Duration(days: 1)),
                    );
              }).toList();
        }

        final total = filtered.length;
        final startIndex = (event.page - 1) * itemsPerPage;
        final endIndex =
            startIndex + itemsPerPage > total
                ? total
                : startIndex + itemsPerPage;
        final pageDetails = filtered.sublist(startIndex, endIndex);
        emit(
          AbsenceSuccess(response: pageDetails, page: event.page, total: total),
        );
      } catch (e) {
        emit(AbsenceFailure(message: e.toString()));
      }
    });
  }
}
