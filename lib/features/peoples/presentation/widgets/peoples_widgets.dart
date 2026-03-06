import 'package:flutter/material.dart';
import 'package:gedhub/features/peoples/domain/person.dart';

/// Format tahun dari string date (YYYY-MM-DD atau parsable); return null jika invalid.
String? formatPersonYear(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return null;
  try {
    final date = DateTime.parse(dateStr);
    return date.year.toString();
  } catch (_) {
    return dateStr;
  }
}

/// Icon gender berdasarkan string gender (M/F/U).
class GenderIcon extends StatelessWidget {
  const GenderIcon(this.gender, this.theme, {super.key});

  final String? gender;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color? color;
    switch (gender) {
      case 'M':
        iconData = Icons.male;
        color = theme.colorScheme.primary;
        break;
      case 'F':
        iconData = Icons.female;
        color = Colors.pink;
        break;
      default:
        iconData = Icons.help_outline;
        color = theme.colorScheme.onSurface.withOpacity(0.5);
        break;
    }
    return Icon(iconData, color: color, size: 20);
  }
}

/// Satu baris daftar person dengan menu Edit/Hapus.
class PersonListTile extends StatelessWidget {
  const PersonListTile({
    super.key,
    required this.person,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  final Person person;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        leading: GenderIcon(person.gender, theme),
        title: Text(person.fullName, style: theme.textTheme.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (person.nickname != null && person.nickname!.isNotEmpty)
              Text('(${person.nickname})', style: theme.textTheme.bodySmall),
            Row(
              children: [
                Text(
                  formatPersonYear(person.birthDate) ?? '—',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                if (person.deathDate != null) ...[
                  const Text(' - ', style: TextStyle(color: Colors.grey)),
                  Text(
                    formatPersonYear(person.deathDate) ?? '—',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') onEdit();
            if (value == 'delete') onDelete();
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
                  Text('Hapus'),
                ],
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

/// Filter chip untuk Peoples (Semua / Laki-laki / Perempuan).
class FilterChipChoice extends StatelessWidget {
  const FilterChipChoice({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      checkmarkColor: isSelected ? theme.colorScheme.primary : null,
    );
  }
}
