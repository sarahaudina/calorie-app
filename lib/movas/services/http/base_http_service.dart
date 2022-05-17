import 'model/base_http_request.dart';

abstract class BaseHttpService {
  Future<T> post<T>({
    BaseHttpRequest request,
    T Function(Map<String, dynamic> data) converter,
  });

  Future<T> get<T>(
      {BaseHttpRequest request, T Function(dynamic data) converter});

  Future<T> put<T>(
      {BaseHttpRequest request,
      T Function(Map<String, dynamic> data) converter});

  Future<T> delete<T>(
      {BaseHttpRequest request,
      T Function(Map<String, dynamic> data) converter});

  Future<T> patch<T>(
      {BaseHttpRequest request,
      T Function(Map<String, dynamic> data) converter});

  Future<void> clearCache();
}
