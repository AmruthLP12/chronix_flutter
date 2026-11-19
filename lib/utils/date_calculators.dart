import 'dart:math';
import '../models/age_result.dart';
import '../models/service_result.dart';

/// Pure calendar arithmetic routines.
abstract final class DateCalculators {
  /// Calculates elapsed years, months, days, and total days between two dates.
  /// Throws [ArgumentError] if [fromDate] is after [toDate].
  static AgeResult calculateAge(DateTime fromDate, DateTime toDate) {
    if (fromDate.isAfter(toDate)) {
      throw ArgumentError('Start Date cannot be after End Date');
    }

    int years = toDate.year - fromDate.year;
    int months = toDate.month - fromDate.month;
    int days = toDate.day - fromDate.day;

    if (days < 0) {
      months--;
      // Days in previous month
      final previousMonthDays = DateTime(toDate.year, toDate.month, 0).day;
      days += previousMonthDays;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    // Exact elapsed calendar days
    final fromUtc = DateTime.utc(fromDate.year, fromDate.month, fromDate.day);
    final toUtc = DateTime.utc(toDate.year, toDate.month, toDate.day);
    final totalDays = toUtc.difference(fromUtc).inDays;

    return AgeResult(
      years: max(years, 0),
      months: max(months, 0),
      days: max(days, 0),
      totalDays: max(totalDays, 0),
    );
  }

  /// Calculates duration between two dates as years, months, and days.
  static ServiceDuration calculateServiceDifference(DateTime fromDate, DateTime toDate) {
    if (toDate.isBefore(fromDate)) {
      return const ServiceDuration(years: 0, months: 0, days: 0);
    }

    int years = toDate.year - fromDate.year;
    int months = toDate.month - fromDate.month;
    int days = toDate.day - fromDate.day;

    if (days < 0) {
      months--;
      final previousMonthDays = DateTime(toDate.year, toDate.month, 0).day;
      days += previousMonthDays;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    return ServiceDuration(
      years: max(years, 0),
      months: max(months, 0),
      days: max(days, 0),
    );
  }

  /// Computes completed service months for gratuity calculation.
  /// Matches the original Expo Gratuity formula.
  static int getCompletedServiceMonths(DateTime startDate, DateTime endDate) {
    if (endDate.isBefore(startDate)) {
      return 0;
    }

    int months = (endDate.year - startDate.year) * 12 +
        (endDate.month - startDate.month);

    if (endDate.day < startDate.day) {
      months--;
    }

    return max(months, 0);
  }
}
