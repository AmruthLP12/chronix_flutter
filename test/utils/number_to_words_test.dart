import 'package:flutter_test/flutter_test.dart';
import 'package:chronix_flutter/utils/number_to_words.dart';

void main() {
  group('NumberToWords', () {
    test('converts basic numbers', () {
      expect(NumberToWords.convert(0), equals('Zero'));
      expect(NumberToWords.convert(1), equals('One'));
      expect(NumberToWords.convert(15), equals('Fifteen'));
      expect(NumberToWords.convert(42), equals('Forty Two'));
      expect(NumberToWords.convert(100), equals('One Hundred'));
      expect(NumberToWords.convert(305), equals('Three Hundred Five'));
      expect(NumberToWords.convert(1000), equals('One Thousand'));
      expect(NumberToWords.convert(44900), equals('Forty Four Thousand Nine Hundred'));
    });

    test('converts Indian lakhs and crores', () {
      expect(NumberToWords.convert(100000), equals('One Lakh'));
      expect(NumberToWords.convert(250000), equals('Two Lakh Fifty Thousand'));
      expect(NumberToWords.convert(2500000), equals('Twenty Five Lakh'));
      expect(NumberToWords.convert(10000000), equals('One Crore'));
    });

    test('converts currency format with Rupees Only', () {
      expect(
        NumberToWords.convertCurrency(2500000),
        equals('Twenty Five Lakh Rupees Only'),
      );
      expect(
        NumberToWords.convertCurrency(0),
        equals('Zero Rupees Only'),
      );
    });
  });
}
