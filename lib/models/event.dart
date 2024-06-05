import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
import 'package:runetid_sdk/models/event_palce.dart';

part 'event.g.dart';

enum EventListType { all, past, future }

@JsonSerializable()
class Event {
  int id;
  @JsonKey(name: "id_name")
  String idName;
  String title;
  @JsonKey(name: "start_time")
  String startTime;
  @JsonKey(name: "site_url")
  String siteUrl;
  String info;
  @JsonKey(name: "full_info")
  String fullInfo;
  @JsonKey(name: "end_time")
  String endTime;
  @JsonKey(name: "logo_source")
  String? logoSource;
  @JsonKey(name: "full_info_embedded_url")
  String fullInfoEmbeddedUrl;
  @JsonKey(name: "visible_on_main")
  bool visibleOnMain;
  @JsonKey(name: "default_role_id")
  int defaultRoleId;

  // widgets
  List<EventPlace>? places;

  Event(
      this.id,
      this.title,
      this.idName,
      this.endTime,
      this.fullInfo,
      this.info,
      this.siteUrl,
      this.startTime,
      this.defaultRoleId,
      this.fullInfoEmbeddedUrl,
      this.logoSource,
      this.visibleOnMain, this.places);

  static Event fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  String  dateFormatted() {
    var stat = DateTime.parse(startTime);

    var formatter = DateFormat('dd.MM.yyyy');

    return formatter.format(stat);
  }

  String  timeFormatted() {
    var stat = DateTime.parse(startTime);
    var end = DateTime.parse(endTime);

    var formatter = DateFormat('HH:mm');

    return '${formatter.format(stat)} ${formatter.format(end)}';
  }

  String getPlaceName() {
    if (places == null) {
      return '';
    }

    if (places!.isEmpty) {
      return '';
    }

    return places![0].place;
  }

  get isPlaceEmpty => getPlaceName().isEmpty;
}

class EventListResponse {
  List<Event> data;
  int total;

  EventListResponse(this.data, this.total);

  static EventListResponse fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List<dynamic>;

    var events = list.map((e) => Event.fromJson(e)).toList();

    return EventListResponse(events, json['total'] as int);
  }
}
