import 'package:flutter/material.dart';
import 'package:gedhub/features/devtools/presentation/devtools_page.dart';
import 'package:gedhub/features/devtools/presentation/drift_inspector_page.dart';
import 'package:gedhub/features/devtools/presentation/drift_table_data_page.dart';
import 'package:gedhub/features/devtools/presentation/shared_prefs_inspector_page.dart';
import 'package:gedhub/features/home/presentation/home_page.dart';
import 'package:gedhub/features/peoples/domain/person.dart';
import 'package:gedhub/features/peoples/presentation/peoples_page.dart';
import 'package:gedhub/features/peoples/presentation/person_form_page.dart';
import 'package:gedhub/features/settings/presentation/settings_page.dart';
import 'package:gedhub/features/tree/presentation/tree_page.dart';
import 'package:go_router/go_router.dart';

/// Kunci navigator root untuk route full-screen (di luar shell tab).
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Konfigurasi GoRouter untuk GEDHUB.
/// - Shell: Home, Peoples, Tree, Settings (bottom nav).
/// - Full-screen: person form (create/edit), devtools.
GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.peoples,
    redirect: (context, state) {
      final loc = state.uri.path;
      if (loc == '/' || loc.isEmpty) return AppRoutes.peoples;
      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => _MainShellScaffold(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'home'),
            routes: [
              GoRoute(
                path: AppRoutes.home,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'peoples'),
            routes: [
              GoRoute(
                path: AppRoutes.peoples,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PeoplesPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'tree'),
            routes: [
              GoRoute(
                path: AppRoutes.tree,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: TreePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'settings'),
            routes: [
              GoRoute(
                path: AppRoutes.settings,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SettingsPage(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.personForm,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const PersonFormPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.personEdit,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final person = state.extra as Person?;
          return MaterialPage<void>(
            key: state.pageKey,
            child: PersonFormPage(person: person),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.devtools,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const DevtoolsPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.devtoolsDrift,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const DriftInspectorPage(),
        ),
      ),
      GoRoute(
        path: '${AppRoutes.devtoolsDrift}/table/:tableName',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final tableName = state.pathParameters['tableName']!;
          return MaterialPage<void>(
            key: state.pageKey,
            child: DriftTableDataPage(tableName: tableName),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.devtoolsSharedPrefs,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const SharedPrefsInspectorPage(),
        ),
      ),
    ],
  );
}

/// Path dan nama route aplikasi (satu sumber kebenaran).
abstract class AppRoutes {
  static const String home = '/home';
  static const String peoples = '/peoples';
  static const String tree = '/tree';
  static const String settings = '/settings';
  static const String personForm = '/person/form';
  static const String personEdit = '/person/edit';
  static const String devtools = '/devtools';
  static const String devtoolsDrift = '/devtools/drift';
  static const String devtoolsSharedPrefs = '/devtools/shared-prefs';
}

/// Scaffold dengan bottom NavigationBar; memilih tab lewat [StatefulNavigationShell].
class _MainShellScaffold extends StatelessWidget {
  const _MainShellScaffold({
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  static const _titles = <String>['Home', 'Peoples', 'Tree', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[navigationShell.currentIndex]),
      ),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Peoples',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_tree_outlined),
            selectedIcon: Icon(Icons.account_tree),
            label: 'Tree',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
