import 'package:flutter/material.dart';

class FilterControls extends StatelessWidget {
  final String? filterType;
  final DateTime? filterDate;
  final Function({String? type, DateTime? date}) onFilterChanged;
  const FilterControls({
    super.key,
    required this.filterType,
    required this.filterDate,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<String>(
          hint: const Text('Filter Type'),
          value: filterType,
          items:
              [
                'sickness',
                'vacation',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (value) {
            onFilterChanged(type: value, date: filterDate);
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
            onFilterChanged(type: filterType, date: picked);
          },
          child: const Text('Filter Date'),
        ),
        ElevatedButton(
          onPressed: () => onFilterChanged(type: null, date: null),
          child: const Text('Clear Filters'),
        ),
      ],
    );
  }
}
