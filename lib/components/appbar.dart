import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:byhsapp/theme.dart';

import 'package:byhsapp/components/button.dart';

import 'package:byhsapp/data/datedata.dart';

launchInstagram() async {
  launchUrl(Uri.parse("https://instagram.com/dohun0310"));
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.rightIcon,
    required this.destinationPage,
    required this.grade,
    required this.classNumber,
  });

  final Widget rightIcon;
  final Widget destinationPage;
  final int grade;
  final int classNumber;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).extension<AppExtension>()!.colors.background,
      actions: [
        CustomPopupMenuButton(
          onSelected: (String result) {
            if (result == "설정") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destinationPage),
              );
            }

            if (result == "문의하기") {
              launchInstagram();
            }
          },
          title: const ["설정", "문의하기"],
          icon: rightIcon
        )
      ],
      toolbarHeight: 64,
      flexibleSpace: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 64, bottom: 8),
              child: Text(
                "부용고등학교 $grade학년 $classNumber반",
                style: ThemeTexts.title2Emphasized.copyWith(
                  color: Theme.of(context).extension<AppExtension>()!.colors.text,
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                today,
                style: ThemeTexts.calloutRegular.copyWith(
                  color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                )
              )
            ),
          ]
        )
      )
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