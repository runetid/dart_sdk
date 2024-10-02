
import 'package:runetid_sdk/models/user.dart';

class UserUpdateModel {
  String? firstName;
  String? lastName;
  String? email;
  String? fatherName;

  UserUpdateModel({
    this.firstName,
    this.lastName,
    this.fatherName,
    this.email,
  });

  static UserUpdateModel fromUser(User user) {
    return UserUpdateModel(
        firstName: user.firstName, lastName: user.lastName, email: user.email, fatherName: user.fatherName);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'father_name': fatherName
      };
}
