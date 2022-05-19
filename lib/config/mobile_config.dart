import 'package:calorie/config/config.dart';

const String user_id = "628364336c71447b86d650f7";

class MobileConfig extends Config {
  @override
  String accessToken() {
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjI4MzY0MzM2YzcxNDQ3Yjg2ZDY1MGY3IiwiZGFpbHlDYWxvcnlMaW1pdCI6MjEwMCwibW9udGhseUJ1ZGdldCI6MTAwMH0sImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2NTI4MzQzMzgsImV4cCI6MTY1MzE5NDMzOH0.DOOMuEr-mM6YGtaNwLZp-DTMFam0zhM6fCL5G3TApek";
  }

  @override
  String baseUrl() {
    return "http://10.0.2.2:1234/api/v1/";
  }
}