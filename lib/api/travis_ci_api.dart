/*
 * travis_ci_api.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'package:dio/dio.dart';

import '../init/init.dart';
import '../models/build_emails_response.dart';
import '../models/build_model.dart';
import '../models/organization.dart';
import '../models/private_insights_visibility.dart';
import '../models/repo.dart';
import '../models/user.dart';
import '../utils/network_util.dart';
import 'api_urls.dart';

class TravisCIApi {
  /// Headers required in each api call
  static Map<String, String> get headers => {
        "Travis-API-Version": "3",
        "Authorization": kTokenStore.authorizationToken
      };

  NetworkUtil _netUtil = NetworkUtil();

  /// Fetches the build log
  Future<Map> getBuildLog(String id, CancelToken cancelToken) async {
    var res = await _netUtil.get(ApiUrls.jobUrl + id + '/log', cancelToken,
        headers: headers);
    return res;
  }

  /// Fetches the build log as txt
  Future<String> getBuildLogAsTxt(String id, CancelToken cancelToken) async {
    var res = await _netUtil.get(ApiUrls.jobUrl + id + '/log.txt', cancelToken,
        headers: headers);
    if (res.statusCode < 200 || res.statusCode > 400) {
      throw Exception(
          "Error while fetching data: ${res.statusCode} ${res.statusMessage}");
    }
    return res.data.toString();
  }

  /// Fetches the [List] of Builds
  Future<List<BuildsModel>> getBuilds(
      String id, CancelToken cancelToken) async {
    var res = await _netUtil.get(ApiUrls.repoUrl + id + '/builds', cancelToken,
        headers: headers);
    List<dynamic>? _builds = res['builds'];
    return _builds != null
        ? _builds.map((e) => BuildsModel.fromJson(e)).toList()
        : [];
  }

  /// Fetches the [List] of preferences
  Future<List<dynamic>> getPreferences(CancelToken cancelToken) async {
    var res = await _netUtil.get("/preferences", cancelToken, headers: headers);
    return res['preferences'];
  }

  /// Gets the data of the User
  Future<User> getUser(CancelToken cancelToken, {String? id}) async {
    var res = await _netUtil.get(
        ApiUrls.userUrl + (id != null ? '/$id' : ''), cancelToken,
        headers: headers);
    return User.fromJson(res);
  }

  /// Restart or Cancel the selected Build
  Future<Map> restartCancelBuild(
      String id, bool isRestart, CancelToken cancelToken) async {
    //print(ApiUrls.jobUrl  + id + '/restart');
    //print(ApiUrls.buildUrl + '/' + id + (isRestart ? '/restart' : '/cancel'));
    var res = await _netUtil.post(
      ApiUrls.buildUrl + '/' + id + (isRestart ? '/restart' : '/cancel'),
      cancelToken,
      headers: headers,
    );
    //print(res);
    return res;
  }

  // Future<Map> cancelBuild(String id, CancelToken cancelToken) async {
  //   //print(ApiUrls.jobUrl  + id + '/restart');
  //   print(ApiUrls.buildUrl + '/' + id + '/cancel');
  //   var res = await _netUtil.post(
  //       ApiUrls.buildUrl + '/' + id + '/cancel', cancelToken,
  //       headers: headers);
  //   print(res);
  //   return res;
  // }

  /// Star or Unstar repo
  Future<RepositoriesModel> starUnStarRepo(
      String id, bool isStar, CancelToken cancelToken) async {
    var res = await _netUtil.post(
        ApiUrls.repoUrl + '$id/${isStar ? 'star' : 'unstar'}', cancelToken,
        headers: headers);
    return RepositoriesModel.fromJson(res);
  }

  /// Activates or Deactivates the repository on the CI
  Future<RepositoriesModel> activateDeactivateRepo(
      String id, bool isActivate, CancelToken cancelToken) async {
    var res = await _netUtil.post(
        ApiUrls.repoUrl + '$id/${isActivate ? 'activate' : 'deactivate'}',
        cancelToken,
        headers: headers);
    return RepositoriesModel.fromJson(res);
  }

  /// Syncs the account of current user
  Future<User> syncAccount(String id, CancelToken cancelToken) async {
    var res = await _netUtil.post(ApiUrls.userUrl + '/$id/sync', cancelToken,
        headers: headers);
    return User.fromJson(res);
  }

  /// Updates build email setting for the current user
  Future<BuildEmailsResponse> updateBuildEmails(
      bool value, CancelToken cancelToken) async {
    var res = await _netUtil.patch("/preference/build_emails", cancelToken,
        headers: headers, body: {"value": "$value"});
    return BuildEmailsResponse.fromJson(res);
  }

  /// Updates Private insight visibility setting
  ///
  /// Available only for `com` server users
  Future<PrivateInsightsVisibilityResponse> updatePrivateInsightVisibility(
      String value, CancelToken cancelToken) async {
    var res = await _netUtil.patch(
        "/preference/private_insights_visibility", cancelToken,
        headers: headers, body: {"value": "$value"});
    return PrivateInsightsVisibilityResponse.fromJson(res);
  }

  /// Fetches [List] of Builds
  static Future<List<BuildsModel>> getMyBuilds(
      int offset, int limit, CancelToken cancelToken) async {
    return NetworkUtil()
        .get(
            ApiUrls.myBuildsUrl +
                '?limit=$limit&offset=$offset&sort_by=created_at:desc',
            cancelToken,
            headers: headers)
        .then((dynamic res) {
      List<dynamic>? _builds = res['builds'];
      return _builds != null
          ? _builds.map((e) => BuildsModel.fromJson(e)).toList()
          : [];
    });
  }

  /// Fetches [List] of [Organization] the user has access to
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

  /// Fetches [List] of Repositories of an org or user
  static Future<List<RepositoriesModel>> getOrganizationRepos(
      String orgLogin, int offset, int limit, CancelToken cancelToken) async {
    return NetworkUtil()
        .get(
            "/owner/$orgLogin" +
                ApiUrls.reposUrl +
                '?limit=$limit&offset=$offset',
            cancelToken,
            headers: headers)
        .then((dynamic res) {
      return Repositories.getListFromJson(res['repositories']);
    });
  }

  /// Fetches [List] of Repositories of current user
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
