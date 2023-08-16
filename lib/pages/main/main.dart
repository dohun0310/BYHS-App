import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:byhsapp/components/todaymeal.dart';
import 'package:byhsapp/components/todaytimetable.dart';
import 'package:byhsapp/pages/setting/user_data.dart';

final now = DateTime.now();
final year = DateFormat('yyyy').format(now);
final month = DateFormat('MM').format(now);
final day = DateFormat('dd').format(now);

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    if (isTablet || isLandscape) {
      return tabletLayout(context);
    } else {
      return mobileLayout(context);
    }
  }

  Widget mobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 16),
              child: widgetTitle(context),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: widgetTodayMeal(context),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: widgetTodayTimeTable(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabletLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 64),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 16),
              child: widgetTitle(context),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: widgetTodayMeal(context)),
                  const SizedBox(width: 16),
                  Expanded(child: widgetTodayTimeTable(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetTitle(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '부용고등학교 ${UserData.instance.schoolgrade}학년 ${UserData.instance.schoolclass}반',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$month월 $day일',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
