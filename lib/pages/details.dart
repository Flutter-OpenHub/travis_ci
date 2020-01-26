import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String repoDetail;

  const Details({Key key, this.repoDetail}) : super(key: key);

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(child: Text("Yet to be implemented \u{1f605} \n $repoDetail"),),
//    );
//  }

  //TODO Implement function to star and unstar repo. Activate and deactivate repo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(repoDetail),
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
