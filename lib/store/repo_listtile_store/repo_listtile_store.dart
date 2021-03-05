/*
 * repo_listtile_store.dart
 *
 * Created by Amit Khairnar on 08/12/2020.
 */

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../api/travis_ci_api.dart';
import '../../models/repo.dart';

part 'repo_listtile_store.g.dart';

class RepoListTileStore = _RepoListTileStore with _$RepoListTileStore;

abstract class _RepoListTileStore with Store {
  final TravisCIApi _buildsApi = TravisCIApi();

  @observable
  RepositoriesModel? repositoriesModel;

  @observable
  String errorMessage = '';

  @observable
  ObservableFuture<RepositoriesModel>? activateDeactivateRepoFuture;

  @computed
  bool get hasErrors => errorMessage.isNotEmpty;

  @action
  Future activateDeactivateRepo(
      String id, bool isActivate, CancelToken cancelToken) async {
    final future =
        _buildsApi.activateDeactivateRepo(id, isActivate, cancelToken);
    activateDeactivateRepoFuture = ObservableFuture(future);
    future.then((value) {
      repositoriesModel = value;
    }).catchError((error) {
      errorMessage = error.toString().contains('SocketException:')
          ? 'Connection to server failed! Please check your internet connection and try again.'
          : error.response != null
              ? jsonDecode(error.response.data.toString())['error_message']
              : error.message.toString();
    });
  }
}
