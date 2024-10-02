import 'package:json_annotation/json_annotation.dart';

part 'event_palce.g.dart';

@JsonSerializable()
class EventPlace {
  int id;
  String place;
  EventPlace(this.id, this.place);

  static EventPlace fromJson(Map<String, dynamic> json) => _$EventPlaceFromJson(json);

  Map<String, dynamic> toJson() => _$EventPlaceToJson(this);
}