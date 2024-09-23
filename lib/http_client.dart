library runetid_sdk;

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:crypto/crypto.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:intl/intl.dart';
import 'package:runetid_sdk/models/access.dart';
import 'package:runetid_sdk/models/event.dart';
import 'package:runetid_sdk/models/event_participant.dart';
import 'package:runetid_sdk/models/podcast.dart';
import 'package:runetid_sdk/models/user.dart';

class HttpClient {
  static const userAgent = 'mobile/0.1';
  static const server = 'https://api.runet.id';

  Dio client = Dio()
    ..interceptors.addAll([
      PrettyDioLogger(
          requestBody: false,
          requestHeader: false,
          responseBody: false,
          responseHeader: false),
      DioCacheInterceptor(
          options: CacheOptions(
        store: MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576),
        hitCacheOnErrorExcept: [], // for offline behaviour
      )),
    ]);

  HttpClient(String apiKey, String apiSecret) {
    client.options.followRedirects = true;
    client.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      var time = DateTime.now().millisecondsSinceEpoch;
      var hash = _generateMd5(apiKey + time.toString() + apiSecret);

      options.headers['Apikey'] = apiKey;
      options.headers['Hash'] = hash;
      options.headers['Time'] = time.toString();

      return handler.next(options);
    }));
  }

  final Map<String, String> _headers = {'User-Agent': userAgent};

  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  void _setHeader(String key, String value) {
    _headers[key] = value;
    client.options.headers = _headers;
  }

  void _removeHeader(String key) {
    _headers.remove(key);
  }

  void setAuthToken(String token) {
    _setHeader('Authorization', token);
  }

  void removeAuthToken() {
    _removeHeader('Authorization');
  }

  Future<Response> post(String uri, Object? body) async {
    return await client.post(server + uri, data: body);
  }

  Future<Response> get(String uri) async {
    return await client.get(server + uri);
  }

  Future<Response> delete(String uri) async {
    return await client.delete(server + uri);
  }

  Future<List<Event>> getEvents(
    int limit,
    int offset, {
    EventListType type = EventListType.all,
  }) async {
    var url =
        "/event/list?limit=$limit&offset=$offset&filter[approved]=true&sort[field]=start_time&sort[order]=DESC";

    if (type == EventListType.future) {
      var now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      var date = formatter.format(now);
      url =
          "/event/list?limit=$limit&offset=$offset&filter[end_time]=>$date&filter[approved]=true&sort[field]=start_time&sort[order]=DESC";
    }
    if (type == EventListType.past) {
      var now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      var date = formatter.format(now);
      url =
          "/event/list?limit=$limit&offset=$offset&filter[end_time]=<$date&filter[approved]=true&sort[field]=start_time&sort[order]=DESC";
    }

    final response = await get(url);

    if (response.statusCode == 200) {
      final res = response.data;
      final rr = EventListResponse.fromJson(res);
      return rr.data;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Event> getEventByAlias(String idName) async {
    final response = await get("/event/byAlias/$idName");

    if (response.statusCode == 200) {
      var resp = response.data as Map<String, dynamic>;

      return Event.fromJson(resp['data']);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<User?> getUserByToken(String token) {
    return get("/user/byToken/$token").then((resp) {
      if (resp.statusCode != 200) {
        return null;
      }

      var r = resp.data as Map<String, dynamic>;

      var u = User.fromJson(r['data']);

      if (u.id < 1) {
        return null;
      }

      return u;
    });
  }

  Future<EventParticipant?> getEventParticipant(int eventId, int? runetId) async {
    if (runetId == null) {
      return null;
    }

    final response = await get(
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

    final response = await get("/event/$eventId/participant/list?limit=$limit&offset=$offset$uri");

    if (response.statusCode == 200) {
      final res = response.data;

      var data = res['data'] as List<dynamic>;

      if (data.isEmpty) {
        return null;
      }

      List<EventParticipant> participants = data.map((e) => EventParticipant.fromJson(e as Map<String, dynamic>)).toList();

      return participants;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Future<Response>> setEventAccess(int eventId, int userId) async => post("/access", {"user_id": userId, "event_id": eventId});

  Future<Access?> getLastVisit(int eventId, int userId) async {
    return _getVisitWithSort(eventId, userId, "ASC");
  }

  Future<Access?> getFirstVisit(int eventId, int userId) async {
    return _getVisitWithSort(eventId, userId, "DESC");
  }

  Future<Access?> _getVisitWithSort(int eventId, int userId, String sort) async {
    final response = await get(
        "/access/list?limit=1&offset=0&filter[event_id]=$eventId&filter[user_id]=$userId&sort[field]=created_at&sort[order]=$sort");

    if (response.statusCode == 200) {
      final res = response.data;

      var data = res['data'] as List;

      if (data.isEmpty) {
        return null;
      }

      var p = res['data'][0] as Map<String, dynamic>;

      return Access.fromJson(p);
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Podcast>?> getEventPodcasts(int eventIid,  int limit, int offset,) async {
    final response = await get("/event/podcast/list?limit=$limit&offset=$offset&filter[event_id]=$eventIid");

    if (response.statusCode == 200) {
      final data = response.data["data"] as List<dynamic>;

      List<Podcast> result =
      data.map((e) => Podcast.fromJson(e as Map<String, dynamic>)).toList();

      return result;
    } else {
      return null;
    }
  }

  Future<Badge?> setBadge(EventParticipant participant, int operatorId) async {

    var data = {
      "event_id": participant.eventId,
      "operator_id" : operatorId,
      "user_id": participant.userId,
      "role_id": participant.roleId
    };

    final response = await post("/storage/badge", jsonEncode(data));

    if (response.statusCode == 200) {
      final data = response.data["data"] as Map<String, dynamic>;

      Badge result = Badge.fromJson(data);

      return result;
    } else {
      return null;
    }
  }
}
