import 'package:flutter_test/flutter_test.dart';
import 'package:chronix_flutter/utils/date_calculators.dart';

void main() {
  group('DateCalculators', () {
    test('calculateAge calculates exact difference', () {
      final from = DateTime(2000, 1, 1);
      final to = DateTime(2024, 3, 15);
      final result = DateCalculators.calculateAge(from, to);

      expect(result.years, equals(24));
      expect(result.months, equals(2));
      expect(result.days, equals(14));
      expect(result.totalDays, greaterThan(8800));
    });

    test('calculateAge throws on inverted dates', () {
      final from = DateTime(2024, 1, 1);
      final to = DateTime(2020, 1, 1);
      expect(
        () => DateCalculators.calculateAge(from, to),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('calculateServiceDifference computes tenure accurately', () {
      final from = DateTime(2014, 3, 14);
      final to = DateTime(2024, 3, 14);
      final duration = DateCalculators.calculateServiceDifference(from, to);

      expect(duration.years, equals(10));
      expect(duration.months, equals(0));
      expect(duration.days, equals(0));
    });

    test('getCompletedServiceMonths handles day borrowing', () {
      final start = DateTime(2020, 1, 15);
      final end = DateTime(2020, 3, 10); // Day is less -> 1 month
      expect(DateCalculators.getCompletedServiceMonths(start, end), equals(1));

      final end2 = DateTime(2020, 3, 20); // Day is greater -> 2 months
      expect(DateCalculators.getCompletedServiceMonths(start, end2), equals(2));
    });

    test('calculateAge handles leap year and identical dates', () {
      final leapStart = DateTime(2020, 2, 28);
      final leapEnd = DateTime(2020, 3, 1);
      final leapResult = DateCalculators.calculateAge(leapStart, leapEnd);
      expect(leapResult.days, equals(2)); // Feb 29 + Mar 1

      final sameDate = DateTime(2024, 6, 1);
      final sameResult = DateCalculators.calculateAge(sameDate, sameDate);
      expect(sameResult.years, equals(0));
      expect(sameResult.months, equals(0));
      expect(sameResult.days, equals(0));
      expect(sameResult.totalDays, equals(0));
    });

    test('calculateServiceDifference and getCompletedServiceMonths guard against inverted dates', () {
      final start = DateTime(2025, 1, 1);
      final end = DateTime(2020, 1, 1);

      final diff = DateCalculators.calculateServiceDifference(start, end);
      expect(diff.years, equals(0));
      expect(diff.months, equals(0));
      expect(diff.days, equals(0));

      final months = DateCalculators.getCompletedServiceMonths(start, end);
      expect(months, equals(0));
    });
  });
}
