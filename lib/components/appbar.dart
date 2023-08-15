import 'package:flutter/material.dart';

import 'package:byhsapp/pages/setting/main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingPage()));
          },
          borderRadius: BorderRadius.circular(32),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.settings_outlined),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

