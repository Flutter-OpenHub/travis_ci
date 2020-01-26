import 'dart:async';

import 'package:dio/dio.dart';
import 'package:travis_ci/api/api_urls.dart';
import 'package:travis_ci/models/user.dart';
import 'package:travis_ci/utils/network_util.dart';

class AuthUser {
  NetworkUtil _netUtil = new NetworkUtil();

  Future<User> authUser(String token, CancelToken cancelToken) async {
    var res = await _netUtil.get(
      ApiUrls.userUrl,
      cancelToken,
      headers: {"Travis-API-Version": "3", "Authorization": "token $token"},
    );
    return res != null ? User.fromJson(res) : null;
  }
}
