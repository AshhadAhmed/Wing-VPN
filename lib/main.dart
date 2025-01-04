import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:wing_vpn/providers/favourite_servers_provider.dart';
import 'package:wing_vpn/providers/language_page_radio_provider.dart';
import 'package:wing_vpn/providers/linear_progress_provider.dart';
import 'package:wing_vpn/providers/premium_page_radio_provider.dart';
import 'package:wing_vpn/providers/vpn_provider.dart';
import 'package:wing_vpn/router/routes_config.dart';

void main() async {
  try {
    await GetStorage.init();
  } catch (e) {
    debugPrint("Error initializing GetStorage: $e");
    exit(0);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LinearProgressProvider()),
        ChangeNotifierProvider(create: (_) => VpnProvider()),
        ChangeNotifierProvider(create: (_) => PremiumPageRadioProvider()),
        ChangeNotifierProvider(create: (_) => FavouriteServersProvider()),
        ChangeNotifierProvider(create: (_) => LanguagePageRadioProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0XFF10172A),
        appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.blue.shade200,
          selectionHandleColor: Colors.blue.shade200,
        ),
        tooltipTheme: TooltipThemeData(
          preferBelow: false,
          textStyle: TextStyle(
            fontSize: 13.0,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          decoration: BoxDecoration(color: Color.fromARGB(255, 93, 89, 84)),
        ),
      ),
      routerConfig: RoutesConfig.router,
    );
  }
}
