import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:wing_vpn/pages/connection_report_page.dart';
import 'package:wing_vpn/pages/getting_started_page.dart';
import 'package:wing_vpn/pages/language_selection_page.dart';
import 'package:wing_vpn/pages/main_page.dart';
import 'package:wing_vpn/pages/premium_page.dart';
import 'package:wing_vpn/pages/servers_page.dart';
import 'package:wing_vpn/pages/settings_page.dart';
import 'package:wing_vpn/pages/splash_screen.dart';
import 'package:wing_vpn/pages/version_page.dart';
import 'package:wing_vpn/providers/check_box_provider.dart';
import 'package:wing_vpn/providers/favourite_servers_provider.dart';
import 'package:wing_vpn/providers/language_page_radio_provider.dart';
import 'package:wing_vpn/providers/linear_progress_provider.dart';
import 'package:wing_vpn/providers/premium_page_radio_provider.dart';
import 'package:wing_vpn/providers/vpn_provider.dart';

void main() async {
  if (Platform.isAndroid) {
    await GetStorage.init();

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LinearProgressProvider()),
        ChangeNotifierProvider(create: (_) => VpnProvider()),
        ChangeNotifierProvider(create: (_) => CheckBoxProvider()),
        ChangeNotifierProvider(create: (_) => PremiumPageRadioProvider()),
        ChangeNotifierProvider(create: (_) => FavouriteServersProvider()),
        ChangeNotifierProvider(create: (_) => LanguagePageRadioProvider()),
      ],
      child: const MyApp(),
    ));
  } else {
    exit(0);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case "/":
            return CupertinoPageRoute(
                builder: (_) => SplashScreen(), allowSnapshotting: false);
          case "/getting_started":
            return CupertinoPageRoute(builder: (_) => GettingStartedScreen());
          case "/main":
            return CupertinoPageRoute(builder: (_) => MainScreen());
          case "/premium":
            return CupertinoPageRoute(builder: (_) => PremiumScreen());
          case "/settings":
            return CupertinoPageRoute(builder: (_) => SettingsScreen());
          case "/connection":
            return CupertinoPageRoute(builder: (_) => ConnectionReportScreen());
          case "/servers":
            return CupertinoPageRoute(builder: (_) => ServersScreen());
          case "/language":
            return CupertinoPageRoute(
                builder: (_) => LanguageSelectionScreen());
          case "/version":
            return CupertinoPageRoute(builder: (_) => VersionScreen());
          default:
            return MaterialPageRoute(builder: (_) => SplashScreen());
        }
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0XFF10172A),
        appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
      ),
    );
  }
}
