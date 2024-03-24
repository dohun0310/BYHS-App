import 'package:home_widget/home_widget.dart';
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

    await HomeWidget.updateWidget(
      name: "TimeTableProvider",
      iOSName: "TimeTable",
    );

    await HomeWidget.saveWidgetData<int>("grade", grade ?? 1);
    await HomeWidget.saveWidgetData<int>("classNumber", classNumber ?? 1);
  }
}