import 'dart:math';
import '../models/gratuity_result.dart';
import '../models/leave_salary_result.dart';
import 'date_calculators.dart';
import 'number_to_words.dart';

/// Pure financial calculations for Indian Government employment benefits.
abstract final class FinancialCalculators {
  static const int maxLeaveDays = 300;
  static const int minServiceYears = 5;
  static const int maxServiceYears = 33;
  static const double maxGratuityAmount = 2500000.0; // ₹ 25 Lakhs

  /// Calculates Earned Leave (EL) & Half Pay Leave (HPL) encashment benefits.
  static LeaveSalaryResult calculateLeaveSalary({
    required double basicPay,
    required double daPercent,
    required int elBalance,
    required int hplBalance,
  }) {
    final daAmount = (basicPay * daPercent) / 100;
    final salaryWithDA = basicPay + daAmount;

    // EL consumed first up to 300 days
    final elDaysUsed = min(max(elBalance, 0), maxLeaveDays);
    final remainingDays = max(0, maxLeaveDays - elDaysUsed);

    // HPL used for remaining balance up to 300 days
    final hplDaysUsed = min(max(hplBalance, 0), remainingDays);
    final totalDaysUsed = elDaysUsed + hplDaysUsed;

    // EL encashment: Full basic + DA per 30 days
    final elLeaveSalary = (salaryWithDA * elDaysUsed) / 30;

    // HPL encashment: Half pay + half DA per 30 days
    final halfBasic = (basicPay / 2).round();
    final halfDA = (daAmount / 2).round();
    final hplLeaveSalary = ((halfBasic + halfDA) * hplDaysUsed) / 30;

    final totalLeaveSalary = elLeaveSalary + hplLeaveSalary;
    final amountInWords = NumberToWords.convertCurrency(totalLeaveSalary);

    return LeaveSalaryResult(
      basicPay: basicPay,
      daPercent: daPercent,
      daAmount: daAmount,
      salaryWithDA: salaryWithDA,
      elDaysUsed: elDaysUsed,
      hplDaysUsed: hplDaysUsed,
      totalDaysUsed: totalDaysUsed,
      elLeaveSalary: elLeaveSalary,
      hplLeaveSalary: hplLeaveSalary,
      totalLeaveSalary: totalLeaveSalary,
      amountInWords: amountInWords,
    );
  }

  /// Calculates terminal gratuity benefits under GPF (Old Pension) and NPS rules.
  static GratuityResult calculateGratuity({
    required double basicPay,
    required double daPercent,
    required GratuityCategory category,
    required DateTime joiningDate,
    required DateTime calculationDate,
  }) {
    if (calculationDate.isBefore(joiningDate)) {
      throw ArgumentError('Calculation date cannot be before joining date');
    }

    final daAmount = ((basicPay * daPercent) / 100).roundToDouble();
    final salaryWithDA = basicPay + daAmount;

    final completedServiceMonths = DateCalculators.getCompletedServiceMonths(
      joiningDate,
      calculationDate,
    );

    final completedYears = completedServiceMonths ~/ 12;
    final completedMonths = completedServiceMonths % 12;
    final completedServiceDisplay = '$completedYears yr(s) $completedMonths month(s)';

    // Minimum service of 5 years (60 months) required for gratuity
    final minimumServiceMonths = minServiceYears * 12;
    final firstYearAfterMonths = (category == GratuityCategory.gpf) ? 3 : 6;

    int serviceYears = 0;
    if (completedServiceMonths >= minimumServiceMonths) {
      serviceYears = completedServiceMonths ~/ 12;
      final remainingMonths = completedServiceMonths % 12;
      if (remainingMonths >= firstYearAfterMonths) {
        serviceYears++;
      }
    }

    // Maximum service considered is 33 years
    serviceYears = min(serviceYears, maxServiceYears);

    // Gratuity formulas
    final double gratuityBeforeLimit;
    final int formulaMultiplier;
    final int formulaDivisor;

    if (category == GratuityCategory.gpf) {
      // ((Basic + DA) × (Service Years × 2)) / 4
      formulaMultiplier = 2;
      formulaDivisor = 4;
      gratuityBeforeLimit =
          ((salaryWithDA * serviceYears * 2) / 4).roundToDouble();
    } else {
      // ((Basic + DA) × (Service Years × 15)) / 26
      formulaMultiplier = 15;
      formulaDivisor = 26;
      gratuityBeforeLimit =
          ((salaryWithDA * serviceYears * 15) / 26).roundToDouble();
    }

    // Statutory ceiling check (₹ 25 Lakhs)
    final gratuityAmount = min(gratuityBeforeLimit, maxGratuityAmount);
    final amountInWords = NumberToWords.convertCurrency(gratuityAmount);

    return GratuityResult(
      category: category,
      basicPay: basicPay,
      daPercent: daPercent,
      daAmount: daAmount,
      salaryWithDA: salaryWithDA,
      completedServiceMonths: completedServiceMonths,
      completedYears: completedYears,
      completedMonths: completedMonths,
      completedServiceDisplay: completedServiceDisplay,
      serviceYears: serviceYears,
      gratuityBeforeLimit: gratuityBeforeLimit,
      gratuityAmount: gratuityAmount,
      amountInWords: amountInWords,
      firstYearAfterMonths: firstYearAfterMonths,
      formulaMultiplier: formulaMultiplier,
      formulaDivisor: formulaDivisor,
    );
  }
}
