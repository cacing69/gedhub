// Smoke test: main shell dengan 4 tab (Home, Peoples, Tree, Settings).
// Test per fitur ada di test/features/<nama>/ (mis. home_page_test.dart, projects_repository_test.dart).

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gedhub/core/app_providers.dart';
import 'package:gedhub/core/database/app_database.dart';
import 'package:gedhub/main.dart';

void main() {
  testWidgets('Main shell renders 4 tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWith(
            (ref) => AppDatabase(
              DatabaseConnection(
                NativeDatabase.memory(),
                closeStreamsSynchronously: true,
              ),
            ),
          ),
        ],
        child: const GedhubApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
    expect(find.text('Peoples'), findsOneWidget);
    expect(find.text('Tree'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });
}
