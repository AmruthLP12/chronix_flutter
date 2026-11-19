import '../models/time_result.dart';

/// Temporal conversion algorithms between 12-hour AM/PM and 24-hour formats.
abstract final class TimeCalculators {
  /// Converts 24-hour time to 12-hour AM/PM format.
  /// Example: (14, "05") -> "2:05 PM", (0, "00") -> "12:00 AM".
  static TimeResult convert24To12(String hourStr, String minuteStr) {
    final hour = int.tryParse(hourStr.trim());
    if (hour == null || hour < 0 || hour > 23) {
      return const TimeResult.error('Invalid Hour');
    }

    final rawMinute = minuteStr.trim().isEmpty ? '00' : minuteStr.trim();
    final minute = int.tryParse(rawMinute);
    if (minute == null || minute < 0 || minute > 59) {
      return const TimeResult.error('Invalid Minute');
    }

    final ampm = hour >= 12 ? 'PM' : 'AM';
    final convertedHour = (hour % 12 == 0) ? 12 : hour % 12;
    final formattedMinute = minute.toString().padLeft(2, '0');

    return TimeResult.success('$convertedHour:$formattedMinute $ampm');
  }

  /// Converts 12-hour time to 24-hour military/system format.
  /// Example: (2, "05", "PM") -> "14:05", (12, "00", "AM") -> "00:00".
  static TimeResult convert12To24(String hourStr, String minuteStr, String period) {
    var hour = int.tryParse(hourStr.trim());
    if (hour == null || hour < 1 || hour > 12) {
      return const TimeResult.error('Invalid Hour');
    }

    final rawMinute = minuteStr.trim().isEmpty ? '00' : minuteStr.trim();
    final minute = int.tryParse(rawMinute);
    if (minute == null || minute < 0 || minute > 59) {
      return const TimeResult.error('Invalid Minute');
    }

    final normalizedPeriod = period.trim().toUpperCase();
    if (normalizedPeriod == 'PM' && hour != 12) {
      hour += 12;
    } else if (normalizedPeriod == 'AM' && hour == 12) {
      hour = 0;
    }

    final formattedHour = hour.toString().padLeft(2, '0');
    final formattedMinute = minute.toString().padLeft(2, '0');

    return TimeResult.success('$formattedHour:$formattedMinute');
  }
}
