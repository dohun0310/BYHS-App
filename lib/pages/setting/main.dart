import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:byhsapp/pages/setting/user_data.dart';
import 'package:byhsapp/pages/info/main.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State {
  late String classSetting = "${UserData.instance.schoolgrade}학년 ${UserData.instance.schoolclass}반";

  @override
  void initState() {
    super.initState();
    loadClassSetting();
  }

  loadClassSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      UserData.instance.schoolgrade = prefs.getString('schoolgrade') ?? '1';
      UserData.instance.schoolclass = prefs.getString('schoolclass') ?? '1';
      classSetting = "${UserData.instance.schoolgrade}학년 ${UserData.instance.schoolclass}반"; 
    });
  }

  saveClassSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('schoolgrade', UserData.instance.schoolgrade);
    prefs.setString('schoolclass', UserData.instance.schoolclass);
  }

  Future<void> settingDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('학급 설정'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: '학년'),
                onChanged: (value) {
                  UserData.instance.schoolgrade = value;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ValueInputFormatter(minVal: 1, maxVal: 3)
                ],
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: '반'),
                onChanged: (value) {
                  UserData.instance.schoolclass = value;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ValueInputFormatter(minVal: 0, maxVal: 99)
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('저장'),
              onPressed: () {
                setState(() {
                    classSetting = "${UserData.instance.schoolgrade}학년 ${UserData.instance.schoolclass}반";
                    saveClassSetting();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '설정',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              settingDialog();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "학급 설정",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    classSetting,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  )
                ],
              )
            )
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const InfoPage()));
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: const Text(
                "정보",
                style: TextStyle(
                  fontSize: 16,
                ),
              )
            )
          )
        ],
      )
    );
  }
}

class ValueInputFormatter extends TextInputFormatter {
  final int maxVal;
  final int minVal;
  ValueInputFormatter({required this.maxVal, required this.minVal});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      final int value = int.parse(newValue.text);
      if (value > maxVal || value < minVal) {
        return oldValue;
      }
    }
    return newValue;
  }
}