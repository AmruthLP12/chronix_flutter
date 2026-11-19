import 'package:flutter_test/flutter_test.dart';
import 'package:chronix_flutter/utils/time_calculators.dart';

void main() {
  group('TimeCalculators', () {
    test('convert24To12 conversions', () {
      expect(TimeCalculators.convert24To12('0', '0').formatted, equals('12:00 AM'));
      expect(TimeCalculators.convert24To12('12', '00').formatted, equals('12:00 PM'));
      expect(TimeCalculators.convert24To12('14', '05').formatted, equals('2:05 PM'));
      expect(TimeCalculators.convert24To12('23', '59').formatted, equals('11:59 PM'));
      expect(TimeCalculators.convert24To12('24', '00').isValid, isFalse);
      expect(TimeCalculators.convert24To12('10', '60').isValid, isFalse);
    });

    test('convert12To24 conversions', () {
      expect(TimeCalculators.convert12To24('12', '00', 'AM').formatted, equals('00:00'));
      expect(TimeCalculators.convert12To24('12', '00', 'PM').formatted, equals('12:00'));
      expect(TimeCalculators.convert12To24('2', '05', 'PM').formatted, equals('14:05'));
      expect(TimeCalculators.convert12To24('11', '59', 'PM').formatted, equals('23:59'));
      expect(TimeCalculators.convert12To24('13', '00', 'PM').isValid, isFalse);
    });
  });
}
