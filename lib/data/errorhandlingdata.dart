import 'package:byhsapp/data/datedata.dart';

class ErrorData {
  ErrorData({
    required this.firstKey,
    required this.secondKey,
  });

  final String firstKey;
  final String secondKey;

  List<Map<String, dynamic>> errorList() {
    return [
      {
        "date": today,
        "details": {
          firstKey: firstKey == "calorie" ? "000.0 kcal" : ["", "", ""],
          secondKey: secondKey == "dish" ? "정보를 가져오지 못했어요.\n인터넷 연결 상태에 문제가 없다면,\n개발자에게 문의해주세요." : ["정보를 가져오지 못했어요.", "인터넷 연결 상태에 문제가 없다면,", "개발자에게 문의해주세요."],
        }
      }
    ];
  }
}

class NotFoundData {
  NotFoundData({
    required this.firstKey,
    required this.secondKey,
  });

  final String firstKey;
  final String secondKey;

  List<Map<String, dynamic>> notFoundList() {
    return [
      {
        "date": today,
        "details": {
          firstKey: firstKey == "calorie" ? "000.0 kcal" : ["", "", ""],
          secondKey: secondKey == "dish" ? "정보가 존재하지 않아요.\n오류라고 생각된다면,\n개발자에게 문의해주세요." : ["정보가 존재하지 않아요.", "오류라고 생각된다면,", "개발자에게 문의해주세요"],
        }
      }
    ];
  }
}