import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chronix_flutter/widgets/chronix_button.dart';

void main() {
  testWidgets('ChronixButton displays label and handles clicks', (tester) async {
    var pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChronixButton(
            text: 'Calculate Now',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    expect(find.text('Calculate Now'), findsOneWidget);
    await tester.tap(find.text('Calculate Now'));
    expect(pressed, isTrue);
  });
}
