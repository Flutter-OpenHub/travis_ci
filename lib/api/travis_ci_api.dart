/*
 * travis_ci_api.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:dio/dio.dart';

import '../init/init.dart';
import '../models/build_model.dart';
import '../models/organization.dart';
import '../models/repo.dart';
import '../models/user.dart';
import '../utils/network_util.dart';
import 'api_urls.dart';

class TravisCIApi {
  static Map<String, String> get headers => {
        "Travis-API-Version": "3",
        "Authorization": kTokenStore.authorizationToken
      };

  NetworkUtil _netUtil = NetworkUtil();

  Future<List<BuildsModel>> getBuilds(
      String id, CancelToken cancelToken) async {
    var res = await _netUtil.get(ApiUrls.repoUrl + id + '/builds', cancelToken,
        headers: headers);
    List<dynamic> _builds = res['builds'];
    return _builds != null
        ? _builds.map((e) => BuildsModel.fromJson(e)).toList()
        : [];
  }

  Future<User> getUser(CancelToken cancelToken, {String id}) async {
    var res = await _netUtil.get(
        ApiUrls.userUrl + (id != null ? '/$id' : ''), cancelToken,
        headers: headers);
    return User.fromJson(res);
  }

  Future<User> syncAccount(String id, CancelToken cancelToken) async {
    var res = await _netUtil.post(ApiUrls.userUrl + '/$id/sync', cancelToken,
        headers: headers);
    return User.fromJson(res);
  }

  static Future<List<BuildsModel>> getMyBuilds(
      int offset, int limit, CancelToken cancelToken) async {
    return NetworkUtil()
        .get(ApiUrls.myBuildsUrl + '?limit=$limit&offset=$offset', cancelToken,
            headers: headers)
        .then((dynamic res) {
      List<dynamic> _builds = res['builds'];
      return _builds != null
          ? _builds.map((e) => BuildsModel.fromJson(e)).toList()
          : [];
    });
  }

  static Future<List<Organization>> getOrganizationList(
      int offset, int limit, CancelToken cancelToken) async {
    return NetworkUtil()
        .get(ApiUrls.organizationsUrl + '?limit=$limit&offset=$offset',
            cancelToken,
            headers: headers)
        .then((dynamic res) {
      return Organizations.getListFromJson(res['organizations']);
    });
  }

  static Future<List<RepositoriesModel>> getRepoList(
      int offset, int limit, CancelToken cancelToken,
      {bool isActive = false}) async {
    return NetworkUtil()
        .get(
            ApiUrls.reposUrl +
                '?limit=$limit${isActive ? '&repository.active=true' : ''}&offset=$offset&sort_by=default_branch.last_build:desc',
            cancelToken,
            headers: headers)
        .then((dynamic res) {
      return Repositories.getListFromJson(res['repositories']);
    });
  }
}
