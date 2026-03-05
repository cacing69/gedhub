import 'package:flutter/material.dart';
import 'package:gedhub_app/core/database/app_database.dart';
import 'package:gedhub_app/features/home/presentation/home_page.dart';
import 'package:gedhub_app/features/peoples/presentation/peoples_page.dart';
import 'package:gedhub_app/features/projects/domain/projects_repository.dart';
import 'package:gedhub_app/features/settings/presentation/settings_page.dart';
import 'package:gedhub_app/features/tree/presentation/tree_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const GedhubApp());
}

class GedhubApp extends StatelessWidget {
  const GedhubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<ProjectsRepository>(
      create: (_) => ProjectsRepository(AppDatabase()),
      dispose: (_, repo) => repo.dispose(),
      child: MaterialApp(
        title: 'GEDHUB',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const _MainShell(),
      ),
    );
  }
}

class _MainShell extends StatefulWidget {
  const _MainShell();

  @override
  State<_MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<_MainShell> {
  int _currentIndex = 0;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
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
