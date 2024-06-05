
class LoginModel {
  String email = '';
  String password = '';

  Map<String, dynamic> toJson() => {
    'password': password,
    'login': email,
  };
}

class LoginResponse {
  String token;

  LoginResponse(this.token);

  static LoginResponse fromJson(json) {
    return LoginResponse(json['token']);
  }
}