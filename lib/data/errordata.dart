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