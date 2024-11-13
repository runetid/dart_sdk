import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  @JsonKey(name: "runet_id")
  int runetId;
  @JsonKey(name: "first_name")
  String firstName;
  @JsonKey(name: "last_name")
  String lastName;
  @JsonKey(name: "father_name")
  String fatherName;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "photo")
  String photo;

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
