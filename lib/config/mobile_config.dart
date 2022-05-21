import 'package:calorie/config/config.dart';

const String user_id = "6288e3ee702038ded4ccd6d5";

class MobileConfig extends Config {
  @override
  String accessToken() {
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjI4OGUzZWU3MDIwMzhkZWQ0Y2NkNmQ1IiwiZGFpbHlDYWxvcnlMaW1pdCI6MjEwMCwibW9udGhseUJ1ZGdldCI6MTAwMH0sImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2NTMxNDA2NDcsImV4cCI6MTY1MzUwMDY0N30.oCwHe8cGTHiE1a6GisYaAUdrmHFteUZL7GXXctgNRhI";
  }

  @override
  String baseUrl() {
    return "http://10.0.2.2:1234/api/v1/";
  }
}