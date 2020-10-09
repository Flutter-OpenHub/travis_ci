/*
 * builds_api.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

// import 'dart:async';
//
// import 'package:dio/dio.dart';
// import 'package:travis_ci/api/api_urls.dart';
// import 'package:travis_ci/models/build_model.dart';
// import 'package:travis_ci/utils/network_util.dart';
//
// class BuildsApi {
//   NetworkUtil _netUtil = new NetworkUtil();
//
//   Future<List<BuildsModel>> getBuilds(
//       String token, String id, CancelToken cancelToken) async {
//     var res = await _netUtil.get(ApiUrls.repoUrl + id + '/builds', cancelToken,
//         headers: {"Travis-API-Version": "3", "Authorization": "token $token"});
//     List<dynamic> _builds = res['builds'];
//     return _builds != null
//         ? _builds.map((e) => BuildsModel.fromJson(e)).toList()
//         : [];
//   }
//
//   static Future<List<BuildsModel>> getMyBuilds(
//       String token, int offset, int limit, CancelToken cancelToken) async {
//     return NetworkUtil().get(
//       ApiUrls.myBuildsUrl + '?limit=$limit&offset=$offset',
//       cancelToken,
//       headers: {"Travis-API-Version": "3", "Authorization": "token $token"},
//     ).then((dynamic res) {
//       List<dynamic> _builds = res['builds'];
//       return _builds != null
//           ? _builds.map((e) => BuildsModel.fromJson(e)).toList()
//           : [];
//     });
//   }
// }
