/*
 * builds_store.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:travis_ci/api/travis_ci_api.dart';
import 'package:travis_ci/models/build_model.dart';

part 'builds_store.g.dart';

class BuildsStore = _BuildsStore with _$BuildsStore;

abstract class _BuildsStore with Store {
  final TravisCIApi _buildsApi = TravisCIApi();

  @observable
  ObservableList<BuildsModel> builds = ObservableList<BuildsModel>();

  @observable
  String errorMessage = '';

  @observable
  ObservableFuture<List<BuildsModel>> getBuildsFuture;

  @computed
  bool get hasErrors => errorMessage.isNotEmpty;

  @action
  Future getBuilds(String id, CancelToken cancelToken) async {
    final future = _buildsApi.getBuilds(id, cancelToken);
    getBuildsFuture = ObservableFuture(future);
    future.then((value) {
      builds = ObservableList.of(value);
    }).catchError((error) {
      errorMessage = error.toString().contains('SocketException:')
          ? 'Connection to server failed! Please check your internet connection and try again.'
          : error.response != null
              ? jsonDecode(error.response.data.toString())['error_message']
              : error.message.toString();
    });
  }
}
