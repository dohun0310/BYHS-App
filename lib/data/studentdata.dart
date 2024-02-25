import 'package:shared_preferences/shared_preferences.dart';

class StudentData {
  StudentData._privateConstructor();

  static final StudentData instance = StudentData._privateConstructor();

  int? grade;
  int? classNumber;

  Future<void> loadStudentData() async {
    final prefs = await SharedPreferences.getInstance();
    grade = prefs.getInt("grade");
    classNumber = prefs.getInt("classNumber");
  }
}