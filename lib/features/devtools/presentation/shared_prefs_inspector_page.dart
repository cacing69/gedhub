import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gedhub/core/app_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Menampilkan key-value SharedPreferences yang tersimpan (nama key + nilai).
class SharedPrefsInspectorPage extends ConsumerWidget {
  const SharedPrefsInspectorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final prefsAsync = ref.watch(sharedPreferencesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Prefs'),
      ),
      body: prefsAsync.when(
        data: (prefs) {
          List<_PrefEntry> entries;
          try {
            entries = _readEntries(prefs);
          } catch (e) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Gagal baca SharedPreferences: $e',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            );
          }
          if (entries.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Belum ada data tersimpan di SharedPreferences.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  '${entries.length} key(s) tersimpan',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ),
              ...entries.map(
                (e) => _PrefTile(
                  theme: theme,
                  keyName: e.key,
                  value: e.value,
                  onTap: () => _showValueBottomSheet(context, theme, e.key, e.value),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Gagal memuat: $err',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<_PrefEntry> _readEntries(SharedPreferences prefs) {
    final entries = <_PrefEntry>[];
    for (final key in prefs.getKeys()) {
      final value = _getValueString(prefs, key);
      if (value != null) {
        entries.add(_PrefEntry(key: key, value: value));
      }
    }
    entries.sort((a, b) => a.key.compareTo(b.key));
    return entries;
  }

  /// Baca nilai sebagai string. Coba tiap tipe dalam try-catch karena di beberapa
  /// platform getString(key) bisa throw jika nilai disimpan sebagai int/bool.
  String? _getValueString(SharedPreferences prefs, String key) {
    try {
      final i = prefs.getInt(key);
      if (i != null) return i.toString();
    } catch (_) {}
    try {
      final str = prefs.getString(key);
      if (str != null) return str;
    } catch (_) {}
    try {
      final b = prefs.getBool(key);
      if (b != null) return b.toString();
    } catch (_) {}
    try {
      final d = prefs.getDouble(key);
      if (d != null) return d.toString();
    } catch (_) {}
    try {
      final list = prefs.getStringList(key);
      if (list != null) return list.join(', ');
    } catch (_) {}
    return null;
  }

  void _showValueBottomSheet(
    BuildContext context,
    ThemeData theme,
    String key,
    String value,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                key,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
              SelectableText(value, style: theme.textTheme.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrefEntry {
  const _PrefEntry({required this.key, required this.value});
  final String key;
  final String value;
}

class _PrefTile extends StatelessWidget {
  const _PrefTile({
    required this.theme,
    required this.keyName,
    required this.value,
    required this.onTap,
  });

  final ThemeData theme;
  final String keyName;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(keyName, style: theme.textTheme.titleSmall),
        subtitle: Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
