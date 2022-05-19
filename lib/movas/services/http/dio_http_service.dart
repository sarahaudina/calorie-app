import 'dart:convert';
import 'dart:developer';
import 'package:calorie/config/config.dart';
import 'package:calorie/config/mobile_config.dart';
import 'package:calorie/config/dashboard_config.dart';
import 'package:calorie/movas/services/http/base_http_service.dart';
import 'package:calorie/movas/services/http/model/base_http_request.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';


class DioInterceptor extends Interceptor {
  DioInterceptor(this.config);
  final Config config;


  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    var headers = {
      "Accept": "application/json",
    };
    if (options.headers["useToken"]) {
      var accessToken = config.accessToken();
      headers.addAll({"Authorization": "Bearer $accessToken"});
      options.headers.addAll(headers);
      return handler.next(options);
    } else {
      options.headers.remove("useToken");
      log("uri "+ options.uri.toString());
      return handler.next(options);
    }
  }
}

class DioHttpService extends BaseHttpService {
  final Dio dio;
  final Config config;

  DioHttpService(this.dio, this.config) {
    dio.options.baseUrl = config.baseUrl();
    dio.options.connectTimeout = 200000; //5s
    dio.options.receiveTimeout = 50000;
    dio.interceptors.addAll([
      DioInterceptor(config)
    ]);

  }

  @override
  Future<T> get<T>(
      {BaseHttpRequest? request, T Function(dynamic data)? converter}) async {
    var options = Options(
        contentType: request!.contentType,
        headers: {"useToken": request.useToken});

    if (request.shouldCache) {
      Options _cacheOptions = buildCacheOptions(Duration(minutes: 5),
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"useToken": request.useToken}));
      options = _cacheOptions;
    }

    final map = request.toMap();

    final response =
        await dio.get(request.endpoint, queryParameters: map, options: options);

    log("get: ${request.endpoint}");
    log("get: ${request.contentType}");
    log("get: ${request.toMap()}");
    log("get: ${map}");

    if (converter == null) {
      if (response.data is String) return (jsonDecode(response.data));

      return response.data;
    }

    if (response.data is String) {
      return converter(jsonDecode(response.data));
    }

    return converter(response.data);
  }

  @override
  Future<T> post<T>(
      {BaseHttpRequest? request,
        T Function(Map<String, dynamic> data)? converter}) async {

    var options = Options(
        contentType: request!.contentType,
        headers: {"useToken": request.useToken});

    if (request.shouldCache) {
      Options _cacheOptions = buildCacheOptions(Duration(minutes: 5),
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"useToken": request.useToken}));
      options = _cacheOptions;
    }

    //buildHeader(request.useToken);

    final map = (request.isMultipart)
        ? FormData.fromMap(request.toMap())
        : request.toMap();
    log("post: ${request.contentType}");
    log("post: ${map}");
    log("post: ${options.headers}");

    final response = await dio.post(
      request.endpoint,
      data: map,
      options: options,
    );


    if (converter == null) {
      return response?.data;
    }

    if (response.data is String) {
      return converter(jsonDecode(response.data));
    }

    return converter(response.data);
  }

  @override
  Future<T> delete<T>(
      {BaseHttpRequest? request,
        T Function(Map<String, dynamic> data)? converter}) async {
    var options = Options(
        contentType: request!.contentType,
        headers: {"useToken": request.useToken});

    if (request.shouldCache) {
      Options _cacheOptions = buildCacheOptions(Duration(minutes: 5),
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"useToken": request.useToken}));
      options = _cacheOptions;
    }

    final map = request.toMap();

    final response =
        await dio.delete(request.endpoint, data: map, options: options);

    print("delete: ${request.endpoint}");

    if (converter == null) {
      return response?.data;
    }

    if (response.data is String) {
      return converter(jsonDecode(response.data));
    }

    return converter(response.data);
  }

  @override
  Future<T> put<T>(
      {BaseHttpRequest? request,
      T Function(Map<String, dynamic> data)? converter}) async {
    var options = Options(
        contentType: request!.contentType,
        headers: {"useToken": request.useToken});

    if (request.shouldCache) {
      Options _cacheOptions = buildCacheOptions(Duration(minutes: 5),
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"useToken": request.useToken}));
      options = _cacheOptions;
    }

    final map = request.toMap();

    final response =
        await dio.put(request.endpoint, data: map, options: options);

    print("put: ${request.endpoint}");

    if (converter == null) {
      if (response.data is String) return (jsonDecode(response.data));
      return response.data;
    }

    if (response.data is String) {
      return converter(jsonDecode(response.data));
    }

    return converter(response.data);
  }

  @override
  Future<void> clearCache() async {

  }

  @override
  Future<T> patch<T>(
      {BaseHttpRequest? request,
      T Function(Map<String, dynamic> data)? converter}) async {
    var options = Options(
        contentType: request!.contentType,
        headers: {"useToken": request.useToken});

    if (request.shouldCache) {
      Options _cacheOptions = buildCacheOptions(Duration(minutes: 5),
          options: Options(
              contentType: Headers.formUrlEncodedContentType,
              headers: {"useToken": request.useToken}));
      options = _cacheOptions;
    }

    final map = request.toMap();

    final response =
        await dio.patch(request.endpoint, data: map, options: options);

    print("patch: ${request.endpoint}");

    if (converter == null) {
      if (response.data is String) return (jsonDecode(response.data));
      return response.data;
    }

    if (response.data is String) {
      return converter(jsonDecode(response.data));
    }

    return converter(response.data);
  }
}
