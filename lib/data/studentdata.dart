import 'package:shared_preferences/shared_preferences.dart';

class StudentData {
  StudentData._privateConstructor();
  
  static final StudentData instance = StudentData._privateConstructor();

  int? grade;
  int? classNumber;

  Future<void> saveStudentData() async {
    final prefs = await SharedPreferences.getInstance();
    if (grade != null) await prefs.setInt("grade", grade!);
    if (classNumber != null) await prefs.setInt("classNumber", classNumber!);
  }
}