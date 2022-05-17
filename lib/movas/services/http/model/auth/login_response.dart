class LoginResponse {
  final String tokenData;

  const LoginResponse({required this.tokenData});

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(tokenData: map['access_token']);
  }

  @override
  String toString() {
    return 'AuthenticationResponse{token: $tokenData}';
  }
}