
import 'package:json_annotation/json_annotation.dart';

part 'access.g.dart';

@JsonSerializable()
class Access {
  final int id;
  @JsonKey(name: "event_id")
  final int eventId;
  @JsonKey(name: "user_id")
  final int userId;
  @JsonKey(name: "created_at")
  final DateTime createdAt;

  Access(this.id, this.eventId, this.userId, this.createdAt);

  static Access fromJson(Map<String, dynamic> json) => _$AccessFromJson(json);

  Map<String, dynamic> toJson() => _$AccessToJson(this);
}