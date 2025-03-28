/// Calculates period between two dates that should be human readable like "2 days", "3 hours", or "15 minutes".
/// If parsing fails, it returns the original date range.
String calculatePeriod(String startDateStr, String endDateStr) {
  try {
    final start = DateTime.parse(startDateStr);
    final end = DateTime.parse(endDateStr);
    final diff = end.difference(start);
    if (diff.inDays > 0) {
      return "${diff.inDays} day${diff.inDays > 1 ? 's' : ''}";
    } else if (diff.inHours > 0) {
      return "${diff.inHours} hour${diff.inHours > 1 ? 's' : ''}";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''}";
    } else {
      return "Less than a minute";
    }
  } catch (e) {
    return "$startDateStr - $endDateStr";
  }
}
