/*
 * show_user_repos.dart
 *
 * Created by Amit Khairnar on 08/12/2020.
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

import '../api/travis_ci_api.dart';
import '../models/repo.dart';
import '../widgets/repo_list_tile.dart';

class ShowUserRepos extends StatefulWidget {
  final String login;
  final String title;

  const ShowUserRepos({Key key, this.login, this.title}) : super(key: key);
  @override
  _ShowUserReposState createState() => _ShowUserReposState();
}

class _ShowUserReposState extends State<ShowUserRepos> {
  PagewiseLoadController<RepositoriesModel> _pageWiseLoadController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PagewiseListView(
        itemBuilder: _builder,
        shrinkWrap: true,
        showRetry: false,
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        pageLoadController: _pageWiseLoadController,
        noItemsFoundBuilder: (context) {
          return Chip(label: Text('No repositories found!'));
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
    );
  }

  @override
  void initState() {
    super.initState();
    _pageWiseLoadController = PagewiseLoadController(
        pageSize: 10,
        pageFuture: (pageIndex) {
          return TravisCIApi.getOrganizationRepos(
              widget.login, (pageIndex * 10), 10, CancelToken());
        });
  }

  Widget _builder(
      BuildContext context, RepositoriesModel repositoriesModel, int index) {
    return RepoListTile(repositoriesModel: repositoriesModel);
  }
}
