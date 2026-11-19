import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chronix_flutter/models/utility.dart';
import 'package:chronix_flutter/widgets/chronix_utility_card.dart';

void main() {
  testWidgets('ChronixUtilityCard renders active utility and handles tap', (tester) async {
    var tapped = false;

    const utility = Utility(
      title: 'WhatsApp',
      description: 'Open direct WhatsApp chat',
      route: '/whatsapp',
      icon: Icons.chat,
      category: UtilityCategory.communication,
      isActive: true,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChronixUtilityCard(
            utility: utility,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('WhatsApp'), findsOneWidget);
    expect(find.text('Open direct WhatsApp chat'), findsOneWidget);
    expect(find.text('Open Utility'), findsOneWidget);

    await tester.tap(find.text('WhatsApp'));
    expect(tapped, isTrue);
  });
}
