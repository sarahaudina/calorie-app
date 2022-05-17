import 'package:calorie_mobile/movas/services/http/model/base_http_request.dart';
import 'package:dio/dio.dart';

class GetEntriesRequest extends BaseHttpRequest {
  GetEntriesRequest()
      : super(
            endpoint: "/entries",
            useToken: true,
            contentType: Headers.jsonContentType
  );

  Map<String, dynamic> toMap() {
    return Map<String, dynamic>();
  }
}

class CreateEntryRequest extends BaseHttpRequest {
  CreateEntryRequest() : super(endpoint: "");

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

class UpdateEntryRequest extends BaseHttpRequest {
  UpdateEntryRequest({required String endpoint}) : super(endpoint: endpoint);

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}

class DeleteEntryRequest extends BaseHttpRequest {
  DeleteEntryRequest({required String endpoint}) : super(endpoint: endpoint);

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
