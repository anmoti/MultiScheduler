import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenRepository {
  final _storage = const FlutterSecureStorage();
  static String? _accessToken;

  static const _refreshTokenKey = 'refresh_token';

  Future<void> saveTokens(String access, String refresh) async {
    _accessToken = access;
    await _storage.write(key: _refreshTokenKey, value: refresh);
  }

  Future<String?> getAccessToken() async {
    return _accessToken;
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  bool isAccessTokenValid() {
    if (_accessToken == null) return false;

    return !JwtDecoder.isExpired(_accessToken!) &&
        JwtDecoder.getRemainingTime(_accessToken!).inSeconds > 30;
  }

  Future<void> deleteTokens() async {
    _accessToken = null;
    await _storage.deleteAll();
  }
}
