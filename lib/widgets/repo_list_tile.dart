/*
 * repo_list_tile.dart
 *
 * Created by Amit Khairnar on 08/12/2020.
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../models/repo.dart';
import '../pages/details.dart';
import '../store/repo_listtile_store/repo_listtile_store.dart';
import '../utils/dialog.dart';
import '../utils/icon_fonts.dart';

class RepoListTile extends StatefulWidget {
  final RepositoriesModel repositoriesModel;

  const RepoListTile({Key key, this.repositoriesModel}) : super(key: key);
  @override
  _RepoListTileState createState() => _RepoListTileState();
}

class _RepoListTileState extends State<RepoListTile> {
  final RepoListTileStore _repoListTileStore = RepoListTileStore();
  final CancelToken _cancelToken = CancelToken();

  ReactionDisposer _activateDeactivateDisposer;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      leading: Icon(
        TravisLogos.source_repository,
        color: Colors.grey,
      ),
      title: Text(widget.repositoriesModel.name,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
      subtitle: Text(widget.repositoriesModel.owner,
          style: TextStyle(color: Colors.blue, fontSize: 15.0)),
      trailing: Observer(
          builder: (_) => _repoListTileStore.activateDeactivateRepoFuture !=
                      null &&
                  _repoListTileStore.activateDeactivateRepoFuture.status ==
                      FutureStatus.pending
              ? CircularProgressIndicator(
                  strokeWidth: 1.5,
                )
              : Switch(
                  value: widget.repositoriesModel.active,
                  onChanged: widget.repositoriesModel.permissions.activate ||
                          widget.repositoriesModel.permissions.deactivate
                      ? (value) {
                          _repoListTileStore.activateDeactivateRepo(
                              widget.repositoriesModel.id.toString(),
                              !widget.repositoriesModel.active,
                              _cancelToken);
                        }
                      : null,
                )),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return Details(
            repositoriesModel: widget.repositoriesModel,
          );
        }));
      },
    );
  }

  @override
  void dispose() {
    _activateDeactivateDisposer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _activateDeactivateDisposer = reaction(
      (_) => _repoListTileStore.activateDeactivateRepoFuture.status,
      (result) => _repoListTileStore.activateDeactivateRepoFuture.status ==
                  FutureStatus.rejected &&
              _repoListTileStore.hasErrors
          ? _showError()
          : _repoListTileStore.activateDeactivateRepoFuture.status ==
                      FutureStatus.fulfilled &&
                  !_repoListTileStore.hasErrors
              ? _update()
              : null,
    );
  }

  _showError() {
    TravisDialog.showWarning(
        context: context, text: _repoListTileStore.errorMessage);
    _repoListTileStore.errorMessage = '';
  }

  _update() {
    widget.repositoriesModel.active =
        _repoListTileStore.repositoriesModel.active;
  }
}
