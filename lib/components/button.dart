import 'package:flutter/material.dart';

import 'package:byhsapp/theme.dart';

import 'package:byhsapp/components/container.dart';

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
              child: TitleContainer(
                titleIcon: titleIcon,
                title: title,
              ),
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
    this.extended = false,
    required this.onPressed,
  });

  final String? title;
  final IconData? icon;
  final bool extended;
  final void Function()? onPressed;

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

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({
    super.key,
    required this.onSelected,
    required this.title,
    required this.icon,
  });

  final void Function(String) onSelected;
  final List<String> title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final ThemeData theme = Theme.of(context).copyWith(
          colorScheme: ColorScheme(
            brightness: Theme.of(context).brightness,
            primary: Theme.of(context).extension<AppExtension>()!.colors.background,
            onPrimary: Theme.of(context).extension<AppExtension>()!.colors.text,
            secondary: Theme.of(context).extension<AppExtension>()!.colors.container,
            onSecondary: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
            error: Theme.of(context).extension<AppExtension>()!.colors.red,
            onError: Theme.of(context).extension<AppExtension>()!.colors.red,
            background: Theme.of(context).extension<AppExtension>()!.colors.background,
            onBackground: Theme.of(context).extension<AppExtension>()!.colors.text,
            surface: Theme.of(context).extension<AppExtension>()!.colors.background,
            onSurface: Theme.of(context).extension<AppExtension>()!.colors.text,
          ),
        );

        return Theme(
          data: theme,
          child: PopupMenuButton<String>(
            onSelected: onSelected,
            tooltip: "",
            itemBuilder: (BuildContext context) {
              return title.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: ThemeTexts.subheadlineRegular.copyWith(
                      color: Theme.of(context).extension<AppExtension>()!.colors.text,
                    )
                  )
                );
              }).toList();
            },
            icon: icon,
          )
        );
      }
    );
  }
}

class ListButton extends StatelessWidget {
  const ListButton({
    super.key,
    required this.title,
    this.value,
    required this.destinationPage,
  });

  final String title;
  final FutureBuilder? value;
  final Widget destinationPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: ThemeTexts.calloutRegular.copyWith(
                color: Theme.of(context).extension<AppExtension>()!.colors.text,
              ),
            ),
            value ?? const SizedBox(),
          ]
        )
      )
    );
  }
}