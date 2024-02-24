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