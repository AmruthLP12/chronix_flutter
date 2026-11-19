import 'package:flutter_test/flutter_test.dart';
import 'package:chronix_flutter/app.dart';

void main() {
  testWidgets('ChronixApp renders HomeScreen with utilities', (tester) async {
    await tester.pumpWidget(const ChronixApp());
    await tester.pumpAndSettle();

    expect(find.text('CHRONIX'), findsOneWidget);
    expect(find.text('Personal Helper Workspace'), findsOneWidget);
    expect(find.text('ACTIVE UTILITIES'), findsOneWidget);
    expect(find.text('Age Calculator'), findsOneWidget);
    expect(find.text('WhatsApp'), findsOneWidget);
    expect(find.text('Gratuity Details'), findsOneWidget);
  });
}
