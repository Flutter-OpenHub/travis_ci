import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:travis_ci/api/api_urls.dart';
import 'package:travis_ci/utils/network_util.dart';

class Details extends StatefulWidget {
  final String repoDetail;
  final String repoId;
  final String token;

  const Details({Key key, this.repoDetail, this.repoId, this.token})
      : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  //TODO Implement function to star and unstar repo. Activate and deactivate repo

  @override
  void initState() {
    super.initState();
    print(ApiUrls.repoUrl + widget.repoId);
    NetworkUtil().get(
      ApiUrls.repoUrl + widget.repoId + '/builds',
      CancelToken(),
      headers: {
        "Travis-API-Version": "3",
        "Authorization": "token ${widget.token}"
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.repoDetail),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.star_border), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[],
        ),
      ),
    );
  }
}
