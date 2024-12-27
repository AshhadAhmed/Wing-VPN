import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class VersionScreen extends StatelessWidget {
  const VersionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          title: Text(
            "Version",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            tooltip: "Back",
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.west_rounded, color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              childAnimationBuilder: (widget) {
                return SlideAnimation(
                  delay: Duration(milliseconds: 20),
                  duration: Duration(milliseconds: 300),
                  horizontalOffset: -10.0,
                  child: FadeInAnimation(
                    curve: Curves.linear,
                    duration: Duration(milliseconds: 300),
                    delay: Duration(milliseconds: 20),
                    child: widget,
                  ),
                );
              },
              children: <Widget>[
                Image.asset("assets/icon/icon.png", height: 79.0),
                SizedBox(height: 12.0),
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
                SizedBox(height: 10.0),
                Text(
                  "Version 1.0.0",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0XFF8E8E8E),
                    fontFamily: "MontserratAlternates",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 22.0),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: ListTile(
                    onTap: () {},
                    tileColor: Color(0XFF1D2031),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    leading: Container(
                      width: 28.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: Color(0XFF3A81FC),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/images/refresh.png",
                          height: 16.0,
                        ),
                      ),
                    ),
                    splashColor: Colors.transparent,
                    title: Text(
                      "Check for Updates",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20.0,
                      color: Color(0XFF434363),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
