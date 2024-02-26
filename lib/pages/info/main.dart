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
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/icon.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
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