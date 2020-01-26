import 'dart:async';

import 'package:dio/dio.dart';
import 'package:travis_ci/api/api_urls.dart';
import 'package:travis_ci/models/user.dart';
import 'package:travis_ci/utils/network_util.dart';

class UserAccountApi {
  NetworkUtil _netUtil = new NetworkUtil();

  Future<User> syncAccount(
      String token, String id, CancelToken cancelToken) async {
    var res = await _netUtil.post(
      ApiUrls.syncAccountUrl + '/$id/sync',
      cancelToken,
      headers: {"Travis-API-Version": "3", "Authorization": "token $token"},
    );
    return User.fromJson(res);
  }

  Future<User> getUser(String token, CancelToken cancelToken) async {
    var res = await _netUtil.get(
      ApiUrls.userUrl,
      cancelToken,
      headers: {"Travis-API-Version": "3", "Authorization": "token $token"},
    );
    return User.fromJson(res);
  }
}
