
import 'package:runetid_sdk/models/user.dart';

class RegisterModel {
  String email = '';
  String password = '';

  String lastname = '';
  String firstname = '';

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'lastname': lastname,
    'firstname': firstname,
  };
}

class RegisterResponse {
  String status;
  User? user;

  RegisterResponse(this.status, this.user);

  static RegisterResponse fromJson(json) {
    return RegisterResponse(json['status'], User.fromJson(json['response']));
  }
}