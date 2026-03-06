import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gedhub/core/app_providers.dart';
import 'package:gedhub/features/peoples/domain/person.dart';
import 'package:gedhub/features/peoples/domain/person_relation.dart';
import 'package:go_router/go_router.dart';

/// Satu halaman form reusable untuk **create** dan **edit** person.
/// [person] null = mode tambah, non-null = mode edit (termasuk section Kontak).
class PersonFormPage extends HookConsumerWidget {
  const PersonFormPage({super.key, this.person});

  /// Null = create, non-null = edit.
  final Person? person;

  bool get _isEdit => person != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final projectId = ref.watch(currentProjectIdProvider);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nameController = useTextEditingController(text: person?.givenName ?? '');
    final surnameController = useTextEditingController(text: person?.surname ?? '');
    final nicknameController = useTextEditingController(text: person?.nickname ?? '');
    final genderValue = useState<String>(person?.gender ?? 'U');
    final birthDateController = useTextEditingController(text: person?.birthDate ?? '');
    final deathDateController = useTextEditingController(text: person?.deathDate ?? '');
    final isLiving = useState(person?.isLiving ?? true);
    final notesController = useTextEditingController(text: person?.notes ?? '');

    final canSaveCreate = !_isEdit && projectId != null;
    final canSaveEdit = _isEdit;

