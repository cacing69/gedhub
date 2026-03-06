import 'package:flutter/material.dart';
import 'package:gedhub/core/router/app_router.dart';
import 'package:go_router/go_router.dart';

class DevtoolsPage extends StatelessWidget {
  const DevtoolsPage({super.key});

  static const List<_ToolItem> _tools = [
    _ToolItem(
      id: 'drift_inspector',
      title: 'Drift Inspector',
      subtitle: 'Inspect tabel & data database Drift (SQLite)',
      icon: Icons.storage_outlined,
      path: AppRoutes.devtoolsDrift,
    ),
    _ToolItem(
      id: 'shared_prefs',
      title: 'Shared Prefs',
      subtitle: 'Lihat key-value yang tersimpan di SharedPreferences',
      icon: Icons.key_outlined,
      path: AppRoutes.devtoolsSharedPrefs,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dev Tools'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Pilih tool inspect/debug',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          ..._tools.map(
            (tool) => ListTile(
              leading: Icon(tool.icon, color: theme.colorScheme.primary),
              title: Text(tool.title),
              subtitle: Text(tool.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(tool.path),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Cara akses: Long-press di mana saja pada layar untuk membuka Dev Tools.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolItem {
  const _ToolItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.path,
  });
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final String path;
}
