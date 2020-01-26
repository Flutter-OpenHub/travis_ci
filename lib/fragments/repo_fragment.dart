import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travis_ci/store/form_store.dart';

import '../utils/icon_fonts.dart';

class RepoFragment extends StatefulWidget {
  @override
  _RepoFragmentState createState() => _RepoFragmentState();
}

class _RepoFragmentState extends State<RepoFragment> {
  final FormStore store = FormStore();
  List<RepositoriesModel> repositoriesModel = [];
  Pagination paginationPages;
  PageModel pageOffsets;
  bool sammy = true;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    loadContributorsData('100', '0');
  }

  loadContributorsData(String limit, String offset) async {
    var response = await http.get(
        "https://api.travis-ci.org/repos?offset=$offset&limit=$limit",
        headers: {
          "Travis-API-Version": "3",
          "Authorization": "${store.token}"
        });
    if (response.statusCode == 200) {
      String responseBody = response.body;
      var jsonBody = json.decode(responseBody);
      var repos = Repositories.fromJson(jsonBody);
      var pages = PaginationModel.fromJson(jsonBody);

      print(pages.pages);

      paginationPages = Pagination.fromJson(pages.pages);
      if (paginationPages.next != null) {
        pageOffsets = PageModel.fromJson(paginationPages.next);
      }

      for (var data in repos.repos) {
        if (this.mounted) {
          setState(() {
            repositoriesModel.add(RepositoriesModel(
                data['name'], data['slug'], data['description']));
          });
        }
      }

      if (paginationPages.next != null) {
        loadContributorsData('${pageOffsets.limit}', '${pageOffsets.offset}');
        print(pageOffsets.offset);
      }
    } else {
      print("Failed to load data!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: repositoriesModel.length == 0
          ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            )
          : updateUI(),
    );
  }

  Widget updateUI() {
    return ListView.builder(
        itemCount: repositoriesModel.length,
        controller: _scrollController,
        itemBuilder: (_, index) {
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            leading: Icon(
              TravisLogos.source_repository,
              size: 30.0,
            ),
            title: Text(repositoriesModel[index].name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
            subtitle: Text(repositoriesModel[index].slug,
                style: TextStyle(color: Colors.blue, fontSize: 15.0)),
            onTap: () {
              setState(() {});
            },
          );
        });
  }
}

class Repositories {
  final List<dynamic> repos;

  Repositories(this.repos);

  Repositories.fromJson(Map<String, dynamic> json)
      : repos = json['repositories'];
}

class RepositoriesModel {
  String name;
  String slug;
  String description;

  RepositoriesModel(this.name, this.slug, this.description);
}

class PaginationModel {
  var pages;

  PaginationModel(this.pages);

  PaginationModel.fromJson(Map<String, dynamic> json)
      : pages = json['@pagination'];
}

class Pagination {
  var first;
  var next;
  var prev;
  var last;

  int limit;
  int count;
  int offset;
  bool isFirst;
  bool isLast;

  Pagination(this.first, this.next, this.prev, this.last, this.limit,
      this.count, this.offset, this.isFirst, this.isLast);

  Pagination.fromJson(Map<String, dynamic> json)
      : first = json['first'],
        next = json['next'],
        prev = json['prev'],
        last = json['last'],
        limit = json['limit'],
        count = json['count'],
        offset = json['offset'],
        isFirst = json['is_first'],
        isLast = json['is_last'];
}

class PageModel {
  int limit;
  int offset;

  PageModel(this.limit, this.offset);

  PageModel.fromJson(Map<String, dynamic> json)
      : limit = json['limit'],
        offset = json['offset'];
}
