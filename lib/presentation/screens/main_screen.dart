import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/logic/absence/absence_bloc.dart';
import '/logic/absence/absence_event.dart';
import '/logic/absence/absence_state.dart';
import '/presentation/widgets/absence_list_widget.dart';
import '/presentation/widgets/filter_controls.dart';
import '/presentation/widgets/pagination_controls.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? filterType;
  DateTime? filterDate;
  int currentPage = 1;
  static const itemsPerPage = 10;

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
    loadData();
  }

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
      body: Column(
        children: [
          FilterControls(
            filterType: filterType,
            filterDate: filterDate,
            onFilterChanged: onFilterChanged,
          ),
          Expanded(
            child: BlocBuilder<AbsenceBloc, AbsenceState>(
              builder: (context, state) {
                if (state is AbsenceLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AbsenceFailure) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is AbsenceSuccess) {
                  if (state.response.isEmpty) {
                    return const Center(child: Text('No absences found'));
                  }
                  return AbsenceListWidget(
                    total: state.total,
                    absences: state.response,
                  );
                }
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
    );
  }
}
