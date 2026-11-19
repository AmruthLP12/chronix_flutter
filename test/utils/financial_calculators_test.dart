import 'package:flutter_test/flutter_test.dart';
import 'package:chronix_flutter/models/gratuity_result.dart';
import 'package:chronix_flutter/utils/financial_calculators.dart';

void main() {
  group('FinancialCalculators', () {
    test('calculateLeaveSalary enforces 300 days cap and EL priority', () {
      final result = FinancialCalculators.calculateLeaveSalary(
        basicPay: 44900,
        daPercent: 55,
        elBalance: 200,
        hplBalance: 200,
      );

      // EL = 200, HPL fills remaining 100 days = 300 total
      expect(result.elDaysUsed, equals(200));
      expect(result.hplDaysUsed, equals(100));
      expect(result.totalDaysUsed, equals(300));
      expect(result.daAmount, equals(24695));
      expect(result.salaryWithDA, equals(69595));
      expect(result.totalLeaveSalary, greaterThan(0));
      expect(result.amountInWords, contains('Rupees Only'));
    });

    test('calculateGratuity enforces 5-year minimum eligibility', () {
      final result = FinancialCalculators.calculateGratuity(
        basicPay: 44900,
        daPercent: 55,
        category: GratuityCategory.gpf,
        joiningDate: DateTime(2020, 1, 1),
        calculationDate: DateTime(2023, 1, 1), // 3 years < 5 years
      );

      expect(result.serviceYears, equals(0));
      expect(result.gratuityAmount, equals(0));
    });

    test('calculateGratuity GPF formula and 3-month rounding rule', () {
      final result = FinancialCalculators.calculateGratuity(
        basicPay: 44900,
        daPercent: 55,
        category: GratuityCategory.gpf,
        joiningDate: DateTime(2014, 1, 1),
        calculationDate: DateTime(2024, 4, 15), // 10 yrs 3 months -> rounded to 11 yrs
      );

      expect(result.completedYears, equals(10));
      expect(result.completedMonths, equals(3));
      expect(result.serviceYears, equals(11));
      expect(result.gratuityAmount, greaterThan(0));
      expect(result.amountInWords, contains('Rupees Only'));
    });

    test('calculateGratuity NPS formula and 6-month rounding rule', () {
      // 10 yrs 4 months: GPF rounds to 11, NPS remains 10
      final resultGpf = FinancialCalculators.calculateGratuity(
        basicPay: 44900,
        daPercent: 55,
        category: GratuityCategory.gpf,
        joiningDate: DateTime(2014, 1, 1),
        calculationDate: DateTime(2024, 5, 15),
      );
      final resultNps = FinancialCalculators.calculateGratuity(
        basicPay: 44900,
        daPercent: 55,
        category: GratuityCategory.nps,
        joiningDate: DateTime(2014, 1, 1),
        calculationDate: DateTime(2024, 5, 15),
      );

      expect(resultGpf.serviceYears, equals(11));
      expect(resultNps.serviceYears, equals(10));
    });

    test('calculateGratuity enforces 25 Lakh statutory cap', () {
      final result = FinancialCalculators.calculateGratuity(
        basicPay: 250000,
        daPercent: 55,
        category: GratuityCategory.gpf,
        joiningDate: DateTime(1990, 1, 1),
        calculationDate: DateTime(2023, 1, 1), // 33 years
      );

      expect(result.serviceYears, equals(33));
      expect(result.gratuityBeforeLimit, greaterThan(2500000));
      expect(result.gratuityAmount, equals(2500000));
    });

    test('calculateLeaveSalary handles EL only, HPL only, and excessive leave balances', () {
      // EL = 350, capped at 300, HPL not needed
      final elOnly = FinancialCalculators.calculateLeaveSalary(
        basicPay: 50000,
        daPercent: 50,
        elBalance: 350,
        hplBalance: 100,
      );
      expect(elOnly.elDaysUsed, equals(300));
      expect(elOnly.hplDaysUsed, equals(0));
      expect(elOnly.totalDaysUsed, equals(300));

      // EL = 0, HPL = 150 -> only HPL is encashed at half-pay rate
      final hplOnly = FinancialCalculators.calculateLeaveSalary(
        basicPay: 50000,
        daPercent: 50,
        elBalance: 0,
        hplBalance: 150,
      );
      expect(hplOnly.elDaysUsed, equals(0));
      expect(hplOnly.hplDaysUsed, equals(150));
      expect(hplOnly.totalDaysUsed, equals(150));
      expect(hplOnly.elLeaveSalary, equals(0));
      expect(hplOnly.hplLeaveSalary, greaterThan(0));
    });

    test('calculateGratuity caps service at 33 years even for 40 years tenure', () {
      final result = FinancialCalculators.calculateGratuity(
        basicPay: 50000,
        daPercent: 50,
        category: GratuityCategory.nps,
        joiningDate: DateTime(1980, 1, 1),
        calculationDate: DateTime(2022, 1, 1), // 42 years
      );
      expect(result.completedYears, equals(42));
      expect(result.serviceYears, equals(33)); // Hard cap at 33
    });
  });
}
