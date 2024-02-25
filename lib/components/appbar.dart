import 'package:flutter/material.dart';

import 'package:byhsapp/theme.dart';

import 'package:byhsapp/data/studentdata.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.rightIcon,
    required this.destinationPage,
    required this.date,
  });

  final Widget rightIcon;
  final Widget destinationPage;
  final String date;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).extension<AppExtension>()!.colors.background,
      actions: [
        IconButton(
          icon: rightIcon,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destinationPage),
            );
          },
        ),
      ],
      toolbarHeight: 64,
      flexibleSpace: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 64, bottom: 8),
              child: FutureBuilder(
                future: StudentData.instance.loadStudentData(),
                builder: (context, snapshot) {
                  return Text(
                    "부용고등학교 ${StudentData.instance.grade}학년 ${StudentData.instance.classNumber}반",
                    style: ThemeTexts.title2Emphasized.copyWith(
                      color: Theme.of(context).extension<AppExtension>()!.colors.text,
                    )
                  );
                }
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                date,
                style: ThemeTexts.calloutRegular.copyWith(
                  color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130.0);
}

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({
    super.key,
    this.title = "",
    this.leading = true,
  });

  final String title;
  final bool leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading ? IconButton(
        icon: const Icon(Icons.arrow_back, size: 24.0),
        onPressed: () { Navigator.pop(context); },
      ) : null,
      titleSpacing: 0,
      title: Text(
        title,
        style: ThemeTexts.title2Emphasized.copyWith(
          color: Theme.of(context).extension<AppExtension>()!.colors.text,
        ),
      ),
      centerTitle: false,
      elevation: 0.0,
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).extension<AppExtension>()!.colors.background,
      toolbarHeight: 64,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}