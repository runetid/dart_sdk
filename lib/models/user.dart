import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  @JsonKey(name: "runet_id")
  final int runetId;
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  @JsonKey(name: "father_name")
  final String fatherName;
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "photo")
  final String photo;

  DateTime birthday;

  User(
    this.id,
    this.runetId,
    this.email,
    this.firstName,
    this.lastName,
    this.fatherName,
      this.birthday,
      this.photo,
  );

  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
