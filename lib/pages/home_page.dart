/*
 * home_page.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../fragments/home_fragment.dart';
import '../fragments/my_builds.dart';
import '../fragments/repo_fragment.dart';
import '../store/form_store/form_store.dart';
import '../utils/icon_fonts.dart';
import 'my_account.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  final FormStore store;

  const HomePage({Key key, this.store}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _index = 0;

  String _title = "Active Repos";

  Widget _selectedWidget;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
          //backgroundColor: Color.fromRGBO(242, 242, 247, 1.0),
          appBar: AppBar(
            title: Text(
              sizingInformation.deviceScreenType == DeviceScreenType.mobile
                  ? _title
                  : "Travis CI",
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontFamily: 'SourceSansPro'),
            ),
            elevation: 0.0,
            centerTitle: false,
          ),
          drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
              ? Drawer(
                  child: SafeArea(
                      child: Column(
                    children: [
                      DrawerHeader(
                          child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 28.0,
                              backgroundImage: NetworkImage(
                                  widget.store.userStore.user.avatarUrl),
                            ),
                            ListTile(
                              title: Text(widget.store.userStore.user.name),
                              subtitle: Text(widget.store.userStore.user.login),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              contentPadding: const EdgeInsets.only(),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return MyAccount(
                                    formStore: widget.store,
                                  );
                                }));
                              },
                            )
                          ],
                        ),
                      )),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.only(),
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              leading: Icon(TravisLogos.source_repository),
                              title: Text("Active Repos"),
                              selected: _index == 0,
                              onTap: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  _index = 0;
                                  _title = "Active Repos";
                                  _selectedWidget = HomeFragment();
                                });
                              },
                            ),
                            ListTile(
                              leading:
                                  Icon(TravisLogos.source_repository_multiple),
                              title: Text("All Repos"),
                              selected: _index == 1,
                              onTap: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  _index = 1;
                                  _title = "All Repos";
                                  _selectedWidget = RepoFragment();
                                });
                              },
                            ),
                            ListTile(
                              leading: Icon(FeatherIcons.settings),
                              title: Text("Builds"),
                              selected: _index == 2,
                              onTap: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  _index = 2;
                                  _title = "Builds";
                                  _selectedWidget = MyBuilds();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0.0,
                      ),
                      ListTile(
                        leading: Icon(FeatherIcons.settings),
                        title: Text("Settings"),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return SettingsPage(
                              showAppBar: true,
                            );
                          }));
                        },
                      ),
                    ],
                  )),
                )
              : null,
          body: sizingInformation.deviceScreenType == DeviceScreenType.mobile
              ? _selectedWidget
              : Row(
                  children: [
                    Expanded(flex: 3, child: _drawer(sizingInformation)),
                    VerticalDivider(
                      width: 1.0,
                    ),
                    Expanded(flex: 5, child: _selectedWidget)
                  ],
                )),
    );
  }

  // _showDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //         contentPadding: const EdgeInsets.all(0),
  //             content: SizedBox(
  //               width: MediaQuery.of(context).size.width * 0.7,
  //               height: MediaQuery.of(context).size.height * 0.7,
  //               child: MyAccount(
  //                 formStore: widget.store,
  //               ),
  //             ),
  //           ));
  // }

  _drawer(SizingInformation sizingInformation) {
    return Drawer(
      elevation: 0.0,
      child: Container(
        //color: Color.fromRGBO(242, 242, 247, 1.0),
        //color: Theme.of(context).cardColor,
        child: SafeArea(
            child: Column(
          children: [
            DrawerHeader(
                child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28.0,
                    backgroundImage:
                        NetworkImage(widget.store.userStore.user.avatarUrl),
                  ),
                  ListTile(
                    title: Text(widget.store.userStore.user.name),
                    subtitle: Text(widget.store.userStore.user.login),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    contentPadding: const EdgeInsets.only(),
                    onTap: () {
                      //_showDialog();
                      if (sizingInformation.deviceScreenType ==
                          DeviceScreenType.mobile) Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MyAccount(
                          formStore: widget.store,
                        );
                      }));
                    },
                  )
                ],
              ),
            )),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(),
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: Icon(TravisLogos.source_repository),
                    title: Text("Active Repos"),
                    selected: _index == 0,
                    onTap: () {
                      if (sizingInformation.deviceScreenType ==
                          DeviceScreenType.mobile) Navigator.of(context).pop();
                      setState(() {
                        _index = 0;
                        _title = "Active Repos";
                        _selectedWidget = HomeFragment();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(TravisLogos.source_repository_multiple),
                    title: Text("All Repos"),
                    selected: _index == 1,
                    onTap: () {
                      if (sizingInformation.deviceScreenType ==
                          DeviceScreenType.mobile) Navigator.of(context).pop();
                      setState(() {
                        _index = 1;
                        _title = "All Repos";
                        _selectedWidget = RepoFragment();
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(FeatherIcons.settings),
                    title: Text("Builds"),
                    selected: _index == 2,
                    onTap: () {
                      if (sizingInformation.deviceScreenType ==
                          DeviceScreenType.mobile) Navigator.of(context).pop();
                      setState(() {
                        _index = 2;
                        _title = "Builds";
                        _selectedWidget = MyBuilds();
                      });
                    },
                  ),
                  if (sizingInformation.deviceScreenType !=
                      DeviceScreenType.mobile)
                    _settingsWidget(sizingInformation)
                ],
              ),
            ),
            if (sizingInformation.deviceScreenType == DeviceScreenType.mobile)
              _settingsWidget(sizingInformation)
          ],
        )),
      ),
    );
  }

  _settingsWidget(SizingInformation sizingInformation) {
    return Column(
      children: [
        Divider(
          height: 0.0,
        ),
        ListTile(
          leading: Icon(FeatherIcons.settings),
          title: Text("Settings"),
          onTap: () {
            if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SettingsPage(
                  showAppBar: true,
                );
              }));
            } else {
              setState(() {
                _index = 3;
                _title = "Settings";
                _selectedWidget = SettingsPage(
                  showAppBar: false,
                );
              });
            }
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedWidget = HomeFragment();
  }

  // Image.asset(
  //           'assets/TravisCI-Full-Color.png',
  //           height: kToolbarHeight - 24.0,
  //         )
}
