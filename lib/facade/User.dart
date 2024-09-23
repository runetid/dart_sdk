import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:runetid_sdk/facade/Facade.dart';
import 'package:runetid_sdk/models/login_model.dart';
import 'package:runetid_sdk/models/register.dart';
import 'package:runetid_sdk/models/user.dart' as model;
import 'package:runetid_sdk/models/user_update_model.dart';

class User extends Facade {
  User(super.client);

  Future<model.User?> getUserByToken(String token) {
    return client.get("/user/byToken/$token").then((resp) {
      if (resp.statusCode != 200) {
        return null;
      }

      var r = resp.data as Map<String, dynamic>;

      var u = model.User.fromJson(r['data']);

      if (u.id < 1) {
        return null;
      }

      return u;
    });
  }

  Future<Response> logout() {
    return client.post('/user/logout', null);
  }

  Future<model.User?> userLogin(LoginModel data) {
    return client
        .post("/user/login", jsonEncode(data.toJson()))
        .then((resp) {
      if (resp.statusCode != 200) {
        return null;
      }

      var r = resp.data as Map<String, dynamic>;

      var tokenModel = LoginResponse.fromJson(r['data']);

      return getUserByToken(tokenModel.token);
    });
  }

  Future<model.User?> userRegister(RegisterModel data) {
    return client
        .post("/user/register", jsonEncode(data.toJson()))
        .then((resp) {
      if (resp.statusCode != 200) {
        return null;
      }
      var r = resp.data as Map<String, dynamic>;
      return getUserByToken(r['token']);
    });
  }

  Future<void> userDelete(model.User user) {
    return client.delete("/user/${user.id}");
  }

  Future<dynamic> uploadPhoto(File file) async {
    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    return client.client.post("/storage/upload", data: formData);
  }

  Future<model.User?> update(int userId, UserUpdateModel data) {

    return client.post("/user/$userId", jsonEncode(data.toJson())).then((resp) {
      if (resp.statusCode != 200) {
        return null;
      }

      var r = resp.data as Map<String, dynamic>;

      var u = model.User.fromJson(r['data']);

      if (u.id < 1) {
        return null;
      }

      return u;
    });

  }
}