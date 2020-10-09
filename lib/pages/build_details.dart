/*
 * build_details.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../models/build_model.dart';

class BuildDetails extends StatefulWidget {
  final BuildsModel buildDetail;

  const BuildDetails({Key key, this.buildDetail}) : super(key: key);

  @override
  _BuildDetailsState createState() => _BuildDetailsState();
}

class _BuildDetailsState extends State<BuildDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
//            ListTile(
//              leading: Icon(FeatherIcons.user),
//              title: Text('Created by'),
//              subtitle: Text(widget.buildDetail.createdBy['login']),
//            ),
            ListTile(
              leading: Icon(FeatherIcons.rotateCcw),
              title: Text("Previous build"),
              subtitle: Text(widget.buildDetail.previousState != null
                  ? widget.buildDetail.previousState
                  : 'None'),
            ),
            ListTile(
              leading: Icon(FeatherIcons.gitCommit),
              title: Text("Commit"),
              //subtitle: Text(widget.buildDetail.commit['message']),
              onTap: () {
                // _launchURL(
                //     'https://github.com/${widget.buildDetail.repository['slug']}/commit/${widget.buildDetail.commit['sha']}');
              },
              trailing: Icon(Icons.keyboard_arrow_right),
            ),

            // ListTile(
            //   title: Text("Commit"),
            //   subtitle: Text(widget.buildDetail.commit['sha']),
            // ),
            ListTile(
              title: Text("Commit"),
              subtitle: Text(widget.buildDetail.commit.toString()),
            ),
            ListTile(
              title: Text("Commit"),
              subtitle: Text(widget.buildDetail.createdBy.toString()),
            ),
            ListTile(
              title: Text("Commit"),
              subtitle: Text(widget.buildDetail.repository.toString()),
            )
          ],
        ),
      ),
    );
  }
}
