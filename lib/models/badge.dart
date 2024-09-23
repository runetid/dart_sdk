import 'package:json_annotation/json_annotation.dart';

part 'badge.g.dart';

@JsonSerializable()
class Badge {
  final int id;
  @JsonKey(name: "event_id")
  final int eventId;
  @JsonKey(name: "operator_id")
  final int operatorId;
  @JsonKey(name: "user_id")
  final int userId;
  @JsonKey(name: "role_id")
  final int roleId;
  @JsonKey(name: "created_at")
  final DateTime createdAt;

  Badge(this.id, this.eventId, this.operatorId, this.userId, this.roleId, this.createdAt);

  static Badge fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeToJson(this);
}