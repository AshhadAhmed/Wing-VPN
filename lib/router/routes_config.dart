import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/routes.dart';
import '../views/connection_report_page.dart';
import '../views/get_started_page.dart';
import '../views/language_selection_page.dart';
import '../views/home_page.dart';
import '../views/premium_page.dart';
import '../views/servers_page.dart';
import '../views/settings_page.dart';
import '../views/splash_screen.dart';
import '../views/version_page.dart';

class RoutesConfig {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        name: "splash",
        path: AppRoutes.splash,
        pageBuilder: (context, state) => CupertinoPage(
          canPop: false,
          key: state.pageKey,
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        name: "get_started",
        path: AppRoutes.getStarted,
        pageBuilder: (context, state) => CupertinoPage(
          canPop: false,
          key: state.pageKey,
          child: GetStartedScreen(),
        ),
      ),
      GoRoute(
        name: "home",
        path: AppRoutes.home,
        pageBuilder: (context, state) => CupertinoPage(
          canPop: false,
          key: state.pageKey,
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        name: "premium",
        path: AppRoutes.premium,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: PremiumScreen(),
        ),
      ),
      GoRoute(
        name: "settings",
        path: AppRoutes.settings,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: SettingsScreen(),
        ),
      ),
      GoRoute(
        name: "connection_report",
        path: AppRoutes.connectionReport,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: ConnectionReportScreen(),
        ),
      ),
      GoRoute(
        name: "servers",
        path: AppRoutes.servers,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: ServersScreen(),
        ),
      ),
      GoRoute(
        name: "language",
        path: AppRoutes.language,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: LanguageSelectionScreen(),
        ),
      ),
      GoRoute(
        name: "version",
        path: AppRoutes.version,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: VersionScreen(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => CupertinoPage(
      key: state.pageKey,
      child: Scaffold(
        backgroundColor: Color(0XFFE3F9ED),
        body: Center(
          child: Image.asset("assets/images/404.png"),
        ),
      ),
    ),
  );
}
