/*
 * repo_fragment.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:animations/animations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

import '../api/travis_ci_api.dart';
import '../models/repo.dart';
import '../pages/details.dart';
import '../utils/icon_fonts.dart';

class RepoFragment extends StatefulWidget {
  @override
  _RepoFragmentState createState() => _RepoFragmentState();
}

class _RepoFragmentState extends State<RepoFragment> {
  PagewiseLoadController<RepositoriesModel> _pageWiseLoadController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: PagewiseListView(
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
    );
  }

  @override
  void initState() {
    super.initState();
    _pageWiseLoadController = PagewiseLoadController(
        pageSize: 10,
        pageFuture: (pageIndex) {
          return TravisCIApi.getRepoList((pageIndex * 10), 10, CancelToken(),
              isActive: false);
        });
  }

  Widget _builder(
      BuildContext context, RepositoriesModel repositoriesModel, int index) {
    return OpenContainer(
      closedColor: Theme.of(context).canvasColor,
      openColor: Theme.of(context).canvasColor,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
          leading: Icon(
            TravisLogos.source_repository,
            color: Colors.grey,
          ),
          title: Text(
            repositoriesModel.name,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            repositoriesModel.owner,
            style: TextStyle(color: Colors.blue, fontSize: 15.0),
          ),
          onTap: openContainer,
        );
      },
      openBuilder: (BuildContext _, VoidCallback openContainer) {
        return Details(repositoriesModel: repositoriesModel);
      },
      closedElevation: 0,
      transitionDuration: Duration(milliseconds: 500),
    );
  }
}