    Future<void> onSave() async {
      if (formKey.currentState?.validate() != true) return;
      final repo = ref.read(personsRepositoryProvider);
      if (_isEdit && person != null) {
        final result = await repo.updatePerson(
          person!.id,
          givenName: nameController.text.trim(),
          surname: surnameController.text.trim(),
          nickname: _opt(nicknameController.text),
          gender: genderValue.value.isEmpty ? 'U' : genderValue.value,
          birthDate: _opt(birthDateController.text),
          deathDate: _opt(deathDateController.text),
          isLiving: isLiving.value,
          notes: _opt(notesController.text),
        );
        result.fold(
          (f) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal memperbarui: ${f.message}')),
          ),
          (_) {
            context.pop(true);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Orang berhasil diperbarui.')),
            );
          },
        );
      } else if (!_isEdit && projectId != null) {
        final result = await repo.createPerson(
          projectId: projectId,
          givenName: nameController.text.trim(),
          surname: surnameController.text.trim(),
          nickname: _opt(nicknameController.text),
          gender: genderValue.value.isEmpty ? 'U' : genderValue.value,
          birthDate: _opt(birthDateController.text),
          deathDate: _opt(deathDateController.text),
          isLiving: isLiving.value,
          notes: _opt(notesController.text),
        );
        result.fold(
          (f) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menambahkan: ${f.message}')),
          ),
          (_) {
            context.pop(true);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Orang berhasil ditambahkan.')),
            );
          },
        );
      }
    }

    final canSave = _isEdit ? canSaveEdit : canSaveCreate;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit: ${person!.fullName}' : 'Tambah Orang'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Batal'),
          ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: canSave ? onSave : null,
            child: const Text('Simpan'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          if (!_isEdit && projectId == null) _NoProjectBanner(theme: theme),
          Expanded(
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                children: [
                  if (_isEdit) ...[
                    Text(
                      'Kontak',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _PersonContactsSection(personId: person!.id, projectId: person!.projectId),
                    const SizedBox(height: 24),
                    Text(
                      'Relasi',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _PersonRelationsSection(personId: person!.id, projectId: person!.projectId),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      'Informasi Dasar',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nama Depan',
                      hintText: _isEdit ? null : 'Mis. Budi',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Nama depan wajib diisi';
                      if (value.trim().length < 2) return 'Minimal 2 karakter';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: surnameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Belakang (Opsional)',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: nicknameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Panggilan (Opsional)',
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: genderValue.value,
                    decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
                    items: const [
                      DropdownMenuItem(value: 'M', child: Text('Laki-laki')),
                      DropdownMenuItem(value: 'F', child: Text('Perempuan')),
                      DropdownMenuItem(value: 'U', child: Text('Tidak Diketahui')),
                    ],
                    onChanged: canSave ? (value) => genderValue.value = value ?? 'U' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: birthDateController,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Lahir (YYYY-MM-DD)',
                      hintText: 'Opsional',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: deathDateController,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Wafat (YYYY-MM-DD)',
                      hintText: 'Opsional',
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  SwitchListTile(
                    title: const Text('Masih Hidup?'),
                    value: isLiving.value,
                    onChanged: canSave ? (value) => isLiving.value = value : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: notesController,
                    decoration: const InputDecoration(
                      labelText: 'Catatan',
                      hintText: 'Opsional',
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String? _opt(String s) {
    final t = s.trim();
    return t.isEmpty ? null : t;
  }
}

class _NoProjectBanner extends StatelessWidget {
  const _NoProjectBanner({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: theme.colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: theme.colorScheme.onErrorContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Pilih project dulu dari tab Home.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Section daftar kontak (hanya dipakai di mode edit).
class _PersonContactsSection extends HookConsumerWidget {
  const _PersonContactsSection({
    required this.personId,
    required this.projectId,
  });

  final int personId;
  final int projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(contactsStreamProviderProvider(personId));
    return contactsAsync.when(
      data: (contacts) {
        if (contacts.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Belum ada kontak.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                fontSize: 14,
              ),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...contacts.map(
              (contact) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(contact.value),
                subtitle: Text('${contact.provider} — ${contact.contactType}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      tooltip: 'Edit Kontak',
                      onPressed: () => _showEditContactDialog(context, ref, contact),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20),
                      tooltip: 'Hapus Kontak',
                      onPressed: () => _showDeleteContactDialog(context, ref, contact),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: () => _showCreateContactDialog(context, ref, personId, projectId),
              icon: const Icon(Icons.add),
              label: const Text('Tambah Kontak'),
            ),
          ],
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
      error: (_, __) => const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Gagal memuat kontak.'),
      ),
    );
  }

  Future<void> _showCreateContactDialog(
    BuildContext context,
    WidgetRef ref,
    int personId,
    int projectId,
  ) async {
    final scaffoldContext = context;
    await showDialog<void>(
      context: context,
      builder: (_) => _CreateContactDialog(
        ref: ref,
        personId: personId,
        projectId: projectId,
        onSaved: () {
          if (scaffoldContext.mounted) {
            ScaffoldMessenger.of(scaffoldContext).showSnackBar(
              const SnackBar(content: Text('Kontak berhasil ditambahkan.')),
            );
          }
        },
      ),
    );
  }

  Future<void> _showEditContactDialog(
    BuildContext context,
    WidgetRef ref,
    Contact contact,
  ) async {
    final scaffoldContext = context;
    await showDialog<void>(
      context: context,
      builder: (_) => _EditContactDialog(
        ref: ref,
        contact: contact,
        onSaved: () {
          if (scaffoldContext.mounted) {
            ScaffoldMessenger.of(scaffoldContext).showSnackBar(
              const SnackBar(content: Text('Kontak berhasil diperbarui.')),
            );
          }
        },
      ),
    );
  }

  Future<void> _showDeleteContactDialog(
    BuildContext context,
    WidgetRef ref,
    Contact contact,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Kontak?'),
        content: Text('Hapus kontak "${contact.value}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final result = await ref.read(contactsRepositoryProvider).deleteContact(contact.id);
    result.fold(
      (f) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menghapus: ${f.message}')),
          );
        }
      },
      (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kontak telah dihapus.')),
          );
        }
      },
    );
  }
}

/// Section daftar relasi (hanya di mode edit): tampil, tambah, lepas.
class _PersonRelationsSection extends HookConsumerWidget {
  const _PersonRelationsSection({
    required this.personId,
    required this.projectId,
  });

  final int personId;
  final int projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(personRelationDisplaysStreamProvider(personId));
    return async.when(
      data: (displays) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (displays.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Belum ada relasi. Tambah orang tua, anak, pasangan, atau saudara.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              )
            else
              ...displays.map(
                (d) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('${d.label}: ${d.otherPerson.fullName}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.link_off, size: 20),
                    tooltip: 'Lepas relasi',
                    onPressed: () => _removeRelation(context, ref, d.relation),
                  ),
                ),
              ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: () => _showAddRelation(context, ref),
              icon: const Icon(Icons.add_link),
              label: const Text('Tambah Relasi'),
            ),
          ],
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))),
      ),
      error: (_, __) => const Padding(padding: EdgeInsets.all(16), child: Text('Gagal memuat relasi.')),
    );
  }

  Future<void> _removeRelation(BuildContext context, WidgetRef ref, PersonRelation relation) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Lepas relasi?'),
        content: const Text('Relasi ini akan dilepas. Orang tetap ada di daftar.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Batal')),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error),
            child: const Text('Lepas'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final result = await ref.read(personRelationsRepositoryProvider).removeRelation(relation.id);
    result.fold(
      (f) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal melepas relasi: ${f.message}')));
        }
      },
      (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Relasi dilepas.')));
        }
      },
    );
  }

  Future<void> _showAddRelation(BuildContext context, WidgetRef ref) async {
    final scaffoldContext = context;
    await showDialog<void>(
      context: context,
      builder: (_) => _AddRelationDialog(
        ref: ref,
        personId: personId,
        projectId: projectId,
        onSaved: () {
          if (scaffoldContext.mounted) {
            ScaffoldMessenger.of(scaffoldContext).showSnackBar(
              const SnackBar(content: Text('Relasi berhasil ditambahkan.')),
            );
          }
        },
      ),
    );
  }
}

