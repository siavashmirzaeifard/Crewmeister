import 'package:flutter/material.dart';

import '/data/model/member_absence.dart';

/// Widget that displays a list of absences and the total count.
class AbsenceListWidget extends StatelessWidget {
  const AbsenceListWidget({
    super.key,
    required this.total,
    required this.absences,
  }) : response = absences;

  final List<MemberAbsence> absences; // List of absence details.
  final int total; // Total number of absences.
  final List<MemberAbsence> response;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Total number of absences.
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Total Absences: $total'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: absences.length,
            itemBuilder: (context, index) {
              final detail = absences[index];
              return ListTile(
                // Member's name
                title: Text(
                  detail.memberName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Type of absence
                    Text('Type: ${detail.type}'),
                    // Duration of the absence
                    Text('Period: ${detail.period}'),
                    // If available, show the member note.
                    if (detail.memberNote.isNotEmpty)
                      Text('Member Note: ${detail.memberNote}'),
                    // Status of the absence
                    Text(
                      'Status: ${detail.status}',
                      style: TextStyle(
                        color:
                            detail.status.toLowerCase() == 'confirmed'
                                ? Colors.green
                                : detail.status.toLowerCase() == 'rejected'
                                ? Colors.red
                                : Colors.black,
                      ),
                    ),
                    // If available, show the admitter note.
                    if (detail.admitterNote.isNotEmpty)
                      Text('Admitter Note: ${detail.admitterNote}'),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
