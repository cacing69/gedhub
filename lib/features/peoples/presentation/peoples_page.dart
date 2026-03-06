import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gedhub/core/app_providers.dart';
import 'package:gedhub/core/router/app_router.dart';
import 'package:gedhub/features/peoples/domain/person.dart';
import 'package:gedhub/features/peoples/presentation/widgets/peoples_widgets.dart';
import 'package:go_router/go_router.dart';

/// Tab Peoples: daftar orang, cari, filter gender, buka edit/create.
class PeoplesPage extends HookConsumerWidget {
  const PeoplesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final personsAsync = ref.watch(personsStreamProvider);
    final searchText = useState('');
    final genderFilter = useState<String?>(null);

    final filteredPersons = useMemoized(() {
      final list = personsAsync.value;
      if (list == null) return null;
      var result = list;
      if (genderFilter.value != null && genderFilter.value!.isNotEmpty) {
        result = result.where((p) => p.gender == genderFilter.value).toList();
      }
      final query = searchText.value.trim().toLowerCase();
      if (query.isNotEmpty) {
        result = result
            .where((p) =>
                p.fullName.toLowerCase().contains(query) ||
                p.surname.toLowerCase().contains(query))
            .toList();
      }
      return result;
    }, [personsAsync, searchText.value, genderFilter.value]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peoples'),
      ),
      body: CustomScrollView(
        slivers: [
          _SearchAndFilters(
            onSearchChanged: (v) => searchText.value = v,
            genderFilter: genderFilter.value,
            onGenderFilterChanged: (v) => genderFilter.value = v,
          ),
          personsAsync.when(
            data: (_) {
              final list = filteredPersons;
              if (list == null || list.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: _EmptyState(
                    hasFilter: searchText.value.isNotEmpty ||
                        (genderFilter.value != null && genderFilter.value!.isNotEmpty),
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final person = list[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: PersonListTile(
                          person: person,
                          onTap: () => _openEdit(context, person),
                          onEdit: () => _openEdit(context, person),
                          onDelete: () => _showDeletePersonDialog(context, ref, person),
                        ),
                      );
                    },
                    childCount: list.length,
                  ),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            error: (error, _) => SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error_outline, size: 48, color: theme.colorScheme.error),
                      const SizedBox(height: 16),
                      Text(
                        'Gagal memuat data',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$error',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push<bool>(AppRoutes.personForm),
        tooltip: 'Tambah Orang',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openEdit(BuildContext context, Person person) {
    context.push<bool>(AppRoutes.personEdit, extra: person);
  }

  Future<void> _showDeletePersonDialog(
    BuildContext context,
    WidgetRef ref,
    Person person,
  ) async {
    final scaffoldContext = context;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus orang?'),
        content: Text('Hapus "${person.fullName}" dari daftar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final result = await ref.read(personsRepositoryProvider).deletePerson(person.id);
    result.fold(
      (f) {
        if (scaffoldContext.mounted) {
          ScaffoldMessenger.of(scaffoldContext).showSnackBar(
            SnackBar(content: Text('Gagal menghapus: ${f.message}')),
          );
        }
      },
      (deleted) {
        if (scaffoldContext.mounted) {
          ScaffoldMessenger.of(scaffoldContext).showSnackBar(
            SnackBar(
              content: Text(
                deleted ? '${person.fullName} telah dihapus.' : 'Gagal menghapus.',
              ),
            ),
          );
        }
      },
    );
  }
}

/// Baris search + filter gender (minimal).
class _SearchAndFilters extends StatelessWidget {
  const _SearchAndFilters({
    required this.onSearchChanged,
    required this.genderFilter,
    required this.onGenderFilterChanged,
  });

  final ValueChanged<String> onSearchChanged;
  final String? genderFilter;
  final ValueChanged<String?> onGenderFilterChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAll = genderFilter == null || (genderFilter?.isEmpty ?? true);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Cari nama...',
                prefixIcon: const Icon(Icons.search, size: 22),
                isDense: true,
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterChipChoice(
                  label: 'Semua',
                  isSelected: isAll,
                  onSelected: () => onGenderFilterChanged(null),
                ),
                FilterChipChoice(
                  label: 'Laki-laki',
                  isSelected: genderFilter == 'M',
                  onSelected: () => onGenderFilterChanged('M'),
                ),
                FilterChipChoice(
                  label: 'Perempuan',
                  isSelected: genderFilter == 'F',
                  onSelected: () => onGenderFilterChanged('F'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Tampilan saat daftar kosong atau tidak ada hasil filter.
class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.hasFilter});

  final bool hasFilter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasFilter ? Icons.person_search_outlined : Icons.people_outline,
              size: 56,
              color: theme.colorScheme.outline.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              hasFilter
                  ? 'Tidak ada yang cocok dengan filter.'
                  : 'Belum ada orang.\nTekan + untuk menambah.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

