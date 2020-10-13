/*
 * my_builds.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:dio/dio.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:travis_ci/pages/build_details.dart';

import '../api/travis_ci_api.dart';
import '../models/build_model.dart';
import '../utils/get_icon.dart';
import '../utils/get_state_color.dart';
import '../utils/icon_fonts.dart';

class MyBuilds extends StatefulWidget {
  @override
  _MyBuildsState createState() => _MyBuildsState();
}

class _MyBuildsState extends State<MyBuilds> {
  PagewiseLoadController<BuildsModel> _pageWiseLoadController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildUI(),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageWiseLoadController = PagewiseLoadController(
        pageSize: 10,
        pageFuture: (pageIndex) {
          return TravisCIApi.getMyBuilds((pageIndex * 10), 10, CancelToken());
        });
  }

  Widget _builder(BuildContext context, BuildsModel buildsModel, int index) {
    return Column(
      children: [
        ListTile(
          title: Text(
            buildsModel.repository.slug,
            //maxLines: 1,
            //overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Icon(
                    FeatherIcons.gitBranch,
                    color: Colors.teal,
                    size: 14.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    buildsModel.branch.name,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                height: 4.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GetIcon.getIcon(buildsModel.state, size: 16.0),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          "#${buildsModel.number} ${buildsModel.state.toString().split('.').last}",
                          style: TextStyle(
                              color: GetStateColor.getStateColor(
                                  buildsModel.state),
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          FeatherIcons.calendar,
                          color: Colors.teal,
                          size: 14.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          buildsModel.createdAt != null
                              ? timeago
                                  .format(DateTime.parse(buildsModel.createdAt))
                              : "-",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 4.0,
              ),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FeatherIcons.gitCommit,
                          color: Colors.teal,
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          "${buildsModel.commit.sha.substring(0, 7)}",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Icon(
                          Icons.open_in_new,
                          size: 12.0,
                        )
                      ],
                    ),
                  )),
                  Expanded(
                      child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FeatherIcons.clock,
                        color: Colors.teal,
                        size: 14.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "${buildsModel.duration ~/ 60} min "
                        "${buildsModel.duration % 60} sec",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ))
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.only(
                      right: 8.0, left: 4.0, top: 4.0, bottom: 4.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh,
                        color: Colors.teal,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "Restart build",
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          leading: Icon(TravisLogos.source_repository),
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => BuildDetails(
                      buildData: buildsModel,
                      showAppbar: true,
                    ));
          },
        ),
        Divider(
          indent: 72.0,
        ),
      ],
    );
  }

  _buildUI() {
    return PagewiseListView(
      itemBuilder: _builder,
      shrinkWrap: true,
      showRetry: false,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      pageLoadController: _pageWiseLoadController,
      noItemsFoundBuilder: (context) {
        return Chip(label: Text('No builds found!'));
      },
      errorBuilder: (context, error) {
        return Text(error.toString());
      },
      loadingBuilder: (context) {
        return CircularProgressIndicator(
          strokeWidth: 2.0,
        );
      },
    );
  }
}
