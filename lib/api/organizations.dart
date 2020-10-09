/*
 * organizations.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

// import 'dart:async';
//
// import 'package:dio/dio.dart';
// import 'package:travis_ci/api/api_urls.dart';
// import 'package:travis_ci/models/organization.dart';
// import 'package:travis_ci/utils/network_util.dart';
//
// class OrganizationsApi {
//   static Future<List<Organization>> getOrganizationList(String token,
//       String login, int offset, int limit, CancelToken cancelToken) async {
//     return NetworkUtil().get(
//       ApiUrls.organizationsUrl + '?limit=$limit&offset=$offset',
//       cancelToken,
//       headers: {"Travis-API-Version": "3", "Authorization": "token $token"},
//     ).then((dynamic res) {
//       return Organizations.getListFromJson(res['organizations']);
//     });
//   }
// }
