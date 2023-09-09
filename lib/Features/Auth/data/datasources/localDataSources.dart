
import 'package:shared_preferences/shared_preferences.dart';

const String kUserIdKey = 'user_id_key';

abstract class AuthLocalDataSource {
  Future<String?> getUserId();
  Future<void> cacheUserId(String userId);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUserId(String userId) async {
    await sharedPreferences.setString(kUserIdKey, userId);
  }

  @override
  Future<String?> getUserId() async {
    return sharedPreferences.getString(kUserIdKey);
  }
}
