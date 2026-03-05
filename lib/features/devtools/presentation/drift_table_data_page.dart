import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gedhub/core/app_providers.dart';
import 'package:gedhub/features/projects/domain/project.dart';

/// Tampilan data tabel ala database explorer: header kolom + baris data compact.
class DriftTableDataPage extends ConsumerWidget {
  const DriftTableDataPage({super.key, required this.tableName});

  final String tableName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table: $tableName'),
      ),
      body: _TableDataView(tableName: tableName),
    );
  }
}

class _TableDataView extends ConsumerWidget {
  const _TableDataView({required this.tableName});

  final String tableName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    if (tableName == 'projects') {
      final async = ref.watch(projectsStreamProvider);
      return async.when(
        data: (projects) => _buildProjectsTable(context, theme, projects),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Gagal memuat: $e',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ),
      );
    }
    return Center(
      child: Text(
        'Tabel "$tableName" belum didukung.',
        style: theme.textTheme.bodySmall,
      ),
    );
  }

  static const List<String> _projectsColumns = [
    'id',
    'name',
    'description',
    'locale',
    'created_at',
  ];

  List<String> _projectToRow(Project p) => [
        p.id.toString(),
        p.name,
        p.description ?? '',
        p.locale ?? '',
        p.createdAt.toIso8601String(),
      ];

  Widget _buildProjectsTable(
    BuildContext context,
    ThemeData theme,
    List<Project> projects,
  ) {
    final textStyle = theme.textTheme.bodySmall?.copyWith(fontSize: 12);
    final headerStyle = theme.textTheme.labelMedium?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: 12,
    );
    final headerColor = theme.colorScheme.primaryContainer.withOpacity(0.4);
    final oddRowColor = theme.colorScheme.surfaceContainerHighest.withOpacity(0.5);
    final evenRowColor = theme.colorScheme.surface;

    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              showCheckboxColumn: false,
              headingRowColor: WidgetStateProperty.all(headerColor),
              headingTextStyle: headerStyle,
              dataTextStyle: textStyle,
              columnSpacing: 16,
              horizontalMargin: 12,
              columns: _projectsColumns
                  .map(
                    (c) => DataColumn(
                      label: Text(c),
                    ),
                  )
                  .toList(),
              rows: [
                for (var i = 0; i < projects.length; i++)
                  DataRow(
                    color: WidgetStateProperty.all(
                      i.isEven ? evenRowColor : oddRowColor,
                    ),
                    cells: _projectToRow(projects[i])
                        .map(
                          (cell) => DataCell(
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxWidth: 200,
                                minWidth: 48,
                              ),
                              child: Text(
                                cell,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onSelectChanged: (_) => _showRowDetailBottomSheet(
                      context,
                      theme,
                      projects[i],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showRowDetailBottomSheet(
    BuildContext context,
    ThemeData theme,
    Project project,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.25,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outline.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Row detail — projects',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _DetailRow(
                theme: theme,
                label: 'id',
                value: project.id.toString(),
              ),
              _DetailRow(
                theme: theme,
                label: 'name',
                value: project.name,
              ),
              _DetailRow(
                theme: theme,
                label: 'description',
                value: project.description ?? '—',
              ),
              _DetailRow(
                theme: theme,
                label: 'locale',
                value: project.locale ?? '—',
              ),
              _DetailRow(
                theme: theme,
                label: 'created_at',
                value: project.createdAt.toIso8601String(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.theme,
    required this.label,
    required this.value,
  });

  final ThemeData theme;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 4),
          SelectableText(
            value,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
