enum GratuityCategory {
  gpf('GPF'),
  nps('NPS');

  final String label;
  const GratuityCategory(this.label);
}

/// Calculation result for Gratuity benefits.
final class GratuityResult {
  final GratuityCategory category;

  final double basicPay;
  final double daPercent;
  final double daAmount;
  final double salaryWithDA;

  final int completedServiceMonths;
  final int completedYears;
  final int completedMonths;
  final String completedServiceDisplay;

  final int serviceYears;
  final double gratuityBeforeLimit;
  final double gratuityAmount;
  final String amountInWords;

  final int firstYearAfterMonths;
  final int formulaMultiplier;
  final int formulaDivisor;

  const GratuityResult({
    required this.category,
    required this.basicPay,
    required this.daPercent,
    required this.daAmount,
    required this.salaryWithDA,
    required this.completedServiceMonths,
    required this.completedYears,
    required this.completedMonths,
    required this.completedServiceDisplay,
    required this.serviceYears,
    required this.gratuityBeforeLimit,
    required this.gratuityAmount,
    required this.amountInWords,
    required this.firstYearAfterMonths,
    required this.formulaMultiplier,
    required this.formulaDivisor,
  });
}
