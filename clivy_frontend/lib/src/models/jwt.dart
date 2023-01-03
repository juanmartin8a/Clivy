import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JWT {
  static String? jsonwebtoken;
  final storage = FlutterSecureStorage();

  getRefreshJWT() async {
    var token = await storage.read(key: "refreshToken");
    if (token == null) {
      return '';
    }
    return token;
  }

  getJWT() async {
    var token = await storage.read(key: "accessToken");
    if (token == null) {
      return '';
    }
    jsonwebtoken = token;
    return token;
  }

  createJWTS(String accessToken, String refreshToken) async {
    await storage.write(key: "accessToken", value: accessToken);
    await storage.write(key: "refreshToken", value: refreshToken);
  }

  deleteJWTS() async {
    await storage.delete(key: "accessToken");
    await storage.delete(key: "refreshToken");
  }
}