import 'package:calorie/config/mobile_config.dart';
import 'package:calorie/movas/services/http/model/base_http_request.dart';
import 'package:dio/dio.dart';

class GetEntriesRequest extends BaseHttpRequest {
  final DateTime? fromDate;
  final DateTime? toDate;

  GetEntriesRequest({this.fromDate, this.toDate})
      : super(
            endpoint: "/entries/$user_id/all"
                "${addQueries(fromDate: fromDate, toDate: toDate)}",
            useToken: true,
            contentType: Headers.jsonContentType
  );

  Map<String, dynamic> toMap() {
    return Map<String, dynamic>();
  }

  static String addQueries({fromDate, toDate}) {
    String queries = "";
    if (fromDate!=null) {
      queries+="&fromDate=${fromDate.toString()}";
    }
    if (toDate!=null) {
      queries+="&toDate=${toDate.toString()}";
    }

    return queries.length>0 ? queries.replaceFirst("&", "?") : queries;
  }
}

class CreateEntryRequest extends BaseHttpRequest {
  CreateEntryRequest(
      {required this.name, required this.calories, this.price, required this.userId, required this.createdAt})
      : super(
        endpoint: "/entries",
        contentType: Headers.jsonContentType,
        useToken: true);

  final String name;
  final double calories;
  final double? price;
  final String userId;
  final DateTime createdAt;

  @override
  Map<String, dynamic> toMap() {
    var map = {
      "name":name,
      "calories":calories,
      "userId":userId,
      "createdAt":createdAt.toString()
    };

    if (price!=null) {
      map['price'] = price!;
    }

    return map;
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
