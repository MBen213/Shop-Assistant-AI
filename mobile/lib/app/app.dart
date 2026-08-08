import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';

import '../features/app_settings/presentation/providers/app_settings_provider.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

class ShopAssistantApp extends StatelessWidget {
  const ShopAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, settings, _) {
        return MaterialApp(
          title: 'Shop Assistant AI',
          debugShowCheckedModeBanner: false,

          // ==================================================
          // THEME
          // ==================================================

          theme: AppTheme.lightTheme,
          darkTheme: ThemeData.dark(),
          themeMode: settings.flutterThemeMode,

          // ==================================================
          // LANGUAGE
          // ==================================================

          locale: settings.locale,

          supportedLocales: const [
            Locale('en'),
            Locale('fr'),
            Locale('ar'),
          ],

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // ==================================================
          // ROUTING
          // ==================================================

          initialRoute: AppRouter.splash,
          routes: AppRouter.routes,
        );
      },
    );
  }
}