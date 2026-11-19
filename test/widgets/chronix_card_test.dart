import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chronix_flutter/widgets/chronix_card.dart';

void main() {
  testWidgets('ChronixCard renders child and responds to tap', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChronixCard(
            onTap: () => tapped = true,
            child: const Text('Test Card Content'),
          ),
        ),
      ),
    );

    expect(find.text('Test Card Content'), findsOneWidget);
    await tester.tap(find.text('Test Card Content'));
    expect(tapped, isTrue);
  });
}
