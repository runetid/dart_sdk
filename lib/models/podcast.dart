
import 'package:json_annotation/json_annotation.dart';

part 'podcast.g.dart';

@JsonSerializable()
class Podcast {
  final int id;
  final String title;
  final int sort;
  final String url;
  @JsonKey(name: "created_at")
  final DateTime createdAt;

  Podcast(this.id, this.title, this.sort, this.url, this.createdAt);

  static Podcast fromJson(Map<String, dynamic> json) => _$PodcastFromJson(json);

  Map<String, dynamic> toJson() => _$PodcastToJson(this);
}