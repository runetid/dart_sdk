import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:runetid_sdk/facade/facade.dart';
import 'package:runetid_sdk/models/badge.dart';
import 'package:runetid_sdk/models/event_participant.dart';
import 'package:runetid_sdk/models/access.dart' as model;

class Access extends Facade {
  Access(super.client);

  Future<Future<Response>> setEventAccess(int eventId, int userId) async => client.post("/access", {"user_id": userId, "event_id": eventId});

  Future<model.Access?> getLastVisit(int eventId, int userId) async {
    return _getVisitWithSort(eventId, userId, "ASC");
  }

  Future<model.Access?> getFirstVisit(int eventId, int userId) async {
    return _getVisitWithSort(eventId, userId, "DESC");
  }

  Future<model.Access?> _getVisitWithSort(int eventId, int userId, String sort) async {
    final response = await client.get(
        "/access/list?limit=1&offset=0&filter[event_id]=$eventId&filter[user_id]=$userId&sort[field]=created_at&sort[order]=$sort");

    if (response.statusCode == 200) {
      final res = response.data;

      var data = res['data'] as List;

      if (data.isEmpty) {
        return null;
      }

      var p = res['data'][0] as Map<String, dynamic>;

      return model.Access.fromJson(p);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Badge?> setBadge(EventParticipant participant, int operatorId) async {

    var data = {
      "event_id": participant.eventId,
      "operator_id" : operatorId,
      "user_id": participant.userId,
      "role_id": participant.roleId
    };

    final response = await client.post("/storage/badge", jsonEncode(data));

    if (response.statusCode == 200) {
      final data = response.data["data"] as Map<String, dynamic>;

      Badge result = Badge.fromJson(data);

      return result;
    } else {
      return null;
    }
  }
}