/// Converts numbers into English words, used for statutory financial totals.
abstract final class NumberToWords {
  static const List<String> _units = [
    '',
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
    'Ten',
    'Eleven',
    'Twelve',
    'Thirteen',
    'Fourteen',
    'Fifteen',
    'Sixteen',
    'Seventeen',
    'Eighteen',
    'Nineteen',
  ];

  static const List<String> _tens = [
    '',
    '',
    'Twenty',
    'Thirty',
    'Forty',
    'Fifty',
    'Sixty',
    'Seventy',
    'Eighty',
    'Ninety',
  ];

  /// Converts a positive integer to English words.
  static String convert(int n) {
    if (n == 0) return 'Zero';
    if (n < 0) return 'Minus ${convert(-n)}';

    return _convertInternal(n).trim();
  }

  /// Converts a financial amount into currency words with "Rupees Only".
  static String convertCurrency(num amount) {
    final rounded = amount.round();
    if (rounded == 0) return 'Zero Rupees Only';
    return '${convert(rounded)} Rupees Only';
  }

  static String _convertInternal(int n) {
    if (n < 20) {
      return _units[n];
    }
    if (n < 100) {
      final rem = n % 10;
      return '${_tens[n ~/ 10]}${rem > 0 ? " ${_units[rem]}" : ""}';
    }
    if (n < 1000) {
      final rem = n % 100;
      return '${_units[n ~/ 100]} Hundred${rem > 0 ? " ${_convertInternal(rem)}" : ""}';
    }
    if (n < 100000) {
      // Thousands
      final rem = n % 1000;
      return '${_convertInternal(n ~/ 1000)} Thousand${rem > 0 ? " ${_convertInternal(rem)}" : ""}';
    }
    if (n < 10000000) {
      // Lakhs (Indian numbering system)
      final rem = n % 100000;
      return '${_convertInternal(n ~/ 100000)} Lakh${rem > 0 ? " ${_convertInternal(rem)}" : ""}';
    }
    // Crores
    final rem = n % 10000000;
    return '${_convertInternal(n ~/ 10000000)} Crore${rem > 0 ? " ${_convertInternal(rem)}" : ""}';
  }
}
