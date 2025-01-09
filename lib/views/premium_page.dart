import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/premium_page_radio_provider.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          tooltip: "Back",
          onPressed: () => GoRouter.of(context).pop(),
          icon: Icon(Icons.west_rounded, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            childAnimationBuilder: (widget) {
              return SlideAnimation(
                delay: Duration(milliseconds: 2),
                duration: Duration(milliseconds: 200),
                horizontalOffset: -50.0,
                child: FadeInAnimation(
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 200),
                  delay: Duration(milliseconds: 2),
                  child: widget,
                ),
              );
            },
            children: <Widget>[
              SizedBox(height: 40.0),
              Lottie.asset("assets/animations/crown.json"),
              SelectionArea(
                child: Text(
                  "Get Premium",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 2.0),
              Builder(
                builder: (contxt) => SelectionArea(
                  child: Text(
                    "Upgrade to Premium to enjoy${MediaQuery.orientationOf(contxt) == Orientation.portrait ? "\n" : " "}more features",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0XFFAEB1C2),
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/global.png", height: 18.0),
                  SizedBox(width: 12.0),
                  SelectionArea(
                    child: Text(
                      "All Global Services",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 17.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 32.0),
                  Image.asset("assets/images/flash.png", height: 18.0),
                  SizedBox(width: 12.0),
                  SelectionArea(
                    child: Text(
                      "Super Fast Connections",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 17.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 20.0),
                  Image.asset("assets/images/server.png", height: 18.0),
                  SizedBox(width: 12.0),
                  SelectionArea(
                    child: Text(
                      "All 10+ Servers for VIP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 17.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/audio.png", height: 15.0),
                  SizedBox(width: 12.0),
                  SelectionArea(
                    child: Text(
                      "ADS Free Service",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.0),
                ],
              ),
              SizedBox(height: 20.0),
              RichText(
                text: TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: "First 3 Days ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: "Free Trial",
                      style: TextStyle(
                        color: Color(0XFF337BF3),
                        fontSize: 18.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.0),
              SelectionArea(
                child: Text(
                  "No Commitment & Cancel Anytime",
                  style: TextStyle(
                    color: Color(0XFF8A8C99),
                    fontSize: 12.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 18.0),
              CustomListTile(text: "£59.00/- Week", radioValue: 0),
              SizedBox(height: 5.0),
              CustomListTile(text: "£79.00/- Month", radioValue: 1),
              SizedBox(height: 5.0),
              CustomListTile(text: "£89.00/- Lifetime Free", radioValue: 2),
              SizedBox(height: 23.0),
              Builder(
                builder: (contxt) => Container(
                  width: MediaQuery.sizeOf(contxt).width * 0.9,
                  height: 52.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13.0),
                    gradient: LinearGradient(colors: <Color>[
                      Color(0XFF644BE7),
                      Color(0XFF2CAEEB),
                    ]),
                  ),
                  child: Center(
                    child: Text(
                      "Upgrade to Premium",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Terms of Conditions",
                    style: TextStyle(
                      color: Color(0XFF2B6DDB),
                      fontSize: 12.0,
                      fontFamily: "Montserrat",
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0XFF2B6DDB),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                      color: Color(0XFF2B6DDB),
                      fontSize: 12.0,
                      fontFamily: "Montserrat",
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0XFF2B6DDB),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String text;
  final int radioValue;

  const CustomListTile({
    super.key,
    required this.text,
    required this.radioValue,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<PremiumPageRadioProvider, int>(
      selector: (context, provider) => provider.selectedValue,
      builder: (contxt, value, _) => SizedBox(
        width: MediaQuery.sizeOf(contxt).width * 0.9,
        height: 70.0,
        child: ListTile(
          onTap: () => contxt
              .read<PremiumPageRadioProvider>()
              .setSelectedValue(radioValue),
          tileColor: Color(0XFF1D2031),
          shape: RoundedRectangleBorder(
            side: value == radioValue
                ? BorderSide(color: Colors.blue)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(14.0),
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
            ),
          ),
          splashColor: Colors.transparent,
          contentPadding: EdgeInsets.only(
            top: !kIsWeb ? 5.0 : 10.0,
            left: 24.0,
            right: 24.0,
          ),
          trailing: Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: value == radioValue
                  ? Border.all(color: Colors.blue)
                  : Border.all(color: Colors.white),
            ),
            child: Container(
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value == radioValue ? Colors.blue : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
