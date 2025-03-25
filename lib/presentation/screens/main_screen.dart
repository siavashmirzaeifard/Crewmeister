import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/logic/absence/absence_bloc.dart';
import '/logic/absence/absence_event.dart';
import '/logic/absence/absence_state.dart';
import '/presentation/widgets/absence_list_widget.dart';
import '/presentation/widgets/filter_controls.dart';
import '/presentation/widgets/pagination_controls.dart';

/// MainScreen is the primary UI that displays absence data with filtering and pagination.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? filterType; // Selected filter type
  DateTime? filterDate; // Selected filter date
  int currentPage = 1; // Current page for pagination
  static const itemsPerPage = 10;

  // Triggers the AbsenceBloc to load data using the current filter settings and page.
  void loadData() {
    context.read<AbsenceBloc>().add(
      LoadAbsences(
        page: currentPage,
        filterType: filterType,
        filterDate: filterDate,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Load data when the widget is first built.
    loadData();
  }

  // Called when filter values change. Resets the page and reloads the data.
  void onFilterChanged({String? type, DateTime? date}) {
    setState(() {
      filterType = type;
      filterDate = date;
      currentPage = 1;
    });
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Absence Manager')),
      body: SafeArea(
        child: Column(
          children: [
            FilterControls(
              filterType: filterType,
              filterDate: filterDate,
              onFilterChanged: onFilterChanged,
            ),

            // Main area that displays the absence list or relevant state messages.
            Expanded(
              child: BlocBuilder<AbsenceBloc, AbsenceState>(
                builder: (context, state) {
                  if (state is AbsenceLoading) {
                    // Show a loading indicator while data is being fetched.
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AbsenceFailure) {
                    // Display an error message if data loading fails.
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is AbsenceSuccess) {
                    // If the list is empty, show a message.
                    if (state.response.isEmpty) {
                      return const Center(child: Text('No absences found'));
                    }

                    // In case none of above, display the list of absences.
                    return AbsenceListWidget(
                      total: state.total,
                      absences: state.response,
                    );
                  }

                  // Fallback container in case of an unexpected state.
                  return Container();
                },
              ),
            ),
            BlocBuilder<AbsenceBloc, AbsenceState>(
              builder: (context, state) {
                int total = 0;
                if (state is AbsenceSuccess) {
                  total = state.total;
                }
                return PaginationControls(
                  currentPage: currentPage,
                  total: total,
                  itemsPerPage: itemsPerPage,
                  onPrevious: () {
                    if (currentPage > 1) {
                      setState(() {
                        currentPage--;
                      });
                      loadData();
                    }
                  },
                  onNext: () {
                    // Calculate the last page based on total items and items per page.
                    final lastPage = (total + itemsPerPage - 1) ~/ itemsPerPage;
                    if (currentPage < lastPage) {
                      setState(() {
                        currentPage++;
                      });
                      loadData();
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
