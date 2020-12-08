/*
 * build_details.dart
 *
 * Created by Amit Khairnar on 11/10/2020.
 */

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../enum/build_status.dart';
import '../models/build_model.dart';
import '../utils/get_icon.dart';
import '../utils/get_state_color.dart';
import '../utils/open_url.dart';
import '../widgets/restart_cancel_button.dart';
import 'show_logs.dart';
import 'user_data_widget.dart';

class BuildDetails extends StatelessWidget {
  final BuildsModel buildData;
  final bool showAppbar;
  final ValueChanged<bool> onChanged;

  const BuildDetails({Key key, this.buildData, this.showAppbar, this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showAppbar
              ? AppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0.0,
                  title: Text("Build #${buildData.number}"),
                  actions: [
                    IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                  centerTitle: false,
                )
              : Container(),
          ListTile(
            leading: buildData.state != null
                ? GetIcon.getIcon(buildData.state)
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
                    " #${buildData.number}",
                    buildData.state != null
                        ? buildData.state.toString().split('.').last
                        : 'received'
                  ].join(" "),
                  style: TextStyle(
                      color: GetStateColor.getStateColor(buildData.state),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            title: Text(
              buildData.commit.message,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: GetStateColor.getStateColor(buildData.state)),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
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
                      "Commit ${buildData.commit.sha.substring(0, 7)}",
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
                      buildData.duration != null
                          ? "Ran for ${buildData.duration ~/ 60} min "
                              "${buildData.duration % 60} sec"
                          : '-',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ))
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: InkWell(
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
                    [
                      "Compare",
                      buildData.commit.compareUrl
                                  .split('/')
                                  .last
                                  .split('...')
                                  .length >
                              1
                          ? buildData.commit.compareUrl
                              .split('/')
                              .last
                              .split('...')
                              .map((e) => e.substring(0, 7))
                              .join("...")
                          : buildData.commit.compareUrl.split('/').last
                    ].join(" "),
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              onTap: () {
                OpenUrl.launchURL(buildData.commit.compareUrl);
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: InkWell(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    buildData.tag != null
                        ? FeatherIcons.tag
                        : FeatherIcons.gitBranch,
                    color: Colors.teal,
                    size: 16.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    [
                      buildData.tag != null ? "Tag" : "Branch",
                      buildData.branch.name
                    ].join(" "),
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              onTap: () {
                //TODO: Show the branch in web page
                //OpenUrl.launchURL("url");
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
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
                  buildData.createdAt != null
                      ? timeago.format(DateTime.parse(buildData.createdAt))
                      : "-",
                  style: TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            child: UserDataWidget(
              id: buildData.createdBy.id.toString(),
            ),
          ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: ActionChip(
          //         avatar: Icon(
          //           Icons.refresh,
          //           color: Colors.teal,
          //         ),
          //         label: Text(
          //           'Restart build',
          //           style: TextStyle(color: Colors.teal),
          //         ),
          //         backgroundColor: Colors.white30,
          //         shape:
          //             StadiumBorder(side: BorderSide(color: Colors.grey[200])),
          //         onPressed: () {
          //           //TravisCIApi().restartBuild(buildData.jobs.first.id.toString(), CancelToken());
          //           TravisCIApi()
          //               .restartBuild(buildData.id.toString(), CancelToken());
          //         }),
          //   ),
          // ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RestartCancelBuildButton(
                buildId: buildData.id.toString(),
                onChanged: onChanged,
                isRestart: buildData.state == BuildState.passed ||
                    buildData.state == BuildState.failed ||
                    buildData.state == BuildState.errored ||
                    buildData.state == BuildState.canceled,
              ),
            ),
          ),
          Divider(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Jobs",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: buildData.jobs.length,
            itemBuilder: (_, index) => ListTile(
              title: Text(buildData.jobs.length == 1
                  ? 'View build log'
                  : "#${buildData.jobs[index].id} log"),
              leading: Icon(FeatherIcons.fileText),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ShowLogs(
                          jobId: buildData.jobs[index].id,
                        )));
              },
            ),
          )
        ],
      ),
    );
  }
}
