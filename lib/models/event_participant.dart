import 'package:json_annotation/json_annotation.dart';
import 'package:runetid_sdk/models/even_role.dart';
import 'package:runetid_sdk/models/user.dart';

part 'event_participant.g.dart';

@JsonSerializable()
class EventParticipant {

  int id;
  @JsonKey(name: "event_id")
  int eventId;
  @JsonKey(name: "user_id")
  int userId;
  @JsonKey(name: "role_id")
  int roleId;
  @JsonKey(name: "created_at")
  String createdAt;

  // Map<String, dynamic> attributes;

  User user;
  EventRole role;

  EventParticipant(this.id, this.user, this.role, this.eventId, this.createdAt, this.roleId, this.userId);


  static EventParticipant fromJson(Map<String, dynamic> json) => _$EventParticipantFromJson(json);
}