import 'package:flutter/material.dart';

import 'package:byhsapp/theme.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
    required this.titleIcon,
    required this.title,
    required this.destinationPage,
    required this.child,
  });

  final IconData titleIcon;
  final String title;
  final Widget destinationPage;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).extension<AppExtension>()!.colors.outline
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        titleIcon,
                        size: 20,
                        color: Theme.of(context).extension<AppExtension>()!.colors.text,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: ThemeTexts.subheadlineEmphasized.copyWith(
                          color: Theme.of(context).extension<AppExtension>()!.colors.text,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "더보기",
                    style: ThemeTexts.subheadlineRegular.copyWith(
                      color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                    ),
                  )
                ],
              )
            ),
            child,
          ],
        )
      )
    );
  }
}

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    this.title,
    this.icon,
    required this.onPressed,
    this.extended = false,
  });

  final String? title;
  final IconData? icon;
  final void Function() onPressed;
  final bool extended;

  @override
  Widget build(BuildContext context) {
    Widget? child;

    if (icon != null) {
      child = Icon(
        icon,
        size: 24,
        color: Theme.of(context).extension<AppExtension>()!.colors.background
      );
    } else if (title != null) {
      child = Text(
        title!,
        style: ThemeTexts.calloutEmphasized.copyWith(
          color: Theme.of(context).extension<AppExtension>()!.colors.background
        )
      );
    }

    return SizedBox(
      height: extended ? 55 : 56,
      width: extended ? double.infinity : 56,
      child: FloatingActionButton(
        onPressed: onPressed,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        foregroundColor: Theme.of(context).extension<AppExtension>()!.colors.background,
        backgroundColor: Theme.of(context).extension<AppExtension>()!.colors.text,
        child: child,
      )
    );
  }
}