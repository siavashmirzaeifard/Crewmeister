import 'package:crewmeister/logic/absence/absence_bloc.dart';
import 'package:crewmeister/logic/absence/absence_event.dart';
import 'package:crewmeister/logic/absence/absence_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? filterType;
  DateTime? filterDate;
  int currentPage = 1;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Absence Manager')),
      body: Column(
        children: [
          // Filtering controls
          Row(
            children: [
              DropdownButton<String>(
                hint: const Text('Filter Type'),
                value: filterType,
                items:
                    ['sickness', 'vacation']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    filterType = value;
                    currentPage = 1;
                  });
                  loadData();
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: filterDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    setState(() {
                      filterDate = picked;
                      currentPage = 1;
                    });
                    loadData();
                  }
                },
                child: const Text('Filter Date'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    filterType = null;
                    filterDate = null;
                    currentPage = 1;
                  });
                  loadData();
                },
                child: const Text('Clear Filters'),
              ),
            ],
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
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Total Absences: ${state.total}'),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.response.length,
                          itemBuilder: (context, index) {
                            final detail = state.response[index];
                            return ListTile(
                              title: Text(detail.memberName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Type: ${detail.type}'),
                                  Text('Period: ${detail.period}'),
                                  if (detail.memberNote.isNotEmpty)
                                    Text('Member Note: ${detail.memberNote}'),
                                  Text('Status: ${detail.status}'),
                                  if (detail.admitterNote.isNotEmpty)
                                    Text(
                                      'Admitter Note: ${detail.admitterNote}',
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
          // Pagination controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed:
                    currentPage > 1
                        ? () {
                          setState(() {
                            currentPage--;
                          });
                          loadData();
                        }
                        : null,
                child: const Text('Previous'),
              ),
              Text('Page $currentPage'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentPage++;
                  });
                  loadData();
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
