import 'package:shared_preferences/shared_preferences.dart';

class AuthController
{
  final String accessToken = 'access-token';

  Future<void> saveAccessToken (String token) async{
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   await sharedPreferences.setString(accessToken, token);
  }
  Future<void> getAccessToken (String token) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   sharedPreferences.getString(accessToken);
  }
  Future<void> clearUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await  sharedPreferences.clear();
  }
}