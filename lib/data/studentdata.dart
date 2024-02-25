import 'package:shared_preferences/shared_preferences.dart';

class Studentdata {
  Studentdata._privateConstructor();

  static final Studentdata instance = Studentdata._privateConstructor();

  int? grade;
  int? classNumber;

  Future<void> loadStudentData() async {
    final prefs = await SharedPreferences.getInstance();
    grade = prefs.getInt("grade");
    classNumber = prefs.getInt("classNumber");
  }

  Future<void> saveStudentData() async {
    final prefs = await SharedPreferences.getInstance();
    if (grade != null) await prefs.setInt("grade", grade!);
    if (classNumber != null) await prefs.setInt("classNumber", classNumber!);
  }
}