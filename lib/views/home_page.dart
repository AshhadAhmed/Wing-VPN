import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../providers/vpn_provider.dart';
import '../router/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          tooltip: "Settings",
          onPressed: () => context.push(AppRoutes.settings),
          icon: Icon(Icons.settings, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: "Premium",
            onPressed: () => context.push(AppRoutes.premium),
            icon: Lottie.asset(
              "assets/animations/crown.json",
              filterQuality: FilterQuality.high,
            ),
          ),
          SizedBox(width: 10.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome to",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0XFF7C7F90),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.0),
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
              SizedBox(height: 20.0),
              Builder(
                builder: (contxt) {
                  var serverInfo = contxt.select<VpnProvider, ServerInfo>(
                    (provider) => ServerInfo(
                      server: provider.currentServer.server,
                      flag: provider.currentServer.flag,
                    ),
                  );

                  return SizedBox(
                    width: MediaQuery.sizeOf(contxt).width * 0.9,
                    child: ListTile(
                      onTap: () => contxt.push(AppRoutes.connectionReport),
                      tileColor: Color(0XFF1D2031),
                      leading: CircleAvatar(
                        radius: 19.0,
                        backgroundImage: AssetImage(serverInfo.flag),
                      ),
                      splashColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(114.0),
                      ),
                      title: Text(
                        serverInfo.server,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "IP - 127.123.21.12",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0XFF7C7F90),
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 52.0),
              Builder(
                builder: (contxt) {
                  var isConnected = contxt.select<VpnProvider, bool>(
                      (provider) => provider.isConnected);
                  var isConnecting = contxt.select<VpnProvider, bool>(
                      (provider) => provider.isConnecting);

                  return GestureDetector(
                    onTap: contxt.read<VpnProvider>().enableConnection,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: isConnecting
                          ? Container(
                              key: ValueKey("Connecting"),
                              width: 140.0,
                              height: 140.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.withValues(alpha: 0.95),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 6.0,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                              ),
                              child: Center(
                                child: LoadingAnimationWidget.waveDots(
                                  color: Colors.white60,
                                  size: 50.0,
                                ),
                              ),
                            )
                          : isConnected
                              ? Container(
                                  key: ValueKey("Connected"),
                                  width: 140.0,
                                  height: 140.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue.withValues(alpha: 0.95),
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 6.0,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
                                    ),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 20.0),
                                      Icon(
                                        Icons.link_off_rounded,
                                        size: 60.0,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 12.0),
                                      Text(
                                        "DISCONNECT",
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.white,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  key: ValueKey("NotConnected"),
                                  width: 140.0,
                                  height: 140.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 6.0,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
                                    ),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 20.0),
                                      Icon(
                                        Icons.power_settings_new_rounded,
                                        size: 60.0,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 12.0),
                                      Text(
                                        "CONNECT",
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.white,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                    ),
                  );
                },
              ),
              SizedBox(height: 40.0),
              Builder(
                builder: (contxt) {
                  var isConnected = contxt.select<VpnProvider, bool>(
                      (provider) => provider.isConnected);
                  var isConnecting = contxt.select<VpnProvider, bool>(
                      (provider) => provider.isConnecting);

                  return RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: "Status : ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: isConnecting
                              ? "Connecting"
                              : isConnected
                                  ? "Connected"
                                  : "Not Connected",
                          style: TextStyle(
                            color: isConnecting
                                ? Colors.yellow
                                : isConnected
                                    ? Colors.green
                                    : Colors.red,
                            fontSize: 14.0,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 40.0),
              Builder(
                builder: (contxt) {
                  var value = contxt.select<VpnProvider, String>(
                      (provider) => provider.connectionTime);

                  return Text(
                    value,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
              SizedBox(height: 200.0),
            ],
          ),
        ),
      ),
    );
  }
}

class ServerInfo {
  final String server;
  final String flag;

  ServerInfo({required this.server, required this.flag});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ServerInfo && other.server == server;
  }

  @override
  int get hashCode => server.hashCode;
}
