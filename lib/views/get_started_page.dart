import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/check_box_provider.dart';
import '../router/routes.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckBoxProvider(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: AnimationConfiguration.toStaggeredList(
              childAnimationBuilder: (widget) {
                return SlideAnimation(
                  delay: Duration(milliseconds: 20),
                  duration: Duration(milliseconds: 200),
                  horizontalOffset: -20.0,
                  child: FadeInAnimation(
                    curve: Curves.linear,
                    duration: Duration(milliseconds: 200),
                    delay: Duration(milliseconds: 20),
                    child: widget,
                  ),
                );
              },
              children: <Widget>[
                SizedBox(height: 250.0),
                SvgPicture.asset("assets/icon/icon.svg", height: 100.0),
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
                SizedBox(height: 240.0),
                Row(
                  children: <Widget>[
                    Builder(
                      builder: (contxt) => SizedBox(
                        width: MediaQuery.orientationOf(contxt) ==
                                Orientation.portrait
                            ? !kIsWeb
                                ? 15.0
                                : 30.0
                            : 35.0,
                      ),
                    ),
                    Selector<CheckBoxProvider, bool>(
                      selector: (context, provider) => provider.isSwitched,
                      builder: (contxt, value, _) => Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                          value: value,
                          onChanged: contxt.read<CheckBoxProvider>().onTap,
                          activeColor: Color(0XFF2A73E7),
                          side: BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (contxt) => RichText(
                        text: TextSpan(children: <InlineSpan>[
                          TextSpan(
                            text:
                                "By clicking 'Get Started' you agree to the${MediaQuery.orientationOf(contxt) == Orientation.portrait ? "\n" : " "}",
                            style: TextStyle(
                              fontSize: 12.93,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              fontSize: 12.93,
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                              decorationColor: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: " & ",
                            style: TextStyle(
                              fontSize: 12.93,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: "Terms and Conditions",
                            style: TextStyle(
                              fontSize: 12.93,
                              fontFamily: "Montserrat",
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              decorationColor: Colors.white,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Selector<CheckBoxProvider, bool>(
                  selector: (context, provider) => provider.isSwitched,
                  builder: (contxt, value, _) => ElevatedButton(
                    onPressed: value
                        ? () {
                            final storage = GetStorage();
                            storage.write("status", true);

                            contxt.go(AppRoutes.home);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Color(0XFF2A73E7).withValues(
                        alpha: 0.4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Color(0XFF2A73E7),
                      fixedSize: Size(
                        MediaQuery.sizeOf(contxt).width * 0.9,
                        52.0,
                      ),
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
