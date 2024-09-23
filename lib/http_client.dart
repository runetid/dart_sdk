library runetid_sdk;

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:crypto/crypto.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:runetid_sdk/facade/User.dart';
import 'package:runetid_sdk/facade/access.dart';
import 'package:runetid_sdk/facade/event.dart';

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

  Event get event => Event(this);

  User get user => User(this);

  Access get access => Access(this);
}
