import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chronix_flutter/widgets/chronix_stat_card.dart';

void main() {
  testWidgets('ChronixStatGrid displays multiple metrics with labels', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ChronixStatGrid(
            cards: [
              ChronixStatCard(value: 24, label: 'Years'),
              ChronixStatCard(value: 5, label: 'Months'),
              ChronixStatCard(value: 12, label: 'Days'),
            ],
          ),
        ),
      ),
    );

    expect(find.text('24'), findsOneWidget);
    expect(find.text('YEARS'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('MONTHS'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('DAYS'), findsOneWidget);
  });
}
