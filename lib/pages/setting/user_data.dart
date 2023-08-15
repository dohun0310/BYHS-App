import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  UserData._privateConstructor();

  static final UserData instance = UserData._privateConstructor();

  String schoolgrade = '1';
  String schoolclass = '1';

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('schoolgrade', schoolgrade);
    prefs.setString('schoolclass', schoolclass);
  }
  
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    schoolgrade = prefs.getString('schoolgrade') ?? '1';
    schoolclass = prefs.getString('schoolclass') ?? '1';
  }
}
