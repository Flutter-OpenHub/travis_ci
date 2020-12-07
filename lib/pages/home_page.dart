/*
 * home_page.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../fragments/home_fragment.dart';
import '../fragments/my_builds.dart';
import '../fragments/repo_fragment.dart';
import '../store/form_store/form_store.dart';
import '../utils/icon_fonts.dart';
import 'my_account.dart';
import 'settings.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final FormStore store;

  const HomePage({Key key, this.store}) : super(key: key);
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  int _index = 0;

  String _title = "Active Repos";

  Widget _selectedWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            _title,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontFamily: 'SourceSansPro'),
          ),
          elevation: 0.0,
          centerTitle: false,
        ),
        drawer: Drawer(
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
                        Navigator.push(context, new MaterialPageRoute(
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
                      leading: Icon(TravisLogos.source_repository_multiple),
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
                    ListTile(
                      leading: Icon(FeatherIcons.briefcase),
                      title: Text("Jobs"),
                      selected: _index == 3,
                      onTap: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _index = 3;
                          _title = "Jobs";
                          _selectedWidget = Center(
                            child: Text("Yet to be implemented \u{1f605}"),
                          );
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
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return SettingsPage();
                  }));
                },
              ),
            ],
          )),
        ),
        body: _selectedWidget);
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
