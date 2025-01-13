import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/favourite_servers_provider.dart';
import '../providers/vpn_provider.dart';

class ServersScreen extends StatelessWidget {
  const ServersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Server list",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            tooltip: "Back",
            onPressed: () => GoRouter.of(context).pop(),
            icon: Icon(Icons.west_rounded, color: Colors.white),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: Builder(
              builder: (contxt) => Container(
                width: MediaQuery.sizeOf(contxt).width * 0.9,
                padding: EdgeInsets.only(
                  left: 5.0,
                  right: 5.0,
                  top: 4.0,
                  bottom: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0XFF1D2031),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: TabBar(
                  dividerHeight: 0.0,
                  indicator: BoxDecoration(
                    color: Color(0XFF337BF3),
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                  labelColor: Colors.white,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    letterSpacing: 0.2,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: <Widget>[
                    Tab(
                      height: 32.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.location_on_rounded),
                          SizedBox(width: 5.0),
                          Text("Location")
                        ],
                      ),
                    ),
                    Tab(
                      height: 32.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(CupertinoIcons.heart_solid),
                          SizedBox(width: 5.0),
                          Text("Favourites")
                        ],
                      ),
                    ),
                  ],
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Color(0XFF7C7F90),
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            LocationTabBarView(),
            FavouritesTabBarView(),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String server;
  final Widget? subtitle;
  final String serverStrength;
  final Widget? leading;
  final String backgroundImage;

  const CustomListTile({
    super.key,
    required this.server,
    this.leading,
    this.subtitle,
    required this.backgroundImage,
    required this.serverStrength,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14.0),
        child: ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(
            top: kIsWeb ? 5.0 : 0.0,
            left: 18.0,
            right: 18.0,
          ),
          onTap: () =>
              context.read<VpnProvider>().currentServer.server == server
                  ? showConnectedToServerDialog(context)
                  : showConnectToServerDialog(
                      context,
                      server: server,
                      imagePath: backgroundImage,
                    ),
          tileColor: Color(0XFF1D2031),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          leading: CircleAvatar(backgroundImage: AssetImage(backgroundImage)),
          title: Text(
            server,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            "IP - 127.123.21.12",
            style: TextStyle(
              color: Color(0XFF7C7F90),
              fontSize: 12.0,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w500,
            ),
          ),
          splashColor: Colors.transparent,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                "assets/images/wifi_${serverStrength.toLowerCase()}.png",
                height: 18.0,
              ),
              SizedBox(width: 16.0),
              FavoriteButton(
                server: server,
                flag: backgroundImage,
                strength:
                    "assets/images/wifi_${serverStrength.toLowerCase()}.png",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  final String server;
  final String flag;
  final String strength;

  const FavoriteButton({
    super.key,
    required this.server,
    required this.flag,
    required this.strength,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<FavouriteServersProvider, List<String>>(
      selector: (context, provider) => provider.favourites,
      builder: (contxt, data, _) {
        final provider = contxt.read<FavouriteServersProvider>();
        final isFavourite = data.contains(server);

        return GestureDetector(
          onTap: () {
            if (isFavourite) {
              provider.removeFavouriteServer(server);
            } else {
              provider.addFavouriteServer(server, flag, strength);
            }
          },
          child: Icon(
            isFavourite ? CupertinoIcons.heart_solid : CupertinoIcons.heart,
            size: 28.0,
            color: isFavourite ? Colors.red : Color(0XFF434363),
          ),
        );
      },
    );
  }
}

class FavouritesTabBarView extends StatefulWidget {
  const FavouritesTabBarView({super.key});

  @override
  State createState() {
    return _FavouritesTabBarViewState();
  }
}

class _FavouritesTabBarViewState extends State<FavouritesTabBarView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Selector<FavouriteServersProvider, DetailedServerInfo>(
      selector: (context, provider) => DetailedServerInfo(
        servers: provider.favourites,
        flags: provider.flags,
        serverStrength: provider.strengths,
      ),
      builder: (contxt, detailedServerInfo, _) {
        if (detailedServerInfo.servers.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                "assets/images/favourites.png",
                height: 108.0,
              ),
              SizedBox(height: 24.0),
              SelectionArea(
                child: Text(
                  "No Favourites",
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Color(0XFF424262),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        }

        return ListView.builder(
          padding: EdgeInsets.only(bottom: 10.0),
          itemExtent: 70.0,
          itemCount: detailedServerInfo.servers.length,
          itemBuilder: (contxt, index) {
            final server = detailedServerInfo.servers[index];
            final flag = detailedServerInfo.flags[index];
            final strength = detailedServerInfo.serverStrength[index];

            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                horizontalOffset: -70.0,
                delay: Duration(milliseconds: 50),
                duration: Duration(milliseconds: 300),
                child: FadeInAnimation(
                  duration: Duration(milliseconds: 300),
                  delay: Duration(milliseconds: 50),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(contxt).width * 0.9,
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(14.0),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 6.0,
                          left: 18.0,
                          right: 18.0,
                        ),
                        child: ListTile(
                          key: ValueKey(detailedServerInfo.servers[index]),
                          dense: true,
                          contentPadding: EdgeInsets.only(
                            top: kIsWeb ? 5.0 : 0.0,
                            left: 18.0,
                            right: 18.0,
                          ),
                          onTap: () =>
                              contxt.read<VpnProvider>().currentServer.server ==
                                      server
                                  ? showConnectedToServerDialog(contxt)
                                  : showConnectToServerDialog(
                                      contxt,
                                      server: server,
                                      imagePath: flag,
                                    ),
                          tileColor: Color(0XFF1D2031),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(flag),
                          ),
                          title: Text(
                            server,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            "IP - 127.123.21.12",
                            style: TextStyle(
                              color: Color(0XFF7C7F90),
                              fontSize: 12.0,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          splashColor: Colors.transparent,
                          trailing: Image.asset(strength, height: 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class LocationTabBarView extends StatefulWidget {
  const LocationTabBarView({super.key});

  @override
  State createState() {
    return _LocationTabBarViewState();
  }
}

class _LocationTabBarViewState extends State<LocationTabBarView>
    with AutomaticKeepAliveClientMixin {
  final _servers = [
    "Singapore",
    "Netherlands",
    "US - New York",
    "France",
    "Germany",
    "Canada",
    "UK - London",
    "Berlin",
    "US - California",
    "China - Beijing",
    "Toronto",
  ];

  final _countryFlags = [
    "assets/images/singapore_flag.png",
    "assets/images/netherlands_flag.png",
    "assets/images/US_flag.jpg",
    "assets/images/france_flag.png",
    "assets/images/germany_flag.png",
    "assets/images/canada_flag.png",
    "assets/images/UK_flag.png",
    "assets/images/germany_flag.png",
    "assets/images/US_flag.jpg",
    "assets/images/china_flag.png",
    "assets/images/canada_flag.png",
  ];

  final _serverStrengths = [
    "strong",
    "medium",
    "weak",
    "strong",
    "strong",
    "strong",
    "strong",
    "weak",
    "medium",
    "medium",
    "strong"
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 10.0),
      itemExtent: 70.0,
      itemCount: _servers.length,
      itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
        position: index,
        child: SlideAnimation(
          horizontalOffset: -70.0,
          delay: Duration(milliseconds: 50),
          duration: Duration(milliseconds: 300),
          child: FadeInAnimation(
            duration: Duration(milliseconds: 300),
            delay: Duration(milliseconds: 50),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 6.0,
                left: 18.0,
                right: 18.0,
              ),
              child: CustomListTile(
                key: ValueKey(_servers[index]),
                server: _servers[index],
                backgroundImage: _countryFlags[index],
                serverStrength: _serverStrengths[index],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

void showConnectedToServerDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext contxt) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Color(0XFF1D2031),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info_outlined,
              color: Colors.white,
              size: 25.0,
            ),
            SizedBox(width: 10.0),
            SelectionArea(
              child: Text(
                "Info",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        content: SelectionArea(
          child: Text(
            "Already connected to this server!",
            style: TextStyle(
              fontSize: 13.0,
              color: Color(0XFFB8BBCC),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => GoRouter.of(contxt).pop(),
            style: TextButton.styleFrom(
              backgroundColor: Color(0XFF337BF3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0),
              ),
              fixedSize: Size(80.0, 44.0),
            ),
            child: Text(
              "Ok",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      );
    },
  );
}

void showConnectToServerDialog(
  BuildContext context, {
  required String server,
  required String imagePath,
}) {
  showDialog(
    context: context,
    builder: (BuildContext contxt) {
      return AlertDialog(
        insetPadding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Color(0XFF1D2031),
        title: SelectionArea(
          child: Text(
            "Connect to Server",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        content: SelectionArea(
          child: Text(
            "Do you want to connect to this server?",
            style: TextStyle(
              fontSize: 13.0,
              color: Color(0XFFB8BBCC),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => GoRouter.of(contxt).pop(),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0),
              ),
              fixedSize: Size(80.0, 44.0),
            ),
            child: Text(
              "No",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final storage = GetStorage();

              contxt
                  .read<VpnProvider>()
                  .setServer(server, imagePath)
                  .disableConnection();

              storage.write("country", server);
              storage.write("flag", imagePath);

              GoRouter.of(contxt).pop();

              ScaffoldMessenger.of(contxt).showSnackBar(
                SnackBar(
                  dismissDirection: DismissDirection.horizontal,
                  padding: EdgeInsets.only(
                    bottom: !kIsWeb ? 2.0 : 8.0,
                    top: !kIsWeb ? 2.0 : 8.0,
                    left: 15.0,
                  ),
                  content: Text(
                    "Connected to $server",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  action: SnackBarAction(
                    label: "Close",
                    textColor: Colors.green,
                    onPressed: () {
                      if (contxt.mounted) {
                        ScaffoldMessenger.of(contxt).clearSnackBars();
                      }
                    },
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Color(0XFF337BF3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0),
              ),
              fixedSize: Size(80.0, 44.0),
            ),
            child: Text(
              "Yes",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    },
  );
}

class DetailedServerInfo {
  final List<String> servers;
  final List<String> flags;
  final List<String> serverStrength;

  DetailedServerInfo({
    required this.servers,
    required this.flags,
    required this.serverStrength,
  });
}