/// Role relasi di dialog: Orang tua (selected = parent), Anak (selected = child), Pasangan, Saudara.
enum _RelationRole { parentAsParent, parentAsChild, spouse, sibling }

/// Dialog: pilih jenis relasi → pilih orang yang ada atau tambah orang baru.
class _AddRelationDialog extends HookConsumerWidget {
  const _AddRelationDialog({
    required this.ref,
    required this.personId,
    required this.projectId,
    required this.onSaved,
  });

  final WidgetRef ref;
  final int personId;
  final int projectId;
  final VoidCallback onSaved;

  static const List<({_RelationRole role, String label})> _roleOptions = [
    (role: _RelationRole.parentAsParent, label: 'Orang tua'),
    (role: _RelationRole.parentAsChild, label: 'Anak'),
    (role: _RelationRole.spouse, label: 'Pasangan'),
    (role: _RelationRole.sibling, label: 'Saudara'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleIndex = useState(0);
    final role = _roleOptions[roleIndex.value].role;
    final personsAsync = ref.watch(personsStreamProvider);
    final allPersons = personsAsync.when(
      data: (d) => d,
      loading: () => <Person>[],
      error: (_, __) => <Person>[],
    );
    return AlertDialog(
      title: const Text('Tambah Relasi'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Jenis relasi:', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          DropdownButtonFormField<int>(
            value: roleIndex.value,
            decoration: const InputDecoration(labelText: 'Relasi'),
            items: _roleOptions.asMap().entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value.label))).toList(),
            onChanged: (v) => roleIndex.value = v ?? 0,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _pickExistingPerson(context, ref, role, allPersons),
            icon: const Icon(Icons.person_search),
            label: const Text('Pilih orang yang sudah ada'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () => _addNewPersonAndLink(context, ref, role),
            icon: const Icon(Icons.person_add),
            label: const Text('Tambah orang baru lalu hubungkan'),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => context.pop(), child: const Text('Batal')),
      ],
    );
  }

  Future<void> _pickExistingPerson(BuildContext context, WidgetRef ref, _RelationRole role, List<Person> allPersons) async {
    final others = allPersons.where((p) => p.id != personId).toList();
    if (!context.mounted) return;
    if (others.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak ada orang lain di project ini. Tambah orang dulu atau pilih "Tambah orang baru".')),
      );
      return;
    }
    final selected = await showDialog<Person>(
      context: context,
      builder: (ctx) => _SelectPersonDialog(persons: others),
    );
    if (selected == null || !context.mounted) return;
    final (relPersonId, relRelatedId, kind) = _relationParams(selected.id, role);
    final result = await ref.read(personRelationsRepositoryProvider).addRelation(
          projectId: projectId,
          personId: relPersonId,
          relatedPersonId: relRelatedId,
          kind: kind,
        );
    result.fold(
      (f) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menambahkan relasi: ${f.message}'))),
      (_) {
        context.pop();
        onSaved();
      },
    );
  }

  /// (personId, relatedPersonId, kind) for DB. parent: personId=parent, relatedPersonId=child.
  (int, int, String) _relationParams(int selectedId, _RelationRole role) {
    switch (role) {
      case _RelationRole.parentAsParent:
        return (selectedId, personId, PersonRelationKind.parent.value);
      case _RelationRole.parentAsChild:
        return (personId, selectedId, PersonRelationKind.parent.value);
      case _RelationRole.spouse:
        return (personId, selectedId, PersonRelationKind.spouse.value);
      case _RelationRole.sibling:
        return (personId, selectedId, PersonRelationKind.sibling.value);
    }
  }

  Future<void> _addNewPersonAndLink(BuildContext context, WidgetRef ref, _RelationRole role) async {
    final created = await showDialog<Person?>(
      context: context,
      builder: (ctx) => _QuickAddPersonDialog(projectId: projectId, ref: ref),
    );
    if (created == null || !context.mounted) return;
    final (relPersonId, relRelatedId, kind) = _relationParams(created.id, role);
    final result = await ref.read(personRelationsRepositoryProvider).addRelation(
          projectId: projectId,
          personId: relPersonId,
          relatedPersonId: relRelatedId,
          kind: kind,
        );
    result.fold(
      (f) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Relasi gagal: ${f.message}'))),
      (_) {
        context.pop();
        onSaved();
      },
    );
  }
}

