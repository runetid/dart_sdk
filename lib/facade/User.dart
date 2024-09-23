import 'package:runetid_sdk/facade/Facade.dart';
import 'package:runetid_sdk/models/user.dart' as model;

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
}