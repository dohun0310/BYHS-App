import 'package:flutter/material.dart';

import 'package:byhsapp/theme.dart';

import 'package:byhsapp/components/appbar.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(title: "정보"),
      body: SafeArea(
        child: Container(
          alignment: AlignmentDirectional.center,
          padding: const EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "부용고등학교",
                style: ThemeTexts.title2Emphasized.copyWith(
                  color: Theme.of(context).extension<AppExtension>()!.colors.text,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "d3h1 제작",
                style: ThemeTexts.calloutRegular.copyWith(
                  color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "버전 1.0.0",
                style: ThemeTexts.calloutRegular.copyWith(
                  color: Theme.of(context).extension<AppExtension>()!.colors.textSecondary,
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}