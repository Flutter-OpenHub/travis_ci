import 'dart:async';

import 'package:dio/dio.dart';
import 'package:travis_ci/api/api_urls.dart';
import 'package:travis_ci/models/organization.dart';
import 'package:travis_ci/utils/network_util.dart';

class OrganizationsApi {
  static Future<List<Organization>> getOrganizationList(String token,
      String login, int offset, int limit, CancelToken cancelToken) async {
    return NetworkUtil().get(
      ApiUrls.organizationsUrl,
      cancelToken,
      headers: {"Travis-API-Version": "3", "Authorization": "token $token"},
    ).then((dynamic res) {
      return Organizations.getListFromJson(res['organizations']);
    });
  }
}
