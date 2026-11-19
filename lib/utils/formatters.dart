import 'package:intl/intl.dart';

/// Formatting helpers for Indian currency and dates.
abstract final class Formatters {
  static final NumberFormat _indianCurrency = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹ ',
    decimalDigits: 0,
  );

  static final NumberFormat _indianNumber = NumberFormat.decimalPattern('en_IN');

  static final DateFormat _displayDate = DateFormat('dd MMM yyyy');
  static final DateFormat _shortDate = DateFormat('dd/MM/yyyy');

  /// Formats amount in Indian currency format: ₹ 25,00,000
  static String currency(num amount) {
    return _indianCurrency.format(amount.round());
  }

  /// Formats integer with Indian commas: 25,00,000
  static String number(num value) {
    return _indianNumber.format(value.round());
  }

  /// Formats date to "14 Mar 2024"
  static String date(DateTime dateTime) {
    return _displayDate.format(dateTime);
  }

  /// Formats date to "14/03/2024"
  static String shortDate(DateTime dateTime) {
    return _shortDate.format(dateTime);
  }
}
