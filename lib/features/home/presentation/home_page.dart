import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gedhub/core/app_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final projectsAsync = ref.watch(projectsStreamProvider);
    final currentProjectId = ref.watch(currentProjectIdProvider);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome to GEDHUB', style: theme.textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            'Mulai project silsilah baru atau kelola data GEDCOM Anda secara offline.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ActionChip(
                icon: Icons.add_circle_outline,
                label: 'Create',
                onTap: () => _showCreateProjectDialog(context, ref),
              ),
              _ActionChip(
                icon: Icons.file_open_outlined,
                label: 'Import',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Import GEDCOM belum diimplementasikan.'),
                    ),
                  );
                },
              ),
              _ActionChip(
                icon: Icons.upload_file_outlined,
                label: 'Export',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Export GEDCOM belum diimplementasikan.'),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Projects', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          projectsAsync.when(
            data: (projects) {
              if (projects.isEmpty) {
                return _SectionCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    child: Text(
                      'Belum ada project. Mulai dengan "Create New GEDCOM".',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return _SectionCard(
                child: Column(
                  children: projects
                      .map(
                        (project) => ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          leading: Icon(
                            currentProjectId == project.id
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            size: 20,
                            color: currentProjectId == project.id
                                ? theme.colorScheme.primary
                                : null,
                          ),
                          title: Text(project.name),
                          subtitle:
                              project.description != null &&
                                  project.description!.isNotEmpty
                              ? Text(
                                  project.description!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                                )
                              : null,
                          onTap: () {
                            ref
                                .read(currentProjectIdProvider.notifier)
                                .select(project.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Project aktif: ${project.name}'),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              );
            },
            loading: () => const _SectionCard(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: SizedBox(
                  height: 24,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
              ),
            ),
            error: (error, _) => _SectionCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Gagal memuat daftar project: $error',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateProjectDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final localeController = TextEditingController(text: 'id_ID');

    final repo = ref.read(projectsRepositoryProvider);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Create New GEDCOM'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Project name',
                      hintText: 'Contoh: Keluarga Besar XYZ',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama project wajib diisi';
                      }
                      if (value.trim().length < 3) {
                        return 'Minimal 3 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description (optional)',
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: localeController,
                    decoration: const InputDecoration(
                      labelText: 'Locale (optional)',
                      hintText: 'Misalnya: id_ID',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                if (!(formKey.currentState?.validate() ?? false)) {
                  return;
                }

                final name = nameController.text.trim();
                final description = descriptionController.text.trim();
                final locale = localeController.text.trim();

                try {
                  await repo.createProject(
                    name: name,
                    description: description.isEmpty ? null : description,
                    locale: locale.isEmpty ? null : locale,
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.of(dialogContext).pop();
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Project GEDCOM baru berhasil dibuat.'),
                    ),
                  );
                } catch (error) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal membuat project: $error')),
                  );
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}

/// Tombol aksi ringkas (icon + label) untuk menghemat ruang vertikal.
class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 6),
              Text(label, style: theme.textTheme.labelMedium),
            ],
          ),
        ),
      ),
    );
  }
}

/// Container section dengan border & radius konsisten (shadcn-style).
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
