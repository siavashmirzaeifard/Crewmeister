import 'package:flutter/material.dart';

/// A widget that displays pagination controls with "Previous" and "Next" buttons.
class PaginationControls extends StatelessWidget {
  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.total,
    required this.itemsPerPage,
    required this.onPrevious,
    required this.onNext,
  });

  final int currentPage;
  final int total;
  final int itemsPerPage;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    // Calculate the last page number based on total items and items per page.
    final lastPage = (total + itemsPerPage - 1) ~/ itemsPerPage;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Previous button, disabled if the current page is the first.
        ElevatedButton(
          onPressed: currentPage > 1 ? onPrevious : null,
          child: const Text('Previous'),
        ),

        // Current page and the total number of pages
        Text('Page $currentPage of $lastPage'),

        // Next button, disabled if the current page is the last.
        ElevatedButton(
          onPressed: currentPage < lastPage ? onNext : null,
          child: const Text('Next'),
        ),
      ],
    );
  }
}
