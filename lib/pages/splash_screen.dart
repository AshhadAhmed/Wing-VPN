// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:wing_vpn/providers/linear_progress_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final storage = GetStorage();
        final linearProgressProvider = context.read<LinearProgressProvider>();

        await precacheImage(AssetImage("assets/images/US_flag.jpg"), context);
        await precacheImage(AssetImage("assets/images/Uk_flag.png"), context);
        await precacheImage(
            AssetImage("assets/images/china_flag.png"), context);
        await precacheImage(
            AssetImage("assets/images/singapore_flag.png"), context);
        await precacheImage(
            AssetImage("assets/images/canada_flag.png"), context);
        await precacheImage(
            AssetImage("assets/images/france_flag.png"), context);
        await precacheImage(
            AssetImage("assets/images/germany_flag.png"), context);
        await precacheImage(
            AssetImage("assets/images/netherlands_flag.png"), context);

        linearProgressProvider.initiateProgress(() {
          final status = storage.read<bool>("status") ?? false;

          if (status) {
            Navigator.pushReplacementNamed(context, "/main");
          } else {
            Navigator.pushReplacementNamed(context, "/getting_started");
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100.0),
            Image.asset("assets/icon/icon.png", height: 100.0),
            SizedBox(height: 26.0),
            RichText(
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: "W",
                    style: TextStyle(
                      color: Color(0XFF2A73E7),
                      fontSize: 27.0,
                      fontFamily: "MuseoModerno",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: "ing - VPN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27.0,
                      fontFamily: "MuseoModerno",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 210.0),
            Consumer<LinearProgressProvider>(
              builder: (context, provider, _) => SizedBox(
                width: 100.0,
                height: 6.0,
                child: LinearProgressIndicator(
                  value: provider.progress,
                  color: Color.fromARGB(255, 46, 118, 233),
                  backgroundColor: Color(0XFF1C3255),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
