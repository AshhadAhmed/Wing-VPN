// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:wing_vpn/providers/check_box_provider.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationLimiter(
        child: SingleChildScrollView(
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
                SizedBox(height: 240.0),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 15.0
                          : 30.0,
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
                    RichText(
                      text: TextSpan(children: <InlineSpan>[
                        TextSpan(
                          text: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? "By clicking 'Get Started' you agree to the \n"
                              : "By clicking 'Get Started' you agree to the ",
                          style: TextStyle(
                            fontSize: 12.93,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            fontSize: 12.93,
                            fontFamily: "Montserrat",
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
                          ),
                        ),
                        TextSpan(
                          text: "Terms and Conditions",
                          style: TextStyle(
                            fontSize: 12.93,
                            fontFamily: "Montserrat",
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ]),
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

                            Navigator.pushReplacementNamed(contxt, "/main");
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
                        MediaQuery.sizeOf(context).width * 0.9,
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
