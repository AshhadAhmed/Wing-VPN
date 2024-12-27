import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          tooltip: "Back",
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.west_rounded, color: Colors.white),
        ),
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              childAnimationBuilder: (widget) => SlideAnimation(
                delay: Duration(milliseconds: 20),
                duration: Duration(milliseconds: 300),
                horizontalOffset: -50.0,
                child: FadeInAnimation(
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 300),
                  delay: Duration(milliseconds: 20),
                  child: widget,
                ),
              ),
              children: <Widget>[
                CustomListTile(
                  text: "Server list",
                  widget: Image.asset(
                    "assets/images/check_list.png",
                    height: 18.0,
                  ),
                  onTap: () => Navigator.pushNamed(context, "/servers"),
                ),
                SizedBox(height: 5.0),
                CustomListTile(
                  onTap: () {},
                  text: "Private browser",
                  widget: Image.asset(
                    "assets/images/global_search.png",
                    height: 18.0,
                  ),
                ),
                SizedBox(height: 5.0),
                CustomListTile(
                  text: "Language",
                  widget: Image.asset(
                    "assets/images/translate.png",
                    height: 18.0,
                  ),
                  onTap: () => Navigator.pushNamed(context, "/language"),
                ),
                SizedBox(height: 5.0),
                CustomListTile(
                  onTap: () {},
                  text: "Privacy policy",
                  widget: Icon(
                    Icons.shield_sharp,
                    size: 19.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.0),
                CustomListTile(
                  text: "Version",
                  widget: Icon(
                    Icons.info_rounded,
                    size: 18.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.pushNamed(context, "/version"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final Widget? widget;
  final String text;
  final void Function()? onTap;

  const CustomListTile({
    super.key,
    this.widget,
    this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: ListTile(
        onTap: onTap,
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
          child: Center(child: widget),
        ),
        splashColor: Colors.transparent,
        title: Text(
          text,
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
    );
  }
}
