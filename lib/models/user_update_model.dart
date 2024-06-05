
import 'package:runetid_sdk/models/user.dart';

class UserUpdateModel {
  String? firstName;
  String? lastName;
  String? email;

  UserUpdateModel({
    this.firstName,
    this.lastName,
    this.email,
  });

  static UserUpdateModel fromUser(User user) {
    return UserUpdateModel(
        firstName: user.firstName, lastName: user.lastName, email: user.email);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
      };
}
