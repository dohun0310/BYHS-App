import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:byhsapp/components/appbar.dart';
import 'package:byhsapp/pages/main/main.dart';
import 'package:byhsapp/pages/setting/user_data.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await UserData.instance.loadUserData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
      ),
      home: const Scaffold(
        appBar: CustomAppBar(),
        body: HomeContent(),
      ),
    );
  }
}