/// Daftar person untuk dipilih (untuk relasi).
class _SelectPersonDialog extends StatelessWidget {
  const _SelectPersonDialog({required this.persons});

  final List<Person> persons;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pilih Orang'),
      content: SizedBox(
        width: 320,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: persons.length,
          itemBuilder: (ctx, i) {
            final p = persons[i];
            return ListTile(
              title: Text(p.fullName),
              onTap: () => Navigator.of(ctx).pop(p),
            );
          },
        ),
      ),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal'))],
    );
  }
}

/// Dialog minimal: nama depan + belakang → create person, return Person.
class _QuickAddPersonDialog extends HookConsumerWidget {
  const _QuickAddPersonDialog({required this.projectId, required this.ref});

  final int projectId;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final givenController = useTextEditingController();
    final surnameController = useTextEditingController();
    return AlertDialog(
      title: const Text('Tambah Orang Baru'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: givenController,
              decoration: const InputDecoration(labelText: 'Nama Depan'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: surnameController,
              decoration: const InputDecoration(labelText: 'Nama Belakang'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal')),
        FilledButton(
          onPressed: () async {
            if (formKey.currentState?.validate() != true) return;
            final result = await ref.read(personsRepositoryProvider).createPerson(
                  projectId: projectId,
                  givenName: givenController.text.trim(),
                  surname: surnameController.text.trim().isEmpty ? '-' : surnameController.text.trim(),
                );
            if (!context.mounted) return;
            result.fold(
              (f) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal: ${f.message}'))),
              (newId) async {
                final getResult = await ref.read(personsRepositoryProvider).getPersonById(newId);
                getResult.fold(
                  (_) => Navigator.of(context).pop(),
                  (p) => Navigator.of(context).pop(p),
                );
              },
            );
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}

class _CreateContactDialog extends HookConsumerWidget {
  const _CreateContactDialog({
    required this.ref,
    required this.personId,
    required this.projectId,
    required this.onSaved,
  });

  final WidgetRef ref;
  final int personId;
  final int projectId;
  final VoidCallback onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final providerValue = useState('manual');
    final typeValue = useState('phone');
    final valueController = useTextEditingController();
    final labelController = useTextEditingController();

    return AlertDialog(
      title: const Text('Tambah Kontak'),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: providerValue.value,
                decoration: const InputDecoration(labelText: 'Provider'),
                items: const [
                  DropdownMenuItem(value: 'manual', child: Text('Manual')),
                  DropdownMenuItem(value: 'contact_picker', child: Text('Contact Picker')),
                ],
                onChanged: (value) => providerValue.value = value ?? 'manual',
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: typeValue.value,
                decoration: const InputDecoration(labelText: 'Tipe Kontak'),
                items: const [
                  DropdownMenuItem(value: 'phone', child: Text('Telepon')),
                  DropdownMenuItem(value: 'email', child: Text('Email')),
                  DropdownMenuItem(value: 'url', child: Text('URL')),
                  DropdownMenuItem(value: 'other', child: Text('Lainnya')),
                ],
                onChanged: (value) => typeValue.value = value ?? 'phone',
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: valueController,
                decoration: const InputDecoration(labelText: 'Nilai'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Nilai wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: labelController,
                decoration: const InputDecoration(labelText: 'Label (Opsional)'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: () async {
            if (formKey.currentState?.validate() != true) return;
            final result = await ref.read(contactsRepositoryProvider).createContact(
                  projectId: projectId,
                  personId: personId,
                  provider: providerValue.value,
                  contactType: typeValue.value,
                  value: valueController.text.trim(),
                  label: labelController.text.trim().isEmpty
                      ? null
                      : labelController.text.trim(),
                );
            result.fold(
              (f) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gagal menambahkan: ${f.message}')),
              ),
              (_) {
                context.pop();
                onSaved();
              },
            );
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}

class _EditContactDialog extends HookConsumerWidget {
  const _EditContactDialog({
    required this.ref,
    required this.contact,
    required this.onSaved,
  });

  final WidgetRef ref;
  final Contact contact;
  final VoidCallback onSaved;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final typeValue = useState(contact.contactType);
    final valueController = useTextEditingController(text: contact.value);
    final labelController = useTextEditingController(text: contact.label ?? '');

    return AlertDialog(
      title: const Text('Edit Kontak'),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: contact.provider,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Provider'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: typeValue.value,
                decoration: const InputDecoration(labelText: 'Tipe Kontak'),
                items: const [
                  DropdownMenuItem(value: 'phone', child: Text('Telepon')),
                  DropdownMenuItem(value: 'email', child: Text('Email')),
                  DropdownMenuItem(value: 'url', child: Text('URL')),
                  DropdownMenuItem(value: 'other', child: Text('Lainnya')),
                ],
                onChanged: (value) => typeValue.value = value ?? 'phone',
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: valueController,
                decoration: const InputDecoration(labelText: 'Nilai'),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Nilai wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: labelController,
                decoration: const InputDecoration(labelText: 'Label (Opsional)'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: () async {
            if (formKey.currentState?.validate() != true) return;
            final result = await ref.read(contactsRepositoryProvider).updateContact(
                  contact.id,
                  provider: contact.provider,
                  contactType: typeValue.value,
                  value: valueController.text.trim(),
                  label: labelController.text.trim().isEmpty
                      ? null
                      : labelController.text.trim(),
                );
            result.fold(
              (f) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gagal memperbarui: ${f.message}')),
              ),
              (_) {
                context.pop();
                onSaved();
              },
            );
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
