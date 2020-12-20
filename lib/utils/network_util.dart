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
  static NetworkUtil _instance = NetworkUtil.internal();

  final Dio _dio = Dio();

  factory NetworkUtil() => _instance;

  NetworkUtil.internal();

  @override
  Future<dynamic> get(String url, CancelToken cancelToken,
      {Map<String, String> headers}) async {
    try {
      Response response = await _dio.get(baseUrl + url,
          options: Options(headers: headers, responseType: ResponseType.plain),
          cancelToken: cancelToken);
      final res = jsonDecode(response.data.toString());
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw Exception(
            "Error while fetching data: ${response.statusCode} ${response.statusMessage}");
      }
      return res;
    } on DioError catch (e) {
      //print(e.error);
      if (e.response != null) {
        //print(e.response.data);
        if (e.response.statusCode == 401) {
          throw Exception("Unauthorized");
        } else if (e.response.statusCode == 403) {
          throw Exception("Access Denied");
        } else if (e.response.statusCode == 500) {
          throw Exception("Internal server error");
        } else {
          throw Exception(
              "Error: [${e.response.statusCode}], ${e.error}, \n${e.message}");
        }
      } else {
        throw Exception(e.message.contains('SocketException')
            ? 'Please check your internet connection'
            : e.message);
      }
    }
  }

  @override
  Future patch(String url, CancelToken cancelToken,
      {Map<String, String> headers, body, encoding}) async {
    try {
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
    } on DioError catch (e) {
      //print(e.error);
      if (e.response != null) {
        //print(e.response.data);
        if (e.response.statusCode == 401) {
          throw Exception("Unauthorized");
        } else if (e.response.statusCode == 403) {
          throw Exception("Access Denied");
        } else if (e.response.statusCode == 500) {
          throw Exception("Internal server error");
        } else {
          throw Exception(
              "Error: [${e.response.statusCode}], ${e.error}, \n${e.message}");
        }
      } else {
        throw Exception(e.message.contains('SocketException')
            ? 'Please check your internet connection'
            : e.message);
      }
    }
  }

  @override
  Future<dynamic> post(String url, CancelToken cancelToken,
      {Map<String, String> headers, body, encoding}) async {
    try {
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
    } on DioError catch (e) {
      //print(e.error);
      if (e.response != null) {
        //print(e.response.data);
        if (e.response.statusCode == 401) {
          throw Exception("Unauthorized");
        } else if (e.response.statusCode == 403) {
          throw Exception("Access Denied");
        } else if (e.response.statusCode == 500) {
          throw Exception("Internal server error");
        } else {
          throw Exception(
              "Error: [${e.response.statusCode}], ${e.error}, \n${e.message}");
        }
      } else {
        throw Exception(e.message.contains('SocketException')
            ? 'Please check your internet connection'
            : e.message);
      }
    }
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
