import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:byhsapp/data/datedata.dart';

List<Map<String, dynamic>> notFoundList = [
  {
    "date": today,
    "details": {
      "calorie": "000.0 kcal",
      "dish": "정보가 존재하지 않아요.\n오류라고 생각된다면, 개발자에게 문의해주세요",
    }
  }
];

List<Map<String, dynamic>> errorList = [
  {
    "date": today,
    "details": {
      "calorie": "000.0 kcal",
      "dish": "정보를 가져오지 못했어요.\n인터넷 연결 상태에 문제가 없다면\n개발자에게 문의해주세요.",
    }
  }
];

class Meal {
  Meal({
    required this.dateRange,
  });

  final String dateRange;

  Future<List<Map<String, dynamic>>> fetchMeal() async {
    final url = Uri.parse("${dotenv.get("API_URL")}/get${dateRange}Meal");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, dynamic>> meals = [];

      for (var item in data) {
        Map<String, dynamic> mealDetails = {
          "date": item["RESULT_DATA"]["date"],
          "details": {
            "calorie": item["RESULT_DATA"]["calorie"][0],
            "dish": item["RESULT_DATA"]["dish"][0],
          }
        };
        meals.add(mealDetails);
      }

      return meals;
    } else if (response.statusCode == 404) {
      return notFoundList;
    } else if (response.statusCode == 500) {
      return errorList;
    } else {
      return errorList;
    }
  }
}