import 'package:flutter/material.dart';
import 'package:gedhub/features/devtools/presentation/drift_table_data_page.dart';

/// Daftar tabel Drift yang bisa di-inspect.
/// Tap tabel → tampilan data compact (database explorer).
class DriftInspectorPage extends StatelessWidget {
  const DriftInspectorPage({super.key});

  /// Tabel yang tersedia di AppDatabase (sesuaikan bila ada tabel baru).
  static const List<String> _tableNames = [
    'projects',
    // 'persons', 'families', dll. nanti
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drift Inspector'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Pilih tabel untuk melihat data',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          ..._tableNames.map(
            (tableName) => ListTile(
              leading: Icon(
                Icons.table_chart_outlined,
                color: theme.colorScheme.primary,
              ),
              title: Text(tableName),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => DriftTableDataPage(tableName: tableName),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
