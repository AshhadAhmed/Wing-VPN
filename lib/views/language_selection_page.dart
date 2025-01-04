import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wing_vpn/providers/language_page_radio_provider.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Language",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            tooltip: "Back",
            onPressed: () => GoRouter.of(context).pop(),
            icon: Icon(Icons.west_rounded, color: Colors.white),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    dismissDirection: DismissDirection.horizontal,
                    behavior: SnackBarBehavior.floating,
                    padding: EdgeInsets.only(
                      bottom: !kIsWeb ? 2.0 : 8.0,
                      top: !kIsWeb ? 2.0 : 8.0,
                      right: 2.0,
                      left: 16.0,
                    ),
                    content: Text(
                      "Language updated",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    margin: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    action: SnackBarAction(
                      label: "Close",
                      textColor: Colors.green,
                      onPressed: () =>
                          ScaffoldMessenger.of(context).clearSnackBars(),
                    ),
                  ),
                );
              },
              child: Container(
                width: 76.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: Color(0XFF357DF6),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 15.0),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            childAnimationBuilder: (widget) {
              return SlideAnimation(
                delay: Duration(milliseconds: 20),
                duration: Duration(milliseconds: 300),
                horizontalOffset: -50.0,
                child: FadeInAnimation(
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 300),
                  delay: Duration(milliseconds: 20),
                  child: widget,
                ),
              );
            },
            children: <Widget>[
              CustomListTile(
                text: "Urdu",
                radioValue: 0,
                backgroundImage: AssetImage("assets/images/pakistan_flag.png"),
              ),
              SizedBox(height: 5.0),
              CustomListTile(
                text: "English",
                radioValue: 1,
                backgroundImage: AssetImage("assets/images/UK_flag.png"),
              ),
              SizedBox(height: 5.0),
              CustomListTile(
                text: "Spanish",
                radioValue: 2,
                backgroundImage: AssetImage("assets/images/spanish_flag.png"),
              ),
              SizedBox(height: 5.0),
              CustomListTile(
                text: "Indonesian",
                radioValue: 3,
                backgroundImage: AssetImage("assets/images/indonesia_flag.png"),
              ),
              SizedBox(height: 5.0),
              CustomListTile(
                text: "Chinese",
                radioValue: 4,
                backgroundImage: AssetImage("assets/images/china_flag.png"),
              ),
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
  final ImageProvider<Object>? backgroundImage;

  const CustomListTile({
    super.key,
    required this.text,
    required this.radioValue,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<LanguagePageRadioProvider, int>(
      selector: (context, provider) => provider.selectedValue,
      builder: (contxt, value, _) => SizedBox(
        width: MediaQuery.sizeOf(contxt).width * 0.9,
        child: ListTile(
          onTap: () => contxt
              .read<LanguagePageRadioProvider>()
              .setSelectedValue(radioValue),
          tileColor: Color(0XFF1D2031),
          shape: RoundedRectangleBorder(
            side: value == radioValue
                ? BorderSide(color: Colors.blue, width: 1.2)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(14.0),
          ),
          leading: CircleAvatar(backgroundImage: backgroundImage),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.0,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w500,
            ),
          ),
          splashColor: Colors.transparent,
          trailing: Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: value == radioValue
                  ? Border.all(color: Colors.blue, width: 1.2)
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
