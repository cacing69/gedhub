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
    final scaffoldContext = context;
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final localeController = TextEditingController(text: 'id_ID');

    final repo = ref.read(projectsRepositoryProvider);

    try {
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
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
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
                    final newId = await repo.createProject(
                      name: name,
                      description:
                          description.isEmpty ? null : description,
                      locale: locale.isEmpty ? null : locale,
                    );
                    if (!context.mounted) return;
                    Navigator.of(dialogContext).pop();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ref.read(currentProjectIdProvider.notifier).select(newId);
                      if (scaffoldContext.mounted) {
                        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Project GEDCOM baru berhasil dibuat.'),
                          ),
                        );
                      }
                    });
                  } catch (error) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Gagal membuat project: $error')),
                    );
                  }
                },
                child: const Text('Create'),
              ),
            ],
          );
        },
      );
    } finally {
      nameController.dispose();
      descriptionController.dispose();
      localeController.dispose();
    }
  }
}

/// Dropdown preset locale + opsi "Lainnya" dengan text field.
class _LocaleSelector extends StatefulWidget {
  const _LocaleSelector({required this.controller});

  final TextEditingController controller;

  static const List<String> _presets = ['id_ID', 'en_US', 'en_GB'];
  static const String _other = 'Lainnya';

  @override
  State<_LocaleSelector> createState() => _LocaleSelectorState();
}

class _LocaleSelectorState extends State<_LocaleSelector> {
  String? _selectedPreset;

  @override
  void initState() {
    super.initState();
    _selectedPreset = _LocaleSelector._presets.contains(widget.controller.text)
        ? widget.controller.text
        : null;
    widget.controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (!mounted) return;
    if (_LocaleSelector._presets.contains(widget.controller.text)) {
      setState(() => _selectedPreset = widget.controller.text);
    } else {
      setState(() => _selectedPreset = null);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = _selectedPreset ?? _LocaleSelector._other;
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
            ..._LocaleSelector._presets
                .map(
                  (p) => DropdownMenuItem(
                    value: p,
                    child: Text(p),
                  ),
                )
                .toList(),
            const DropdownMenuItem(
              value: _LocaleSelector._other,
              child: Text(_LocaleSelector._other),
            ),
          ],
          onChanged: (v) {
            setState(() {
              _selectedPreset =
                  v == _LocaleSelector._other ? null : v;
              if (_selectedPreset != null) {
                widget.controller.text = _selectedPreset!;
              }
            });
          },
        ),
        if (_selectedPreset == null) ...[
          const SizedBox(height: 12),
          TextFormField(
            controller: widget.controller,
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
