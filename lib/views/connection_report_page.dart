import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/vpn_provider.dart';

class ConnectionReportScreen extends StatelessWidget {
  const ConnectionReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Connection Report",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          tooltip: "Back",
          onPressed: () => GoRouter.of(context).pop(),
          icon: Icon(Icons.west_rounded, color: Colors.white),
        ),
      ),
      body: Column(
        children: AnimationConfiguration.toStaggeredList(
          childAnimationBuilder: (widget) {
            return SlideAnimation(
              delay: Duration(milliseconds: 20),
              duration: Duration(milliseconds: 300),
              horizontalOffset: -100.0,
              child: FadeInAnimation(
                curve: Curves.linear,
                duration: Duration(milliseconds: 300),
                delay: Duration(milliseconds: 20),
                child: widget,
              ),
            );
          },
          children: <Widget>[
            Builder(
              builder: (contxt) => Container(
                width: MediaQuery.sizeOf(contxt).width * 0.9,
                height: 123.0,
                decoration: BoxDecoration(
                  color: Color(0XFF1D2031),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Selector<VpnProvider, String>(
                      selector: (context, provider) => provider.connectionTime,
                      builder: (contxt, value, _) => SelectionArea(
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 45.0,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SelectionArea(
                      child: Text(
                        "Total connection time",
                        style: TextStyle(
                          color: Color(0XFF7C7F90),
                          fontSize: 14.0,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.0),
            ListTile(
              dense: true,
              leading: Container(
                width: 35.0,
                height: 35.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "IP",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              title: SelectionArea(
                child: Text(
                  "IP address",
                  style: TextStyle(
                    color: Color(0XFF7C7F90),
                    fontSize: 11.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              subtitle: SelectionArea(
                child: Text(
                  "127.123.21.12",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Selector<VpnProvider, String>(
              selector: (context, provider) => provider.currentServer.server,
              builder: (contxt, value, _) => ListTile(
                dense: true,
                leading: SvgPicture.asset(
                  "assets/images/global.svg",
                  height: 35.0,
                ),
                title: SelectionArea(
                  child: Text(
                    "Current server",
                    style: TextStyle(
                      color: Color(0XFF7C7F90),
                      fontSize: 11.0,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                subtitle: SelectionArea(
                  child: Text(
                    value,
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
          ],
        ),
      ),
    );
  }
}
