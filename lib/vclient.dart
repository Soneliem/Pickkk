// All ValorantClient stuff

import 'package:dio/dio.dart';
import 'package:valorant_client/valorant_client.dart';

dynamic client;

Future<bool> authenticate(username, password, region) async {
  bool output = true;
  client = ValorantClient(
    UserDetails(userName: username, password: password, region: region),
    callback: Callback(
      onError: (String error) {
        print(error);
        output = false;
      },
      onRequestError: (DioError error) {
        print(error.message);
        output = false;
      },
    ),
  );

  await client.init(true);
  return output;
}
