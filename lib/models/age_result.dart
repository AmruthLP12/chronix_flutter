/// Result of an age / elapsed duration calculation.
final class AgeResult {
  final int years;
  final int months;
  final int days;
  final int totalDays;

  const AgeResult({
    required this.years,
    required this.months,
    required this.days,
    required this.totalDays,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgeResult &&
          runtimeType == other.runtimeType &&
          years == other.years &&
          months == other.months &&
          days == other.days &&
          totalDays == other.totalDays;

  @override
  int get hashCode => Object.hash(years, months, days, totalDays);
}
