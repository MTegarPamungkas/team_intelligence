class BoolHelper {
  static bool isRecentActivity(String? timestamp) {
    if (timestamp == null) return false;
    try {
      final dateTime = DateTime.parse(timestamp);
      final difference = DateTime.now().difference(dateTime);
      return difference.inHours <
          2; // Consider activities within 2 hours as recent
    } catch (e) {
      return false;
    }
  }
}
