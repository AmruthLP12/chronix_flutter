/// Result of a time format conversion.
final class TimeResult {
  final String formatted;
  final bool isValid;
  final String? errorMessage;

  const TimeResult.success(this.formatted)
      : isValid = true,
        errorMessage = null;

  const TimeResult.error(this.errorMessage)
      : isValid = false,
        formatted = '';
}
