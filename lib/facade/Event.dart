import 'package:intl/intl.dart';
import 'package:runetid_sdk/facade/Facade.dart';
import 'package:runetid_sdk/models/even_role.dart';
import 'package:runetid_sdk/models/event.dart' as model;
import 'package:runetid_sdk/models/event_participant.dart';
import 'package:runetid_sdk/models/podcast.dart';
import 'package:runetid_sdk/models/user_update_model.dart';

class Event extends Facade {
  Event(super.client);

  Future<List<model.Event>> getList(
      int limit,
      int offset, {
        model.EventListType type = model.EventListType.all,
      }) async {
    var url =
        "/event/list?limit=$limit&offset=$offset&filter[approved]=true&sort[field]=start_time&sort[order]=DESC";

    if (type == model.EventListType.future) {
      var now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      var date = formatter.format(now);
      url =
      "/event/list?limit=$limit&offset=$offset&filter[end_time]=>$date&filter[approved]=true&sort[field]=start_time&sort[order]=DESC";
    }
    if (type == model.EventListType.past) {
      var now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      var date = formatter.format(now);
      url =
      "/event/list?limit=$limit&offset=$offset&filter[end_time]=<$date&filter[approved]=true&sort[field]=start_time&sort[order]=DESC";
    }

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final res = response.data;
      final rr = model.EventListResponse.fromJson(res);
      return rr.data;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<model.Event> getEventByAlias(String idName) async {
    final response = await client.get("/event/byAlias/$idName");

    if (response.statusCode == 200) {
      var resp = response.data as Map<String, dynamic>;

      return model.Event.fromJson(resp['data']);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Podcast>?> getEventPodcasts(int eventIid,  int limit, int offset,) async {
    final response = await client.get("/event/podcast/list?limit=$limit&offset=$offset&filter[event_id]=$eventIid");

    if (response.statusCode == 200) {
      final data = response.data["data"] as List<dynamic>;

      List<Podcast> result =
      data.map((e) => Podcast.fromJson(e as Map<String, dynamic>)).toList();

      return result;
    } else {
      return null;
    }
  }

  Future<EventParticipant?> getEventParticipant(int eventId, int? runetId) async {
    if (runetId == null) {
      return null;
    }

    final response = await client.get(
        "/event/$eventId/participant/list?limit=1&offset=0&filter[runet_id]=$runetId&filter[event_id]=$eventId");

    if (response.statusCode == 200) {
      final res = response.data;

      var data = res['data'] as List;

      if (data.isEmpty) {
        return null;
      }

      var p = res['data'][0] as Map<String, dynamic>;

      return EventParticipant.fromJson(p);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<EventParticipant>?> getEventParticipants({
    int? eventId,
    int? runetId,
    int? userId,
    String? email,
    String? username,
    int limit = 10,
    int offset = 0,
  }) async {
    if (runetId == null && userId == null && email == null && username == null && eventId == null) {
      return null;
    }

    String uri = "";

    if (runetId != null) {
      uri = "$uri&filter[runet_id]=$runetId";
    }
    if (userId != null) {
      uri = "$uri&filter[user_id]=$userId";
    }
    if (email != null) {
      uri = "$uri&filter[mail]=$email";
    }
    if (username != null) {
      uri = "$uri&filter[username]=$username";
    }
    if (eventId != null) {
      uri = "$uri&filter[event_id]=$eventId";
    }

    final response = await client.get("/event/$eventId/participant/list?limit=$limit&offset=$offset$uri");

    if (response.statusCode == 200) {
      final res = response.data;

      var data = res['data'] as List<dynamic>;

      if (data.isEmpty) {
        return null;
      }

      List<EventParticipant> participants = data.map((e) => EventParticipant.fromJson(e as Map<String, dynamic>)).toList();

      return participants;
    } else {
      throw Exception('Failed to load participants');
    }
  }

  Future<List<EventRole>?> getRoles(int eventId) async {
    final response = await client.get("/event/roles/$eventId/list?limit=100&offset=0");

    if (response.statusCode == 200) {
      final res = response.data;
      var list = res['data'] as List<dynamic>;
      var roles = list.map((e) => EventRole.fromJson(e)).toList();
      return roles;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future chengeRole(int participantId, int newRoleId) {
    return client.put("/event/participant/${participantId}", {"role_id": newRoleId});
  }

  Future<EventParticipant?> updateParticipant(EventParticipant participant) async {
    var userModel  = UserUpdateModel.fromUser(participant.user);
    await client.user.update(participant.userId, userModel);
    await chengeRole(participant.id, participant.roleId);
    return getEventParticipant(participant.eventId, participant.user.runetId);
  }

  Future<EventParticipant?> setParticipantData(int participantId, Map<String, dynamic> data) async {
    final response = await client.put("/event/participant/$participantId/data", data);

    if (response.statusCode == 200) {
      var resp = response.data as Map<String, dynamic>;

      return EventParticipant.fromJson(resp['data']);
    } else {
      throw Exception('Failed to load participant');
    }
  }
}