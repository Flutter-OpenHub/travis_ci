/*
 * restart_cancel_button.dart
 *
 * Created by Amit Khairnar on 08/12/2020.
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../store/restart_cancel_store/restart_cancel_store.dart';
import '../utils/dialog.dart';

class RestartCancelBuildButton extends StatefulWidget {
  final String buildId;
  final bool isRestart;
  final ValueChanged<bool> onChanged;

  const RestartCancelBuildButton(
      {Key key, this.buildId, this.onChanged, this.isRestart = true})
      : super(key: key);
  @override
  _RestartCancelBuildButtonState createState() =>
      _RestartCancelBuildButtonState();
}

class _RestartCancelBuildButtonState extends State<RestartCancelBuildButton> {
  final RestartCancelBuildStore _store = RestartCancelBuildStore();

  ReactionDisposer _restartCancelBuildDisposer;
  @override
  void dispose() {
    _restartCancelBuildDisposer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _restartCancelBuildDisposer = reaction(
      (_) => _store.restartCancelBuildFuture.status,
      (result) => _store.restartCancelBuildFuture.status ==
                  FutureStatus.rejected &&
              _store.hasErrors
          ? _showError()
          : _store.restartCancelBuildFuture.status == FutureStatus.fulfilled &&
                  !_store.hasErrors
              ? _update()
              : null,
    );
  }

  _showError() {
    TravisDialog.showWarning(context: context, text: _store.errorMessage);
    _store.errorMessage = '';
  }

  _update() {
    widget.onChanged(true);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => _store.restartCancelBuildFuture != null &&
                _store.restartCancelBuildFuture.status == FutureStatus.pending
            ? CircularProgressIndicator(
                strokeWidth: 1.5,
              )
            : ActionChip(
                avatar: Icon(
                  widget.isRestart ? Icons.refresh : Icons.close,
                  color: Colors.teal,
                ),
                label: Text(
                  '${widget.isRestart ? "Restart" : "Cancel"} build',
                  style: TextStyle(color: Colors.teal),
                ),
                backgroundColor: Colors.white30,
                shape: StadiumBorder(side: BorderSide(color: Colors.grey[200])),
                onPressed: () {
                  _store.restartCancelBuild(
                      widget.buildId, widget.isRestart, CancelToken());
                  //TravisCIApi().restartBuild(buildData.jobs.first.id.toString(), CancelToken());
                  // TravisCIApi()
                  //     .restartBuild(buildData.id.toString(), CancelToken());
                }));
  }
}
