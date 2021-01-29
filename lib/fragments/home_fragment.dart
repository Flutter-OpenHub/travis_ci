/*
 * home_fragment.dart
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

class HomeFragment extends StatefulWidget {
  @override
  _ActiveRepoState createState() => _ActiveRepoState();
}

class _ActiveRepoState extends State<HomeFragment> {
  CancelToken cancelToken = CancelToken();

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
          return TravisCIApi.getRepoList((pageIndex * 10), 10, cancelToken,
              isActive: true);
        });
  }

  Widget _builder(
      BuildContext context, RepositoriesModel repositoriesModel, int index) {
    return OpenContainer(
      closedColor: Theme.of(context).canvasColor,
      openColor: Theme.of(context).canvasColor,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return ListTile(
          trailing: Icon(
            repositoriesModel.starred ? Icons.star : Icons.star_border,
            color: repositoriesModel.starred
                ? Colors.orange
                : Theme.of(context).dividerColor,
          ),
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
            style: TextStyle(
              color: repositoriesModel.active ? Colors.blue : Colors.teal,
              fontSize: 15.0,
            ),
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
