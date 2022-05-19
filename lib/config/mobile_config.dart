import 'package:calorie/config/config.dart';

const String user_id = "62869285c9c1b87fd05f4def";

class MobileConfig extends Config {
  @override
  String accessToken() {
    return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjI4NjkyODVjOWMxYjg3ZmQwNWY0ZGVmIiwiZGFpbHlDYWxvcnlMaW1pdCI6MjEwMCwibW9udGhseUJ1ZGdldCI6MTAwMH0sImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2NTI5ODY1MTUsImV4cCI6MTY1MzM0NjUxNX0.GWeNOllJ8wDcYe-v4IvztJEzW6JXIWGlhgMHBnoEW9s";
  }

  @override
  String baseUrl() {
    return "http://10.0.2.2:1234/api/v1/";
  }
}