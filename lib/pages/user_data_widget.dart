/*
 * user_data_widget.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:travis_ci/store/get_user_store/get_user_store.dart';

class UserDataWidget extends StatefulWidget {
  final String id;

  const UserDataWidget({Key? key, required this.id}) : super(key: key);
  @override
  _UserDataWidgetState createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  final GetUserStore _getUserStore = GetUserStore();
  @override
  void initState() {
    super.initState();
    _getUserStore.getUser(widget.id, CancelToken());
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => _getUserStore.getUserFuture!.status ==
                FutureStatus.fulfilled
            ? Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(_getUserStore.user!.avatarUrl),
                    radius: 12.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                      child: Text(_getUserStore.user!.login,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Theme.of(context).textTheme.headline2!.color,
                          )))
                ],
              )
            : _getUserStore.getUserFuture!.status == FutureStatus.rejected
                ? Text(_getUserStore.errorMessage)
                : Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SizedBox(
                      width: 12.0,
                      height: 12.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                      ),
                    ),
                  ));
  }
}
