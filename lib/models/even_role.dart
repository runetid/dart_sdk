import 'package:json_annotation/json_annotation.dart';

part 'even_role.g.dart';

const roleOrganizer = 6;

@JsonSerializable()
class EventRole {
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "code")
  String code;
  @JsonKey(name: "color")
  String color;
  @JsonKey(name: "valid_period")
  int? validPeriod;

  EventRole(this.id, this.title, this.code, this.color);

  static EventRole fromJson(Map<String, dynamic> json) => _$EventRoleFromJson(json);
}