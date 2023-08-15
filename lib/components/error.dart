import 'package:flutter/material.dart';

Widget widgetError() {
  return Center(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error),
          SizedBox(height: 8),
          Text(
            "내용을 불러오는데 문제가 발생했어요.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "인터넷 연결에 문제가 있거나\n앱 또는 나이스 서버에 문제가 있을 수 있어요.\n",
            style: TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "인터넷 연결에 문제가 없다면 개발자에게 문의해주세요",
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}