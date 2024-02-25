import 'package:flutter/material.dart';

import 'package:byhsapp/theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.rightIcon,
    required this.title,
    required this.date,
  });

  final Widget rightIcon;
  final String title;
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
          onPressed: () {},
        ),
      ],
      flexibleSpace: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 64),
              child: Text(
                title,
                style: ThemeTexts.title2Emphasized.copyWith(
                  color: Theme.of(context).extension<AppExtension>()!.colors.text,
                ),
              ),
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
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Tooltip(
        message: "뒤로 가기",
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () { Navigator.pop(context); },
        )
      ),
      title: Text(
        title,
        style: ThemeTexts.headlineRegular.copyWith(
          color: Theme.of(context).extension<AppExtension>()!.colors.text,
        ),
      ),
      centerTitle: false,
      elevation: 0.0,
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).extension<AppExtension>()!.colors.background,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}