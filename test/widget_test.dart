// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:gedhub/main.dart';

void main() {
  testWidgets('Main shell renders 4 tabs', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GedhubApp());

    // Verify that the main navigation tabs are present.
    expect(find.text('Home'), findsWidgets);
    expect(find.text('Peoples'), findsOneWidget);
    expect(find.text('Tree'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });
}
