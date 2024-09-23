Runet.id dart sdk

## Features

contain http client

## Getting started

Get api key and secret from runet.id manager

## Usage

```dart

import 'package:runetid_sdk/http_client.dart';
import 'package:runetid_sdk/models/login_model.dart';
import 'package:runetid_sdk/models/user.dart';

final HttpClient client = HttpClient(apiKey, apiSecret);



Future<User?> userLogin(LoginModel data) {
  return httpClient
      .post("/user/login", jsonEncode(data.toJson()))
      .then((resp) {
    if (resp.statusCode != 200) {
      return null;
    }

    var r = resp.data as Map<String, dynamic>;

    var tokenModel = LoginResponse.fromJson(r['data']);

    return userFetchByToken(tokenModel.token);
  });
}

Future<User?> userFetchByToken(String token) async {
  var user = await httpClient.user.getUserByToken(token);

  if (user == null) {
    return null;
  }

  this.user = user;

  sharedPreferences.setString('USER', jsonEncode(user.toJson()));
  sharedPreferences.setString('TOKEN', token);
  httpClient.setAuthToken(token);

  return user;
}

```
