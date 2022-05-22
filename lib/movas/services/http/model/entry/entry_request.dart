import 'package:calorie/config/mobile_config.dart';
import 'package:calorie/movas/services/http/model/base_http_request.dart';
import 'package:dio/dio.dart';


class GetEntriesForUserRequest extends BaseHttpRequest {
  final DateTime? fromDate;
  final DateTime? toDate;

  GetEntriesForUserRequest({this.fromDate, this.toDate})
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

class GetEntriesRequest extends BaseHttpRequest {
  final DateTime? fromDate;
  final DateTime? toDate;
  final int? page;

  GetEntriesRequest({this.fromDate, this.toDate, this.page=1})
      : super(
            endpoint: "/entries"
                "?page=$page",
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
      "user":userId,
      "createdAt":createdAt.toString()
    };

    if (price!=null) {
      map['price'] = price!;
    }

    return map;
  }
}

class UpdateEntryRequest extends BaseHttpRequest {
  final String name;
  final double calories;
  final double? price;
  final String userId;
  final DateTime createdAt;
  final String entryId;

  UpdateEntryRequest(
      {
        required this.name,
        required this.calories,
        required this.price,
        required this.userId,
        required this.createdAt,
        required this.entryId})
      : super(endpoint: "/entries/$entryId");

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

class DeleteEntryRequest extends BaseHttpRequest {
  final String entryId;

  DeleteEntryRequest({required this.entryId}) : super(endpoint: "/entries/$entryId");

  @override
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>();
  }
}

class GetMetaDataRequest extends BaseHttpRequest {

  GetMetaDataRequest() : super(endpoint: "/entries/metadata");

  @override
  Map<String, dynamic> toMap() {
    return Map<String, dynamic>();
  }
}
