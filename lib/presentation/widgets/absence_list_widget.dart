import 'package:flutter/material.dart';

class AbsenceListWidget extends StatelessWidget {
  final int total;
  final List response;
  const AbsenceListWidget({
    super.key,
    required this.total,
    required this.absences,
  }) : response = absences;

  final List absences;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
