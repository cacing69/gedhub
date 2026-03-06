import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gedhub/core/app_providers.dart';
import 'package:gedhub/core/router/app_router.dart';
import 'package:gedhub/core/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: GedhubApp(),
    ),
  );
}

final _goRouter = createAppRouter();

class GedhubApp extends ConsumerWidget {
  const GedhubApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      routerConfig: _goRouter,
      title: 'GedHub',
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      builder: (context, child) => DevtoolsGestureOverlay(child: child ?? const SizedBox()),
    );
  }
}

/// Long-press di mana saja untuk membuka Dev Tools (route /devtools).
class DevtoolsGestureOverlay extends StatelessWidget {
  const DevtoolsGestureOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: () => _goRouter.push('/devtools'),
      child: child,
    );
  }
}
