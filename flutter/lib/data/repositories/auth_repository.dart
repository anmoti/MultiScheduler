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
    // Access token is memory-only
    return _accessToken;
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  bool isAccessTokenValid() {
    if (_accessToken == null) {
      return false;
    }

    try {
      final isExpired = JwtDecoder.isExpired(_accessToken!);
      final remaining = JwtDecoder.getRemainingTime(_accessToken!).inSeconds;
      
      if (isExpired || remaining <= 30) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteTokens() async {
    _accessToken = null;
    await _storage.deleteAll();
  }
}
