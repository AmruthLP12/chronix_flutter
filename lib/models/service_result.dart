/// Result of employment service duration calculations.
final class ServiceDuration {
  final int years;
  final int months;
  final int days;

  const ServiceDuration({
    required this.years,
    required this.months,
    required this.days,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceDuration &&
          runtimeType == other.runtimeType &&
          years == other.years &&
          months == other.months &&
          days == other.days;

  @override
  int get hashCode => Object.hash(years, months, days);
}

final class ServiceResult {
  final ServiceDuration overallService;
  final ServiceDuration? remainingService;

  const ServiceResult({
    required this.overallService,
    this.remainingService,
  });
}
