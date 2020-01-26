import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:travis_ci/fragments/build_fragment.dart';
import 'package:travis_ci/fragments/home_fragment.dart';
import 'package:travis_ci/fragments/repo_fragment.dart';
import 'package:travis_ci/pages/my_account.dart';
import 'package:travis_ci/store/form_store.dart';

import '../utils/icon_fonts.dart';
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

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _index = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
    setState(() {
      _index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/TravisCI-Full-Color.png',
            height: kToolbarHeight - 24.0,
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0.0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          brightness: Brightness.light,
          actions: <Widget>[
            ActionChip(
              avatar: CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.store.userStore.user.avatarUrl),
                backgroundColor: Colors.white,
              ),
              backgroundColor: Colors.teal,
              label: Text(
                'My Account',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return MyAccount(
                    formStore: widget.store,
                  );
                }));
              },
            ),
            IconButton(
                icon: Icon(
                  FeatherIcons.settings,
                  size: 18.0,
                ),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return SettingsPage();
                  }));
                }),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _index = index;
                _tabController.animateTo(index);
              });
            },
            currentIndex: _index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(FeatherIcons.home),
                  title: Text(
                    'Dashboard',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(TravisLogos.source_repository_multiple),
                  title: Text(
                    'All Repos',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(FeatherIcons.settings),
                  title: Text(
                    'Builds',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(FeatherIcons.briefcase),
                  title: Text(
                    'Jobs',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ))
            ]),
        body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeFragment(
                store: widget.store,
              ),
              RepoFragment(),
              BuildsFragment(),
              Center(
                child: Text("Yet to be implemented \u{1f605}"),
              ),
            ]));
  }
}
