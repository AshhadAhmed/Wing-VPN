import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:wing_vpn/providers/favourite_servers_provider.dart';
import 'package:wing_vpn/providers/vpn_provider.dart';

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
            onPressed: () => Navigator.pop(context),
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
  final String titleText;
  final String serverStrength;
  final Widget? subtitle;
  final Widget? leading;
  final ImageProvider backgroundImage;

  const CustomListTile({
    super.key,
    required this.titleText,
    this.leading,
    this.subtitle,
    required this.backgroundImage,
    required this.serverStrength,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.zero,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: ListTile(
          dense: true,
          onTap: () =>
              context.read<VpnProvider>().currentServer.server == titleText
                  ? showConnectedToServerDialog(context)
                  : showConnectToServerDialog(
                      context,
                      server: titleText,
                      image: backgroundImage,
                    ),
          tileColor: Color(0XFF1D2031),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          leading: CircleAvatar(backgroundImage: backgroundImage),
          title: Text(
            titleText,
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
                server: titleText,
                flag: backgroundImage,
                strength: AssetImage(
                    "assets/images/wifi_${serverStrength.toLowerCase()}.png"),
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
  final ImageProvider flag;
  final ImageProvider strength;

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
              Text(
                "No Favourites",
                style: TextStyle(
                  fontSize: 17.0,
                  color: Color(0XFF424262),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
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
                delay: Duration(milliseconds: 20),
                duration: Duration(milliseconds: 300),
                child: FadeInAnimation(
                  duration: Duration(milliseconds: 300),
                  delay: Duration(milliseconds: 20),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.zero,
                    child: SizedBox(
                      width: MediaQuery.sizeOf(contxt).width * 0.9,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 6.0,
                          left: 18.0,
                          right: 18.0,
                        ),
                        child: ListTile(
                          dense: true,
                          onTap: () => contxt
                                      .read<VpnProvider>()
                                      .currentServer
                                      .server ==
                                  server
                              ? showConnectedToServerDialog(contxt)
                              : showConnectToServerDialog(
                                  contxt,
                                  server: server,
                                  image: flag,
                                ),
                          tileColor: Color(0XFF1D2031),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          leading: CircleAvatar(backgroundImage: flag),
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
                          trailing: Image(image: strength, height: 18.0),
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
    AssetImage("assets/images/singapore_flag.png"),
    AssetImage("assets/images/netherlands_flag.png"),
    AssetImage("assets/images/US_flag.jpg"),
    AssetImage("assets/images/france_flag.png"),
    AssetImage("assets/images/germany_flag.png"),
    AssetImage("assets/images/canada_flag.png"),
    AssetImage("assets/images/UK_flag.png"),
    AssetImage("assets/images/germany_flag.png"),
    AssetImage("assets/images/US_flag.jpg"),
    AssetImage("assets/images/china_flag.png"),
    AssetImage("assets/images/canada_flag.png")
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
          delay: Duration(milliseconds: 20),
          duration: Duration(milliseconds: 300),
          child: FadeInAnimation(
            duration: Duration(milliseconds: 300),
            delay: Duration(milliseconds: 20),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 6.0,
                left: 18.0,
                right: 18.0,
              ),
              child: CustomListTile(
                titleText: _servers[index],
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
            Text(
              "Info",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Text(
          "Already connected to this server!",
          style: TextStyle(
            fontSize: 13.0,
            color: Color(0XFFB8BBCC),
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(contxt).pop(),
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
  required ImageProvider image,
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
        title: Text(
          "Connect to Server",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          "Do you want to connect to this server?",
          style: TextStyle(
            fontSize: 13.0,
            color: Color(0XFFB8BBCC),
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(contxt).pop(),
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
              contxt
                  .read<VpnProvider>()
                  .setServer(server, image)
                  .disableConnection();

              Navigator.of(contxt).pop();

              ScaffoldMessenger.of(contxt).showSnackBar(
                SnackBar(
                  dismissDirection: DismissDirection.horizontal,
                  padding: EdgeInsets.only(
                    bottom: 2.0,
                    top: 2.0,
                    left: 15.0,
                    right: 5.0,
                  ),
                  behavior: SnackBarBehavior.floating,
                  content: Text(
                    "Successfully connected",
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
  final List<ImageProvider> flags;
  final List<ImageProvider> serverStrength;

  DetailedServerInfo({
    required this.servers,
    required this.flags,
    required this.serverStrength,
  });
}
