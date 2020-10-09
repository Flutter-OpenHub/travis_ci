/*
 * get_user_api.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

// import 'dart:async';
//
// import 'package:dio/dio.dart';
// import 'package:travis_ci/api/api_urls.dart';
// import 'package:travis_ci/models/user.dart';
// import 'package:travis_ci/utils/network_util.dart';
//
// class GetUserApi {
//   NetworkUtil _netUtil = new NetworkUtil();
//
//   Future<User> getUser(String id, String token, CancelToken cancelToken) async {
//     var res = await _netUtil.get(
//       ApiUrls.userUrl + '/$id',
//       cancelToken,
//       headers: {"Travis-API-Version": "3", "Authorization": "token $token"},
//     );
//     return User.fromJson(res);
//   }
// }
