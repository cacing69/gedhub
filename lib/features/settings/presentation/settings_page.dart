import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gedhub/core/app_providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final notifier = ref.read(themeModeProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Settings',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            'Pengaturan tampilan dan preferensi aplikasi.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Tampilan',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<ThemeMode>(
            value: themeMode,
            decoration: InputDecoration(
              labelText: 'Tema',
              hintText: 'Ikuti perangkat',
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Text('Ikuti perangkat'),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Text('Terang'),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Text('Gelap'),
              ),
            ],
            onChanged: (value) {
              if (value != null) notifier.setThemeMode(value);
            },
          ),
        ],
      ),
    );
  }
}
