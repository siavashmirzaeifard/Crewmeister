import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/model/member_absence.dart';
import '/data/repository/absence_repository.dart';
import 'absence_event.dart';
import 'absence_state.dart';

/// AbsenceBloc is responsible for loading, filtering, and paginating absence data.
class AbsenceBloc extends Bloc<AbsenceEvent, AbsenceState> {
  final AbsenceRepository repository;
  final int itemsPerPage;

  // Constructor initializes the bloc with an initial state plus items per page
  //  that set to 10 as requested in challenge and sets up the event handler.
  AbsenceBloc({required this.repository, this.itemsPerPage = 10})
    : super(AbsenceInitial()) {
    // Handle the LoadAbsences event.
    on<LoadAbsences>((event, emit) async {
      emit(const AbsenceLoading());
      try {
        // Fetch all absence details from the repository.
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

        // As I used LazyLists by default which is growable, I borrowed this logic from
        //  my wife (she is a web developer) and knows this logic better than me :)

        // Determine the total number of filtered absences.
        final total = filtered.length;
        // Calculate the start and end indices for pagination.
        final startIndex = (event.page - 1) * itemsPerPage;
        final endIndex =
            startIndex + itemsPerPage > total
                ? total
                : startIndex + itemsPerPage;
        // Get the absence details for the current page.
        final pageDetails = filtered.sublist(startIndex, endIndex);

        // Emit the success state with the paginated data, current page, and total count.
        emit(
          AbsenceSuccess(response: pageDetails, page: event.page, total: total),
        );
      } catch (e) {
        // Emit a failure state if an error occurs or something was wrong.
        emit(AbsenceFailure(message: e.toString()));
      }
    });
  }
}
