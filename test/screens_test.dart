import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chronix_flutter/app.dart';

void main() {
  group('Screen Navigation & Calculation Flows', () {
    testWidgets('Navigate to Age Calculator, calculate, and verify output', (tester) async {
      tester.view.physicalSize = const Size(1200, 3200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const ChronixApp());
      await tester.pumpAndSettle();

      final ageFinder = find.text('Age Calculator').first;
      await tester.tap(ageFinder);
      await tester.pumpAndSettle();

      expect(find.text('Calculate Age'), findsOneWidget);

      await tester.tap(find.text('Calculate Age'));
      await tester.pumpAndSettle();

      expect(find.text('CALCULATION RESULTS'), findsOneWidget);
      expect(find.text('TOTAL DURATION'), findsOneWidget);
      expect(find.text('Total Elapsed Calendar Days'), findsOneWidget);
    });

    testWidgets('Navigate to Time Converter and convert 24 to 12', (tester) async {
      tester.view.physicalSize = const Size(1200, 3200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const ChronixApp());
      await tester.pumpAndSettle();

      final timeFinder = find.text('Time Converter').first;
      await tester.tap(timeFinder);
      await tester.pumpAndSettle();

      expect(find.text('24 → 12 HOUR FORMAT'), findsOneWidget);

      final hourFields = find.byType(TextField);
      await tester.enterText(hourFields.at(0), '14');
      await tester.enterText(hourFields.at(1), '30');

      await tester.tap(find.text('Convert to 12-Hour'));
      await tester.pumpAndSettle();

      expect(find.text('2:30 PM'), findsOneWidget);
    });

    testWidgets('Navigate to Leave Salary and calculate encashment', (tester) async {
      tester.view.physicalSize = const Size(1200, 3200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const ChronixApp());
      await tester.pumpAndSettle();

      final leaveFinder = find.text('Salary Leave Calculator').first;
      await tester.tap(leaveFinder);
      await tester.pumpAndSettle();

      expect(find.text('Calculate Leave Salary'), findsOneWidget);

      final textFields = find.byType(TextField);
      await tester.enterText(textFields.at(0), '44900');
      await tester.enterText(textFields.at(1), '55');
      await tester.enterText(textFields.at(2), '300');
      await tester.enterText(textFields.at(3), '180');

      await tester.tap(find.text('Calculate Leave Salary'));
      await tester.pumpAndSettle();

      expect(find.text('LEAVE DAYS ENCASHED'), findsOneWidget);
      expect(find.text('TOTAL LEAVE ENCASHMENT'), findsOneWidget);
    });

    testWidgets('Navigate to Gratuity and calculate benefits', (tester) async {
      tester.view.physicalSize = const Size(1200, 3200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const ChronixApp());
      await tester.pumpAndSettle();

      final gratuityFinder = find.text('Gratuity Details').first;
      await tester.tap(gratuityFinder);
      await tester.pumpAndSettle();

      expect(find.text('Calculate Gratuity'), findsOneWidget);

      final textFields = find.byType(TextField);
      await tester.enterText(textFields.at(0), '44900');
      await tester.enterText(textFields.at(1), '55');

      await tester.tap(find.text('Calculate Gratuity'));
      await tester.pumpAndSettle();

      expect(find.text('QUALIFYING SERVICE'), findsOneWidget);
      expect(find.text('TOTAL GRATUITY PAYABLE'), findsOneWidget);
    });

    testWidgets('Navigate to Service Calculator, calculate, and verify output', (tester) async {
      tester.view.physicalSize = const Size(1200, 3200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const ChronixApp());
      await tester.pumpAndSettle();

      final serviceFinder = find.text('Service Calculator').first;
      await tester.tap(serviceFinder);
      await tester.pumpAndSettle();

      expect(find.text('Calculate Service'), findsOneWidget);

      await tester.tap(find.text('Calculate Service'));
      await tester.pumpAndSettle();

      expect(find.text('SERVICE TELEMETRY RESULTS'), findsOneWidget);
      expect(find.text('OVERALL SERVICE DURATION'), findsOneWidget);
    });

    testWidgets('Navigate to WhatsApp, validate input and button state', (tester) async {
      tester.view.physicalSize = const Size(1200, 3200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const ChronixApp());
      await tester.pumpAndSettle();

      final whatsappFinder = find.text('WhatsApp').first;
      await tester.tap(whatsappFinder);
      await tester.pumpAndSettle();

      expect(find.text('Open WhatsApp'), findsOneWidget);
      expect(find.text('HOW IT WORKS'), findsOneWidget);

      // Tap without number -> validates
      await tester.tap(find.text('Open WhatsApp'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter a phone number'), findsOneWidget);

      // Enter 10-digit number
      final inputField = find.byType(TextField);
      await tester.enterText(inputField, '9876543210');
      await tester.pumpAndSettle();
      expect(find.text('Please enter a phone number'), findsNothing);
    });

    testWidgets('Switch category chips on Home screen', (tester) async {
      tester.view.physicalSize = const Size(1200, 3200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const ChronixApp());
      await tester.pumpAndSettle();

      // Tap 'Communication'
      await tester.tap(find.text('Communication'));
      await tester.pumpAndSettle();
      expect(find.text('WhatsApp'), findsOneWidget);
      expect(find.text('Age Calculator'), findsNothing);

      // Tap 'Finance'
      await tester.tap(find.text('Finance'));
      await tester.pumpAndSettle();
      expect(find.text('Salary Leave Calculator'), findsOneWidget);
      expect(find.text('Gratuity Details'), findsOneWidget);
      expect(find.text('WhatsApp'), findsNothing);

      // Tap 'All'
      await tester.tap(find.text('All'));
      await tester.pumpAndSettle();
      expect(find.text('WhatsApp'), findsOneWidget);
      expect(find.text('Age Calculator'), findsOneWidget);
    });

    testWidgets('Open and dismiss About bottom sheet', (tester) async {
      tester.view.physicalSize = const Size(1200, 3200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const ChronixApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.info_outline_rounded));
      await tester.pumpAndSettle();

      expect(find.text('VERSION 1.0.0'), findsOneWidget);
      expect(find.text('AVAILABLE MODULES'), findsOneWidget);
      expect(find.text('CREATED BY AMRUTH L P'), findsOneWidget);

      tester.state<NavigatorState>(find.byType(Navigator).last).pop();
      await tester.pumpAndSettle();

      expect(find.text('VERSION 1.0.0'), findsNothing);
    });
  });
}
