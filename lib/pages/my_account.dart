/*
 * my_account.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:travis_ci/api/travis_ci_api.dart';
import 'package:travis_ci/models/organization.dart';
import 'package:travis_ci/store/form_store/form_store.dart';

class MyAccount extends StatefulWidget {
  final FormStore formStore;

  const MyAccount({Key key, this.formStore}) : super(key: key);
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  PagewiseLoadController<Organization> _pageWiseLoadController;
  CancelToken cancelToken = CancelToken();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ReactionDisposer _disposer;

  Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('My Account'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.formStore.userStore.user.avatarUrl),
                backgroundColor: Colors.white,
              ),
              title: Text(
                widget.formStore.userStore.user.name,
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                widget.formStore.userStore.user.login,
              ),
            ),
            Observer(
                builder: (_) => ListTile(
                      leading: Icon(FeatherIcons.rotateCw),
                      title: Text(
                        'Sync account',
                        //style: TextStyle(fontWeight: FontWeight.w600),2020-01-26T07:49:01Z
                      ),
                      subtitle: widget.formStore.userStore.user.isSyncing
                          ? Text('Syncing...')
                          : Text('synced at: ' +
                              DateFormat().format(
                                  DateFormat('yyyy-MM-ddTHH:mm:ssZ')
                                      .parse(
                                          widget.formStore.userStore.user
                                              .lastSynced,
                                          true)
                                      .toLocal())),
                      trailing: widget.formStore.userStore.user.isSyncing
                          ? SizedBox(
                              width: 20.0,
                              height: 20.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                            )
                          : Container(
                              width: 1,
                            ),
                      onTap: () {
                        if (!widget.formStore.userStore.user.isSyncing) {
                          widget.formStore.userStore.syncAccount(cancelToken);
                        }
                      },
                    )),
            ListTile(
              leading: Icon(FeatherIcons.logOut),
              title: Text(
                'Log out',
                //style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                //TODO Add logout
              },
            ),
            Divider(
              height: 24.0,
              indent: 16.0,
              endIndent: 16.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'ORGANIZATIONS',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            PagewiseListView(
              itemBuilder: _builder,
              shrinkWrap: true,
              showRetry: false,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              pageLoadController: _pageWiseLoadController,
              noItemsFoundBuilder: (context) {
                return Chip(label: Text('No data found'));
              },
              errorBuilder: (context, error) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    error.toString().contains('SocketException:')
                        ? 'Connection to server failed! Please check your internet connection and try again.'
                        : error.toString(),
                    textAlign: TextAlign.center,
                  ),
                );
              },
              loadingBuilder: (context) {
                return CircularProgressIndicator(
                  strokeWidth: 2.0,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageWiseLoadController = PagewiseLoadController(
        pageSize: 10,
        pageFuture: (pageIndex) {
          return TravisCIApi.getOrganizationList(
              (pageIndex * 10), 10, cancelToken);
        });
    _disposer = reaction(
      (_) => widget.formStore.userStore.syncAccountFuture.status,
      (result) => widget.formStore.userStore.syncAccountFuture.status ==
                  FutureStatus.rejected &&
              widget.formStore.userStore.hasApiError
          ? _showError()
          : widget.formStore.userStore.syncAccountFuture.status ==
                      FutureStatus.fulfilled &&
                  !widget.formStore.userStore.hasApiError
              ? _fetchStatus()
              : null,
    );
  }

  Widget _builder(BuildContext context, Organization organization, int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(organization.avatarUrl),
        backgroundColor: Colors.white,
      ),
      title: Text(
        organization.name,
        style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        //TODO Show repos of selected organization
      },
    );
  }

  /// Fetch user data for sync status.
  _fetchStatus() {
    Future.delayed(
        Duration(seconds: 3),
        () => _timer = Timer.periodic(Duration(seconds: 3), (tick) {
              if (widget.formStore.userStore.user.isSyncing) {
                widget.formStore.userStore.getUser(cancelToken);
              } else {
                _timer.cancel();
              }
            }));
  }

  _showError() {
    widget.formStore.userStore.user.isSyncing = false;
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text(widget.formStore.userStore.errorMessage)));
    widget.formStore.userStore.errorMessage = '';
  }
}
