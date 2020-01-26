import 'dart:async';

import 'package:dio/dio.dart';
import 'package:travis_ci/api/api_urls.dart';
import 'package:travis_ci/models/repo.dart';
import 'package:travis_ci/utils/network_util.dart';

class UserRepoApi {
  static Future<List<RepositoriesModel>> getRepoList(String token, String login,
      int offset, int limit, CancelToken cancelToken) async {
    return NetworkUtil().get(
      ApiUrls.reposUrl +
          '?limit=$limit&repository.active=true&offset=$offset&sort_by=default_branch.last_build:desc',
      cancelToken,
      headers: {"Travis-API-Version": "3", "Authorization": "token $token"},
    ).then((dynamic res) {
      return Repositories.getListFromJson(res['repositories']);
    });
  }
}
