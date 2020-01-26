import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travis_ci/store/form_store.dart';

import '../models/build_model.dart';
import '../pages/build_details.dart';

class BuildsFragment extends StatefulWidget {
  @override
  _BuildsFragmentState createState() => _BuildsFragmentState();
}

class _BuildsFragmentState extends State<BuildsFragment> {
  List<BuildsModel> buildsModel = [];
  List<RepoDetailModel> repoDetailModel = [];

  final FormStore store = FormStore();

  @override
  void initState() {
    super.initState();
    loadBuildsData();
  }

  loadBuildsData() async {
    var response = await http.get("https://api.travis-ci.org/builds", headers: {
      "Travis-API-Version": "3",
      "Authorization": "${store.token}"
    });
    if (response.statusCode == 200) {
      String responseBody = response.body;
      var jsonBody = json.decode(responseBody);
      print(jsonBody);
      var builds = Builds.fromJson(jsonBody);
      for (var data in builds.builds) {
        buildsModel.add(BuildsModel(
            data['number'],
            data['state'],
            data['duration'],
            data['previous_state'],
            data['created_by'],
            data['commit'],
            data['repository']));
        repoDetailModel.add(RepoDetailModel(
            data['repository']['name'], data['repository']['slug']));
        //print(data['repository']['name']);
        print(data['created_by']);
        if (this.mounted) {
          setState(() {});
        }
      }
    } else {
      print("Failed to load data!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: buildsModel.length == 0
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
        itemCount: buildsModel.length,
        itemBuilder: (_, index) {
          var time;
          var duration;
          var splitDuration;
          var splitSeconds;
          Color stateColor;
          if (buildsModel[index].duration != null) {
            time = Duration(seconds: buildsModel[index].duration);
            duration = time.toString();
            splitDuration = duration.split(":");
            splitSeconds = splitDuration[2].split(".");
          }

          switch (buildsModel[index].state) {
            case "started":
              stateColor = Colors.black45;
              break;
            case "passed":
              stateColor = Colors.blue;
              break;
            case "errored":
              stateColor = Colors.red;
              break;
            case "failed":
              stateColor = Colors.redAccent;
              break;
            case "canceled":
              stateColor = Colors.green;
              break;
          }

          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 24.0),
            leading: Text(buildsModel[index].number,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500)),
            title: Text(repoDetailModel[index].slug,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500)),
            subtitle: Text(
                '#' +
                    buildsModel[index].number +
                    ' ' +
                    buildsModel[index].state,
                style: TextStyle(color: stateColor, fontSize: 15.0)),
            onTap: () {
              setState(() {
//                print(buildsModel.length);
              });
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return BuildDetails(
                  buildDetail: buildsModel[index],
                );
              }));
            },
          );
        });
  }
}

class Builds {
  final List<dynamic> builds;

  Builds(this.builds);

  Builds.fromJson(Map<String, dynamic> json) : builds = json['builds'];
}

class RepoDetailModel {
  String name;
  String slug;

  RepoDetailModel(this.name, this.slug);
}
