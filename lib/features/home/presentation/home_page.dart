import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gedhub/core/app_providers.dart';
import 'package:gedhub/features/projects/domain/project.dart';

class HomePage extends HookConsumerWidget {
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
                          trailing: PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert),
                            onSelected: (value) {
                              if (value == 'edit') {
                                _showEditProjectDialog(context, ref, project);
                              } else if (value == 'delete') {
                                _showDeleteProjectDialog(context, ref, project);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.edit_outlined, size: 20),
                                    SizedBox(width: 8),
                                    Text('Edit'),
                                  ],
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.delete_outline, size: 20),
                                    SizedBox(width: 8),
                                    Text('Delete'),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
    final scaffoldContext = context;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Create New GEDCOM'),
        content: _CreateProjectFormContent(
          dialogContext: dialogContext,
          onSuccess: (newId) {
            ref.read(currentProjectIdProvider.notifier).select(newId);
            if (scaffoldContext.mounted) {
              ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                const SnackBar(
                  content: Text('Project GEDCOM baru berhasil dibuat.'),
                ),
              );
            }
          },
          onCancel: () => Navigator.of(dialogContext).pop(),
        ),
      ),
    );
  }

  Future<void> _showEditProjectDialog(
    BuildContext context,
    WidgetRef ref,
    Project project,
  ) async {
    final scaffoldContext = context;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Project'),
        content: _EditProjectFormContent(
          project: project,
          dialogContext: dialogContext,
          onSaved: () {
            if (scaffoldContext.mounted) {
              ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                const SnackBar(content: Text('Project berhasil diperbarui.')),
              );
            }
          },
          onCancel: () => Navigator.of(dialogContext).pop(),
        ),
      ),
    );
  }

  Future<void> _showDeleteProjectDialog(
    BuildContext context,
    WidgetRef ref,
    Project project,
  ) async {
    final scaffoldContext = context;
    final repo = ref.read(projectsRepositoryProvider);
    final currentId = ref.read(currentProjectIdProvider);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete project?'),
        content: Text(
          'Project "${project.name}" akan dihapus. Tindakan ini tidak dapat dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final result = await repo.deleteProject(project.id);
    result.fold(
      (f) {
        if (scaffoldContext.mounted) {
          ScaffoldMessenger.of(scaffoldContext).showSnackBar(
            SnackBar(content: Text('Gagal menghapus: ${f.message}')),
          );
        }
      },
      (deleted) {
        if (currentId == project.id) {
          ref.read(currentProjectIdProvider.notifier).select(null);
        }
        if (scaffoldContext.mounted) {
          ScaffoldMessenger.of(scaffoldContext).showSnackBar(
            SnackBar(
              content: Text(
                deleted
                    ? 'Project "${project.name}" telah dihapus.'
                    : 'Gagal menghapus project.',
              ),
            ),
          );
        }
      },
    );
  }
}

/// Form create project dengan controller dari hooks (auto-dispose saat dialog ditutup).
class _CreateProjectFormContent extends HookConsumerWidget {
  const _CreateProjectFormContent({
    required this.dialogContext,
    required this.onSuccess,
    required this.onCancel,
  });

