import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import './providers/favourite_servers_provider.dart';
import './providers/language_page_radio_provider.dart';
import './providers/linear_progress_provider.dart';
import './providers/premium_page_radio_provider.dart';
import './providers/vpn_provider.dart';
import './router/routes_config.dart';

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
        ChangeNotifierProvider(
          lazy: true,
          create: (_) => LinearProgressProvider(),
        ),
        ChangeNotifierProvider(
          lazy: true,
          create: (_) => VpnProvider(),
        ),
        ChangeNotifierProvider(
          lazy: true,
          create: (_) => PremiumPageRadioProvider(),
        ),
        ChangeNotifierProvider(
          lazy: true,
          create: (_) => FavouriteServersProvider(),
        ),
        ChangeNotifierProvider(
          lazy: true,
          create: (_) => LanguagePageRadioProvider(),
        ),
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
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue,
          selectionColor: Colors.blue.withValues(alpha: 0.4),
          selectionHandleColor: Colors.blue,
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
