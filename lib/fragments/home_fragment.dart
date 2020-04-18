import 'package:dio/dio.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:travis_ci/api/user_repos.dart';
import 'package:travis_ci/models/repo.dart';
import 'package:travis_ci/store/form_store.dart';

import '../utils/icon_fonts.dart';
import '../pages/details.dart';

class HomeFragment extends StatefulWidget {
  final FormStore store;

  const HomeFragment({Key key, this.store}) : super(key: key);
  @override
  _ActiveRepoState createState() => _ActiveRepoState();
}

class _ActiveRepoState extends State<HomeFragment>
    with SingleTickerProviderStateMixin {
  CancelToken cancelToken = CancelToken();

  PagewiseLoadController<RepositoriesModel> _pageWiseLoadController;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageWiseLoadController = PagewiseLoadController(
        pageSize: 10,
        pageFuture: (pageIndex) {
          return UserRepoApi.getRepoList(
              widget.store.token,
              widget.store.userStore.user.login,
              (pageIndex * 10),
              10,
              cancelToken);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            TabBar(
              labelColor: Colors.teal,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        TravisLogos.source_repository_multiple,
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Flexible(child: Text('Active repositories'))
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FeatherIcons.settings,
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Flexible(child: Text('My builds'))
                    ],
                  ),
                ),
              ],
              controller: _tabController,
            ),
            Expanded(
                child: TabBarView(
              children: [
                PagewiseListView(
                  itemBuilder: _builder,
                  shrinkWrap: true,
                  showRetry: false,
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  pageLoadController: _pageWiseLoadController,
                  noItemsFoundBuilder: (context) {
                    return Chip(label: Text('No active repositories found!'));
                  },
                  errorBuilder: (context, error) {
                    return Text(error.toString());
                  },
                  loadingBuilder: (context) {
                    return CircularProgressIndicator(
                      strokeWidth: 2.0,
                    );
                  },
                ),
                Container()
              ],
              controller: _tabController,
            ))
          ],
        ));
  }

  Widget _builder(
      BuildContext context, RepositoriesModel repositoriesModel, int index) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      leading: Icon(
        TravisLogos.source_repository,
        size: 30.0,
      ),
      trailing: Icon(
        repositoriesModel.starred ? Icons.star : Icons.star_border,
        color: repositoriesModel.starred ? Colors.orange : Colors.black54,
      ),
      title: Text(repositoriesModel.owner,
          style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(
          repositoriesModel.active
              ? repositoriesModel.name
              : 'There is no build on the default branch yet.',
          style: TextStyle(
              color: repositoriesModel.active ? Colors.blue : Colors.teal,
              fontSize: 15.0)),
      onTap: () {
        setState(() {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return Details(
              repoDetail: repositoriesModel.slug,
              repoId: repositoriesModel.id.toString(),
              token: widget.store.token,
            );
          }));
        });
      },
    );
  }
}
