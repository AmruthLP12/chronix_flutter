/// Calculation result for Leave Salary encashment.
final class LeaveSalaryResult {
  final double basicPay;
  final double daPercent;
  final double daAmount;
  final double salaryWithDA;

  final int elDaysUsed;
  final int hplDaysUsed;
  final int totalDaysUsed;

  final double elLeaveSalary;
  final double hplLeaveSalary;
  final double totalLeaveSalary;
  final String amountInWords;

  const LeaveSalaryResult({
    required this.basicPay,
    required this.daPercent,
    required this.daAmount,
    required this.salaryWithDA,
    required this.elDaysUsed,
    required this.hplDaysUsed,
    required this.totalDaysUsed,
    required this.elLeaveSalary,
    required this.hplLeaveSalary,
    required this.totalLeaveSalary,
    required this.amountInWords,
  });
}
