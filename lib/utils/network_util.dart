import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

class NetworkUtil with NetworkUtilMixin {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  NetworkUtil.internal();

  @override
  Future<dynamic> get(String url, CancelToken cancelToken,
      {Map<String, String> headers}) async {
    //print(url);
    Response response = await Dio().get(url,
        options: Options(headers: headers, responseType: ResponseType.plain),
        cancelToken: cancelToken);
    //print(response.data);
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
  Future<dynamic> post(String url, CancelToken cancelToken,
      {Map<String, String> headers, body, encoding}) async {
    Response response = await Dio().post(url,
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
  Future<dynamic> post(String url, CancelToken cancelToken,
      {Map<String, String> headers, body, encoding});
}
