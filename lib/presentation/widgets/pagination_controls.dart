import 'package:flutter/material.dart';

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
    final lastPage = (total + itemsPerPage - 1) ~/ itemsPerPage;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: currentPage > 1 ? onPrevious : null,
          child: const Text('Previous'),
        ),
        Text('Page $currentPage of $lastPage'),
        ElevatedButton(
          onPressed: currentPage < lastPage ? onNext : null,
          child: const Text('Next'),
        ),
      ],
    );
  }
}
