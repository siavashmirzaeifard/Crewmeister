import 'package:flutter/material.dart';

/// DropDown widget that provides filtering controls for absence data.
class FilterControls extends StatelessWidget {
  const FilterControls({
    super.key,
    required this.filterType,
    required this.filterDate,
    required this.onFilterChanged,
  });

  final String? filterType; // Selected filter type
  final DateTime? filterDate; // Selected filter date
  final Function({String? type, DateTime? date})
  onFilterChanged; // Callback that used when the filter values change.

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Dropdown to select type
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

        // Button to select a filter date
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

        // Button to clear both filters
        ElevatedButton(
          onPressed: () => onFilterChanged(type: null, date: null),
          child: const Text('Clear Filters'),
        ),
      ],
    );
  }
}