  final BuildContext dialogContext;
  final void Function(int newId) onSuccess;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final localeController = useTextEditingController(text: 'id_ID');
    final repo = ref.read(projectsRepositoryProvider);

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              key: const Key('create_project_name'),
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Project name',
                hintText: 'Contoh: Keluarga Besar XYZ',
              ),
              maxLength: 200,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama project wajib diisi';
                }
                if (value.trim().length < 3) {
                  return 'Minimal 3 karakter';
                }
                if (value.trim().length > 200) {
                  return 'Maksimal 200 karakter';
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
              maxLength: 500,
              validator: (value) {
                if (value != null &&
                    value.trim().isNotEmpty &&
                    value.trim().length > 500) {
                  return 'Maksimal 500 karakter';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            _LocaleSelector(controller: localeController),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () async {
                    if (!(formKey.currentState?.validate() ?? false)) return;
                    final name = nameController.text.trim();
                    final description = descriptionController.text.trim();
                    final locale = localeController.text.trim();
                    final result = await repo.createProject(
                      name: name,
                      description:
                          description.isEmpty ? null : description,
                      locale: locale.isEmpty ? null : locale,
                    );
                    if (!context.mounted) return;
                    result.fold(
                      (f) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Gagal membuat project: ${f.message}')),
                      ),
                      (newId) {
                        Navigator.of(dialogContext).pop();
                        onSuccess(newId);
                      },
                    );
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Form edit project dengan controller dari hooks (auto-dispose saat dialog ditutup).
class _EditProjectFormContent extends HookConsumerWidget {
  const _EditProjectFormContent({
    required this.project,
    required this.dialogContext,
    required this.onSaved,
    required this.onCancel,
  });

  final Project project;
  final BuildContext dialogContext;
  final VoidCallback onSaved;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nameController = useTextEditingController(text: project.name);
    final descriptionController = useTextEditingController(
      text: project.description ?? '',
    );
    final localeController = useTextEditingController(
      text: project.locale ?? 'id_ID',
    );
    final repo = ref.read(projectsRepositoryProvider);

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              key: const Key('edit_project_name'),
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Project name',
                hintText: 'Contoh: Keluarga Besar XYZ',
              ),
              maxLength: 200,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama project wajib diisi';
                }
                if (value.trim().length < 3) {
                  return 'Minimal 3 karakter';
                }
                if (value.trim().length > 200) {
                  return 'Maksimal 200 karakter';
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
              maxLength: 500,
              validator: (value) {
                if (value != null &&
                    value.trim().isNotEmpty &&
                    value.trim().length > 500) {
                  return 'Maksimal 500 karakter';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            _LocaleSelector(controller: localeController),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () async {
                    if (!(formKey.currentState?.validate() ?? false)) return;
                    final name = nameController.text.trim();
                    final description = descriptionController.text.trim();
                    final locale = localeController.text.trim();
                    final result = await repo.updateProject(
                      project.id,
                      name: name,
                      description:
                          description.isEmpty ? null : description,
                      locale: locale.isEmpty ? null : locale,
                    );
                    if (!context.mounted) return;
                    result.fold(
                      (f) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Gagal memperbarui: ${f.message}'),
                        ),
                      ),
                      (updated) {
                        Navigator.of(dialogContext).pop();
                        if (updated) onSaved();
                      },
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Dropdown preset locale + opsi "Lainnya" dengan text field. Menggunakan hooks.
class _LocaleSelector extends HookWidget {
  const _LocaleSelector({required this.controller});

  final TextEditingController controller;

  static const List<String> _presets = ['id_ID', 'en_US', 'en_GB'];
  static const String _other = 'Lainnya';

  @override
  Widget build(BuildContext context) {
    final selectedPreset = useState<String?>(
      _presets.contains(controller.text) ? controller.text : null,
    );
    useEffect(() {
      void listener() {
        selectedPreset.value =
            _presets.contains(controller.text) ? controller.text : null;
      }
      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    final value = selectedPreset.value ?? _other;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButtonFormField<String>(
          value: value,
          decoration: const InputDecoration(
            labelText: 'Locale (optional)',
          ),
          items: [
            ..._presets.map(
              (p) => DropdownMenuItem(
                value: p,
                child: Text(p),
              ),
            ),
            const DropdownMenuItem(
              value: _other,
              child: Text(_other),
            ),
          ],
          onChanged: (v) {
            selectedPreset.value = v == _other ? null : v;
            if (selectedPreset.value != null) {
              controller.text = selectedPreset.value!;
            }
          },
        ),
        if (selectedPreset.value == null) ...[
          const SizedBox(height: 12),
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Locale custom',
              hintText: 'Misalnya: id_ID',
            ),
          ),
        ],
      ],
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
