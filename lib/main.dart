import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gedhub/core/app_providers.dart';
import 'package:gedhub/core/theme/app_theme.dart';
import 'package:gedhub/features/devtools/presentation/devtools_page.dart';
import 'package:gedhub/features/home/presentation/home_page.dart';
import 'package:gedhub/features/peoples/presentation/peoples_page.dart';
import 'package:gedhub/features/settings/presentation/settings_page.dart';
import 'package:gedhub/features/tree/presentation/tree_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: GedhubApp(),
    ),
  );
}

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class GedhubApp extends ConsumerWidget {
  const GedhubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'GedHub',
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      builder: (context, child) => DevtoolsGestureOverlay(
        navigatorKey: _navigatorKey,
        child: child ?? const SizedBox(),
      ),
      home: const _MainShell(),
    );
  }
}

class DevtoolsGestureOverlay extends StatelessWidget {
  const DevtoolsGestureOverlay({
    super.key,
    required this.navigatorKey,
    required this.child,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: () {
        final navigator = navigatorKey.currentState;
        if (navigator != null) {
          navigator.push(
            MaterialPageRoute<void>(
              builder: (_) => const DevtoolsPage(),
            ),
          );
        }
      },
      child: child,
    );
  }
}

class _MainShell extends HookWidget {
  const _MainShell();

  static const _pages = <Widget>[
    HomePage(),
    PeoplesPage(),
    TreePage(),
    SettingsPage(),
  ];

  static const _titles = <String>[
    'Home',
    'Peoples',
    'Tree',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[currentIndex.value]),
      ),
      body: _pages[currentIndex.value],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex.value,
        onDestinationSelected: (index) {
          currentIndex.value = index;
        },
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
