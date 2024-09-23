import 'package:runetid_sdk/http_client.dart';

abstract class Facade {
  HttpClient client;

  Facade(this.client);
}