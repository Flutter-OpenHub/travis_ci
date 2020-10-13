/*
 * network_util.dart
 *
 * Created by Amit Khairnar on 09/10/2020.
 */

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../init/init.dart';

class NetworkUtil with NetworkUtilMixin {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();

  final Dio _dio = Dio();

  factory NetworkUtil() => _instance;

  NetworkUtil.internal();

  @override
  Future<dynamic> get(String url, CancelToken cancelToken,
      {Map<String, String> headers}) async {
    //print(url);
    Response response = await _dio.get(baseUrl + url,
        options: Options(headers: headers, responseType: ResponseType.plain),
        cancelToken: cancelToken);
    //debugPrint(response.data.toString());
    final res = jsonDecode(response.data.toString());
    //print(res);
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception(
          "Error while fetching data: ${response.statusCode} ${response.statusMessage}");
    }
    return res;
  }

  @override
  Future patch(String url, CancelToken cancelToken,
      {Map<String, String> headers, body, encoding}) async {
    Response response = await _dio.patch(baseUrl + url,
        options: Options(headers: headers, responseType: ResponseType.plain),
        cancelToken: cancelToken,
        data: body);
    //print(response.data);
    final res = jsonDecode(response.data.toString());
    //final res = response.data;
    //print('Res: $res');
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || res == null) {
      throw Exception(
          "Error : ${response.statusCode} ${response.statusMessage}");
    }
    return res;
  }

  @override
  Future<dynamic> post(String url, CancelToken cancelToken,
      {Map<String, String> headers, body, encoding}) async {
    Response response = await _dio.post(baseUrl + url,
        options: Options(headers: headers, responseType: ResponseType.plain),
        cancelToken: cancelToken,
        data: body);
    //print(response.data);
    final res = jsonDecode(response.data.toString());
    //final res = response.data;
    //print('Res: $res');
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || res == null) {
      throw Exception(
          "Error while fetching data: ${response.statusCode} ${response.statusMessage}");
    }
    return res;
  }
}

mixin NetworkUtilMixin {
  Future<dynamic> get(String url, CancelToken cancelToken,
      {Map<String, String> headers});
  Future<dynamic> patch(String url, CancelToken cancelToken,
      {Map<String, String> headers, body, encoding});
  Future<dynamic> post(String url, CancelToken cancelToken,
      {Map<String, String> headers, body, encoding});
}
