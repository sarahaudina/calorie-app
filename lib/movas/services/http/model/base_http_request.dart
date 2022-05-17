import 'package:dio/dio.dart';

abstract class BaseHttpRequest {
  final String endpoint;
  Map<String, dynamic> toMap();

  final String contentType;
  final bool shouldCache;
  final bool useToken;
  final bool isMultipart;

  BaseHttpRequest(
      {this.isMultipart = false,
      required this.endpoint,
      this.contentType = Headers.jsonContentType,
      this.shouldCache = false,
      this.useToken = true});
}
