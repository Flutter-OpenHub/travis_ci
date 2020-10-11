/*
 * details.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:dio/dio.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../api/api_urls.dart';
import '../models/repo.dart';
import '../store/builds_store/builds_store.dart';
import '../utils/get_icon.dart';
import '../utils/get_state_color.dart';
import 'show_logs.dart';
import 'user_data_widget.dart';

class Details extends StatefulWidget {
  final RepositoriesModel repositoriesModel;

  const Details({Key key, this.repositoriesModel}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  //TODO Implement function to star and unstar repo. Activate and deactivate repo

  BuildsStore _buildsStore = BuildsStore();

  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.repositoriesModel.owner,
              style: TextStyle(fontSize: 14.0),
            ),
            Text(
              widget.repositoriesModel.name,
              style: TextStyle(fontSize: 16.0),
            )
          ],
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.star_border), onPressed: () {})
        ],
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(
            text: 'Current',
          ),
          Tab(
            text: 'Build History',
          ),
        ]),
      ),
      body: Observer(
          builder: (_) =>
              _buildsStore.getBuildsFuture.status == FutureStatus.fulfilled
                  ? TabBarView(controller: _tabController, children: [
                      _current(),
                      _history(),
                    ])
                  : _buildsStore.getBuildsFuture.status == FutureStatus.rejected
                      ? Center(
                          child: Text(_buildsStore.errorMessage),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        )),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    print(ApiUrls.repoUrl + widget.repositoriesModel.id.toString());
    _buildsStore.getBuilds(
        widget.repositoriesModel.id.toString(), CancelToken());
  }

  Widget _current() {
    return _buildsStore.builds.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: _buildsStore.builds.first.state != null
                      ? GetIcon.getIcon(_buildsStore.builds.first.state)
                      : Icon(
                          Icons.more_horiz,
                          color: Colors.grey,
                        ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FeatherIcons.gitCommit,
                        size: 16.0,
                      ),
                      Text(
                        [
                          " #${_buildsStore.builds.first.number}",
                          _buildsStore.builds.first.state != null
                              ? _buildsStore.builds.first.state
                                  .toString()
                                  .split('.')
                                  .last
                              : 'starting'
                        ].join(" "),
                        style: TextStyle(
                            color: GetStateColor.getStateColor(
                                _buildsStore.builds.first.state),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  title: Text(
                    _buildsStore.builds.first.commit.message,
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: GetStateColor.getStateColor(
                            _buildsStore.builds.first.state)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
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
                            "Commit ${_buildsStore.builds.first.commit.sha.substring(0, 7)}",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      )),
                      Expanded(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FeatherIcons.clock,
                            color: Colors.teal,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            _buildsStore.builds.first.duration != null
                                ? "Ran for ${_buildsStore.builds.first.duration ~/ 60} min "
                                    "${_buildsStore.builds.first.duration % 60} sec"
                                : '-',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    children: [
                      Icon(
                        FeatherIcons.gitPullRequest,
                        color: Colors.teal,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "Compare ${_buildsStore.builds.first.commit.compareUrl.split('/').last.split('...').map((e) => e.substring(0, 7)).join("...")}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    children: [
                      Icon(
                        FeatherIcons.gitBranch,
                        color: Colors.teal,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "Branch master",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Row(
                    children: [
                      Icon(
                        FeatherIcons.calendar,
                        color: Colors.teal,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        _buildsStore.builds.first.createdAt != null
                            ? timeago.format(DateTime.parse(
                                _buildsStore.builds.first.createdAt))
                            : "-",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 12.0),
                  child: UserDataWidget(
                    id: _buildsStore.builds.first.createdBy.id.toString(),
                  ),
                ),
                Divider(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ActionChip(
                        avatar: Icon(
                          Icons.refresh,
                          color: Colors.teal,
                        ),
                        label: Text(
                          'Restart build',
                          style: TextStyle(color: Colors.teal),
                        ),
                        backgroundColor: Colors.white30,
                        shape: StadiumBorder(
                            side: BorderSide(color: Colors.grey[200])),
                        onPressed: () {}),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _buildsStore.builds.first.jobs.length,
                  itemBuilder: (_, index) => ListTile(
                    title: Text("Job Log"),
                    leading: Icon(Icons.description),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ShowLogs(
                                jobId: _buildsStore.builds.first.jobs[index].id,
                              )));
                    },
                  ),
                )
              ],
            ),
          )
        : Center(
            child: Text("No builds for this repository"),
          );
  }

  Widget _history() {
    return _buildsStore.builds.isNotEmpty
        ? ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            itemBuilder: (_, index) => ListTile(
                  title: Text(
                    _buildsStore.builds[index].commit.message,
                    //maxLines: 1,
                    //overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: [
                          GetIcon.getIcon(_buildsStore.builds[index].state,
                              size: 16.0),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            _buildsStore.builds[index].state
                                .toString()
                                .split('.')
                                .last,
                            style: TextStyle(
                                color: GetStateColor.getStateColor(
                                    _buildsStore.builds[index].state),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        children: [
                          Expanded(
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
                                "${_buildsStore.builds[index].commit.sha.substring(0, 7)}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
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
                                _buildsStore.builds[index].duration != null
                                    ? "${_buildsStore.builds[index].duration ~/ 60} min "
                                        "${_buildsStore.builds[index].duration % 60} sec"
                                    : "-",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ))
                        ],
                      )
                    ],
                  ),
                  leading: Text(
                    "#${_buildsStore.builds[index].number}",
                    style: TextStyle(
                        color: GetStateColor.getStateColor(
                            _buildsStore.builds[index].state),
                        fontWeight: FontWeight.bold),
                  ),
                  trailing:
                      IconButton(icon: Icon(Icons.refresh), onPressed: () {}),
                ),
            separatorBuilder: (_, index) => Divider(),
            itemCount: _buildsStore.builds.length)
        : Center(
            child: Text("No builds for this repository"),
          );
  }
}
