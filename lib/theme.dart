import 'package:flutter/material.dart';

class AbsoluteColors {
  const AbsoluteColors({
    required this.grey10,
    required this.grey20,
    required this.grey30,
    required this.grey40,
    required this.grey50,
    required this.grey60,
    required this.grey70,
    required this.grey80,
    required this.grey90,
    required this.red10,
    required this.red20,
    required this.red30,
    required this.red40,
    required this.red50,
    required this.red60,
    required this.red70,
    required this.red80,
    required this.red90,
    required this.green10,
    required this.green20,
    required this.green30,
    required this.green40,
    required this.green50,
    required this.green60,
    required this.green70,
    required this.green80,
    required this.green90,
    required this.blue10,
    required this.blue20,
    required this.blue30,
    required this.blue40,
    required this.blue50,
    required this.blue60,
    required this.blue70,
    required this.blue80,
    required this.blue90,
    required this.purple10,
    required this.purple20,
    required this.purple30,
    required this.purple40,
    required this.purple50,
    required this.purple60,
    required this.purple70,
    required this.purple80,
    required this.purple90,
    required this.yellow10,
    required this.yellow20,
    required this.yellow30,
    required this.yellow40,
    required this.yellow50,
    required this.yellow60,
    required this.yellow70,
    required this.yellow80,
    required this.yellow90,
  });

  final Color grey10;
  final Color grey20;
  final Color grey30;
  final Color grey40;
  final Color grey50;
  final Color grey60;
  final Color grey70;
  final Color grey80;
  final Color grey90;
  final Color red10;
  final Color red20;
  final Color red30;
  final Color red40;
  final Color red50;
  final Color red60;
  final Color red70;
  final Color red80;
  final Color red90;
  final Color green10;
  final Color green20;
  final Color green30;
  final Color green40;
  final Color green50;
  final Color green60;
  final Color green70;
  final Color green80;
  final Color green90;
  final Color blue10;
  final Color blue20;
  final Color blue30;
  final Color blue40;
  final Color blue50;
  final Color blue60;
  final Color blue70;
  final Color blue80;
  final Color blue90;
  final Color purple10;
  final Color purple20;
  final Color purple30;
  final Color purple40;
  final Color purple50;
  final Color purple60;
  final Color purple70;
  final Color purple80;
  final Color purple90;
  final Color yellow10;
  final Color yellow20;
  final Color yellow30;
  final Color yellow40;
  final Color yellow50;
  final Color yellow60;
  final Color yellow70;
  final Color yellow80;
  final Color yellow90;
}

class ThemeColors {
  const ThemeColors({
    required this.background,
    required this.text,
    required this.textSecondary,
    required this.container,
    required this.containerSecondary,
    required this.correct,
    required this.incorrect,
    required this.splash,
    required this.highlight,
    required this.outline,
    required this.red,
    required this.green,
    required this.blue,
    required this.purple,
    required this.yellow,
    required this.black,
    required this.white,
  });

  final Color background;
  final Color text;
  final Color textSecondary;
  final Color container;
  final Color containerSecondary;
  final Color correct;
  final Color incorrect;
  final Color splash;
  final Color highlight;
  final Color outline;
  final Color red;
  final Color green;
  final Color blue;
  final Color purple;
  final Color yellow;
  final Color black;
  final Color white;
}

@immutable
class AppExtension extends ThemeExtension<AppExtension> {
  const AppExtension({
    required this.brightness,
    required this.grey10,
    required this.grey20,
    required this.grey30,
    required this.grey40,
    required this.grey50,
    required this.grey60,
    required this.grey70,
    required this.grey80,
    required this.grey90,
    required this.red10,
    required this.red20,
    required this.red30,
    required this.red40,
    required this.red50,
    required this.red60,
    required this.red70,
    required this.red80,
    required this.red90,
    required this.green10,
    required this.green20,
    required this.green30,
    required this.green40,
    required this.green50,
    required this.green60,
    required this.green70,
    required this.green80,
    required this.green90,
    required this.blue10,
    required this.blue20,
    required this.blue30,
    required this.blue40,
    required this.blue50,
    required this.blue60,
    required this.blue70,
    required this.blue80,
    required this.blue90,
    required this.purple10,
    required this.purple20,
    required this.purple30,
    required this.purple40,
    required this.purple50,
    required this.purple60,
    required this.purple70,
    required this.purple80,
    required this.purple90,
    required this.yellow10,
    required this.yellow20,
    required this.yellow30,
    required this.yellow40,
    required this.yellow50,
    required this.yellow60,
    required this.yellow70,
    required this.yellow80,
    required this.yellow90,
  });

  final Brightness brightness;
  final Color grey10;
  final Color grey20;
  final Color grey30;
  final Color grey40;
  final Color grey50;
  final Color grey60;
  final Color grey70;
  final Color grey80;
  final Color grey90;
  final Color red10;
  final Color red20;
  final Color red30;
  final Color red40;
  final Color red50;
  final Color red60;
  final Color red70;
  final Color red80;
  final Color red90;
  final Color green10;
  final Color green20;
  final Color green30;
  final Color green40;
  final Color green50;
  final Color green60;
  final Color green70;
  final Color green80;
  final Color green90;
  final Color blue10;
  final Color blue20;
  final Color blue30;
  final Color blue40;
  final Color blue50;
  final Color blue60;
  final Color blue70;
  final Color blue80;
  final Color blue90;
  final Color purple10;
  final Color purple20;
  final Color purple30;
  final Color purple40;
  final Color purple50;
  final Color purple60;
  final Color purple70;
  final Color purple80;
  final Color purple90;
  final Color yellow10;
  final Color yellow20;
  final Color yellow30;
  final Color yellow40;
  final Color yellow50;
  final Color yellow60;
  final Color yellow70;
  final Color yellow80;
  final Color yellow90;

  AbsoluteColors get absolute => AbsoluteColors(
    grey10: grey10,
    grey20: grey20,
    grey30: grey30,
    grey40: grey40,
    grey50: grey50,
    grey60: grey60,
    grey70: grey70,
    grey80: grey80,
    grey90: grey90,
    red10: red10,
    red20: red20,
    red30: red30,
    red40: red40,
    red50: red50,
    red60: red60,
    red70: red70,
    red80: red80,
    red90: red90,
    green10: green10,
    green20: green20,
    green30: green30,
    green40: green40,
    green50: green50,
    green60: green60,
    green70: green70,
    green80: green80,
    green90: green90,
    blue10: blue10,
    blue20: blue20,
    blue30: blue30,
    blue40: blue40,
    blue50: blue50,
    blue60: blue60,
    blue70: blue70,
    blue80: blue80,
    blue90: blue90,
    purple10: purple10,
    purple20: purple20,
    purple30: purple30,
    purple40: purple40,
    purple50: purple50,
    purple60: purple60,
    purple70: purple70,
    purple80: purple80,
    purple90: purple90,
    yellow10: yellow10,
    yellow20: yellow20,
    yellow30: yellow30,
    yellow40: yellow40,
    yellow50: yellow50,
    yellow60: yellow60,
    yellow70: yellow70,
    yellow80: yellow80,
    yellow90: yellow90
  );

  ThemeColors get colors => ThemeColors(
    background: grey10,
    text: grey90,
    textSecondary: grey70,
    container: brightness == Brightness.light ? grey40 : grey20,
    containerSecondary: brightness == Brightness.light ? grey50 : grey30,
    correct: brightness == Brightness.light ? green90 : green10,
    incorrect: brightness == Brightness.light ? red90 : red10,
    splash: brightness == Brightness.light ? grey60 : grey40,
    highlight: brightness == Brightness.light ? grey60 : grey40,
    outline: brightness == Brightness.light ? grey30 : grey20,
    red: brightness == Brightness.light ? red90 : red10,
    green: brightness == Brightness.light ? green90 : green10,
    blue: brightness == Brightness.light ? blue90 : blue10,
    purple: brightness == Brightness.light ? purple90 : purple10,
    yellow: brightness == Brightness.light ? yellow90 : yellow10,
    black: brightness == Brightness.light ? grey90 : grey10,
    white: brightness == Brightness.light ? grey10 : grey90,
  );

  @override
  AppExtension copyWith({
    Brightness? brightness,
    Color? grey10,
    Color? grey20,
    Color? grey30,
    Color? grey40,
    Color? grey50,
    Color? grey60,
    Color? grey70,
    Color? grey80,
    Color? grey90,
    Color? red10,
    Color? red20,
    Color? red30,
    Color? red40,
    Color? red50,
    Color? red60,
    Color? red70,
    Color? red80,
    Color? red90,
    Color? green10,
    Color? green20,
    Color? green30,
    Color? green40,
    Color? green50,
    Color? green60,
    Color? green70,
    Color? green80,
    Color? green90,
    Color? blue10,
    Color? blue20,
    Color? blue30,
    Color? blue40,
    Color? blue50,
    Color? blue60,
    Color? blue70,
    Color? blue80,
    Color? blue90,
    Color? purple10,
    Color? purple20,
    Color? purple30,
    Color? purple40,
    Color? purple50,
    Color? purple60,
    Color? purple70,
    Color? purple80,
    Color? purple90,
    Color? yellow10,
    Color? yellow20,
    Color? yellow30,
    Color? yellow40,
    Color? yellow50,
    Color? yellow60,
    Color? yellow70,
    Color? yellow80,
    Color? yellow90,
  }) => AppExtension(
      brightness: brightness ?? this.brightness,
      grey10: grey10 ?? this.grey10,
      grey20: grey20 ?? this.grey20,
      grey30: grey30 ?? this.grey30,
      grey40: grey40 ?? this.grey40,
      grey50: grey50 ?? this.grey50,
      grey60: grey60 ?? this.grey60,
      grey70: grey70 ?? this.grey70,
      grey80: grey80 ?? this.grey80,
      grey90: grey90 ?? this.grey90,
      red10: red10 ?? this.red10,
      red20: red20 ?? this.red20,
      red30: red30 ?? this.red30,
      red40: red40 ?? this.red40,
      red50: red50 ?? this.red50,
      red60: red60 ?? this.red60,
      red70: red70 ?? this.red70,
      red80: red80 ?? this.red80,
      red90: red90 ?? this.red90,
      green10: green10 ?? this.green10,
      green20: green20 ?? this.green20,
      green30: green30 ?? this.green30,
      green40: green40 ?? this.green40,
      green50: green50 ?? this.green50,
      green60: green60 ?? this.green60,
      green70: green70 ?? this.green70,
      green80: green80 ?? this.green80,
      green90: green90 ?? this.green90,
      blue10: blue10 ?? this.blue10,
      blue20: blue20 ?? this.blue20,
      blue30: blue30 ?? this.blue30,
      blue40: blue40 ?? this.blue40,
      blue50: blue50 ?? this.blue50,
      blue60: blue60 ?? this.blue60,
      blue70: blue70 ?? this.blue70,
      blue80: blue80 ?? this.blue80,
      blue90: blue90 ?? this.blue90,
      purple10: purple10 ?? this.purple10,
      purple20: purple20 ?? this.purple20,
      purple30: purple30 ?? this.purple30,
      purple40: purple40 ?? this.purple40,
      purple50: purple50 ?? this.purple50,
      purple60: purple60 ?? this.purple60,
      purple70: purple70 ?? this.purple70,
      purple80: purple80 ?? this.purple80,
      purple90: purple90 ?? this.purple90,
      yellow10: yellow10 ?? this.yellow10,
      yellow20: yellow20 ?? this.yellow20,
      yellow30: yellow30 ?? this.yellow30,
      yellow40: yellow40 ?? this.yellow40,
      yellow50: yellow50 ?? this.yellow50,
      yellow60: yellow60 ?? this.yellow60,
      yellow70: yellow70 ?? this.yellow70,
      yellow80: yellow80 ?? this.yellow80,
      yellow90: yellow90 ?? this.yellow90,
    );

  @override
  AppExtension lerp(AppExtension? other, double t) {
    if (other is! AppExtension) return this;

    return copyWith(
      brightness: t < 0.5 ? brightness : other.brightness,
      grey10: Color.lerp(grey10, other.grey10, t)!,
      grey20: Color.lerp(grey20, other.grey20, t)!,
      grey30: Color.lerp(grey30, other.grey30, t)!,
      grey40: Color.lerp(grey40, other.grey40, t)!,
      grey50: Color.lerp(grey50, other.grey50, t)!,
      grey60: Color.lerp(grey60, other.grey60, t)!,
      grey70: Color.lerp(grey70, other.grey70, t)!,
      grey80: Color.lerp(grey80, other.grey80, t)!,
      grey90: Color.lerp(grey90, other.grey90, t)!,
      red10: Color.lerp(red10, other.red10, t)!,
      red20: Color.lerp(red20, other.red20, t)!,
      red30: Color.lerp(red30, other.red30, t)!,
      red40: Color.lerp(red40, other.red40, t)!,
      red50: Color.lerp(red50, other.red50, t)!,
      red60: Color.lerp(red60, other.red60, t)!,
      red70: Color.lerp(red70, other.red70, t)!,
      red80: Color.lerp(red80, other.red80, t)!,
      red90: Color.lerp(red90, other.red90, t)!,
      green10: Color.lerp(green10, other.green10, t)!,
      green20: Color.lerp(green20, other.green20, t)!,
      green30: Color.lerp(green30, other.green30, t)!,
      green40: Color.lerp(green40, other.green40, t)!,
      green50: Color.lerp(green50, other.green50, t)!,
      green60: Color.lerp(green60, other.green60, t)!,
      green70: Color.lerp(green70, other.green70, t)!,
      green80: Color.lerp(green80, other.green80, t)!,
      green90: Color.lerp(green90, other.green90, t)!,
      blue10: Color.lerp(blue10, other.blue10, t)!,
      blue20: Color.lerp(blue20, other.blue20, t)!,
      blue30: Color.lerp(blue30, other.blue30, t)!,
      blue40: Color.lerp(blue40, other.blue40, t)!,
      blue50: Color.lerp(blue50, other.blue50, t)!,
      blue60: Color.lerp(blue60, other.blue60, t)!,
      blue70: Color.lerp(blue70, other.blue70, t)!,
      blue80: Color.lerp(blue80, other.blue80, t)!,
      blue90: Color.lerp(blue90, other.blue90, t)!,
      purple10: Color.lerp(purple10, other.purple10, t)!,
      purple20: Color.lerp(purple20, other.purple20, t)!,
      purple30: Color.lerp(purple30, other.purple30, t)!,
      purple40: Color.lerp(purple40, other.purple40, t)!,
      purple50: Color.lerp(purple50, other.purple50, t)!,
      purple60: Color.lerp(purple60, other.purple60, t)!,
      purple70: Color.lerp(purple70, other.purple70, t)!,
      purple80: Color.lerp(purple80, other.purple80, t)!,
      purple90: Color.lerp(purple90, other.purple90, t)!,
      yellow10: Color.lerp(yellow10, other.yellow10, t)!,
      yellow20: Color.lerp(yellow20, other.yellow20, t)!,
      yellow30: Color.lerp(yellow30, other.yellow30, t)!,
      yellow40: Color.lerp(yellow40, other.yellow40, t)!,
      yellow50: Color.lerp(yellow50, other.yellow50, t)!,
      yellow60: Color.lerp(yellow60, other.yellow60, t)!,
      yellow70: Color.lerp(yellow70, other.yellow70, t)!,
      yellow80: Color.lerp(yellow80, other.yellow80, t)!,
      yellow90: Color.lerp(yellow90, other.yellow90, t)!,
    );
  }

  factory AppExtension.light() => const AppExtension(
    brightness: Brightness.light,
    grey10: Color(0xFFFCFCFC),
    grey20: Color(0xFFFEFEFE),
    grey30: Color(0xFFDFDFDF),
    grey40: Color(0xFFBFBFBF),
    grey50: Color(0xFF949494),
    grey60: Color(0xFF777777),
    grey70: Color(0xFF555555),
    grey80: Color(0xFF303030),
    grey90: Color(0xFF111111),
    red10: Color(0xFFFEE9E9),
    red20: Color(0xFFFED3D3),
    red30: Color(0xFFFDBDBD),
    red40: Color(0xFFFDA7A7),
    red50: Color(0xFFFD9191),
    red60: Color(0xFFFC7B7B),
    red70: Color(0xFFFC6565),
    red80: Color(0xFFFC4F4F),
    red90: Color(0xFFFC4F4F),
    green10: Color(0xFFE8FAED),
    green20: Color(0xFFD1F5DB),
    green30: Color(0xFFBBF0C9),
    green40: Color(0xFFA4EBB8),
    green50: Color(0xFF8DE6A6),
    green60: Color(0xFF77E194),
    green70: Color(0xFF60DC82),
    green80: Color(0xFF4AD871),
    green90: Color(0xFF4AD871),
    blue10: Color(0xFFE6F0FF),
    blue20: Color(0xFFCEE1FF),
    blue30: Color(0xFFB5D2FF),
    blue40: Color(0xFF9DC4FF),
    blue50: Color(0xFF85B5FF),
    blue60: Color(0xFF6CA6FF),
    blue70: Color(0xFF5497FF),
    blue80: Color(0xFF3C89FF),
    blue90: Color(0xFF3C89FF),
    purple10: Color(0xFFECE1F8),
    purple20: Color(0xFFDAC3F2),
    purple30: Color(0xFFC8A5EB),
    purple40: Color(0xFFB687E5),
    purple50: Color(0xFFA469DF),
    purple60: Color(0xFF924BD8),
    purple70: Color(0xFF802DD2),
    purple80: Color(0xFF6E10CC),
    purple90: Color(0xFF6E10CC),
    yellow10: Color(0xFFFFF7E7),
    yellow20: Color(0xFFFFEFD0),
    yellow30: Color(0xFFFFE7B8),
    yellow40: Color(0xFFFFDFA1),
    yellow50: Color(0xFFFFD78A),
    yellow60: Color(0xFFFFCF72),
    yellow70: Color(0xFFFFC75B),
    yellow80: Color(0xFFFFBF44),
    yellow90: Color(0xFFFFBF44),
  );

  factory AppExtension.dark() => const AppExtension(
    brightness: Brightness.dark,
    grey10: Color(0xFF111111),
    grey20: Color(0xFF303030),
    grey30: Color(0xFF555555),
    grey40: Color(0xFF777777),
    grey50: Color(0xFF949494),
    grey60: Color(0xFFBFBFBF),
    grey70: Color(0xFFDFDFDF),
    grey80: Color(0xFFFEFEFE),
    grey90: Color(0xFFFCFCFC),
    red10: Color(0xFFFF5656),
    red20: Color(0xFFC54242),
    red30: Color(0xFFA83838),
    red40: Color(0xFF8C2F2F),
    red50: Color(0xFF6F2525),
    red60: Color(0xFF521B1B),
    red70: Color(0xFF351111),
    red80: Color(0xFF190808),
    red90: Color(0xFF190808),
    green10: Color(0xFF51ED7C),
    green20: Color(0xFF3EB760),
    green30: Color(0xFF359C52),
    green40: Color(0xFF2C8244),
    green50: Color(0xFF236736),
    green60: Color(0xFF1A4C28),
    green70: Color(0xFF11311A),
    green80: Color(0xFF08170C),
    green90: Color(0xFF08170C),
    blue10: Color(0xFF4296FF),
    blue20: Color(0xFF3374C5),
    blue30: Color(0xFF2B63A8),
    blue40: Color(0xFF24528C),
    blue50: Color(0xFF1C416F),
    blue60: Color(0xFF153052),
    blue70: Color(0xFF0D1F35),
    blue80: Color(0xFF060F19),
    blue90: Color(0xFF060F19),
    purple10: Color(0xFF7911E0),
    purple20: Color(0xFF5D0DAD),
    purple30: Color(0xFF500B94),
    purple40: Color(0xFF42097B),
    purple50: Color(0xFF340761),
    purple60: Color(0xFF270548),
    purple70: Color(0xFF19032F),
    purple80: Color(0xFF0C0116),
    purple90: Color(0xFF0C0116),
    yellow10: Color(0xFFFFD24A),
    yellow20: Color(0xFFC5A239),
    yellow30: Color(0xFFA88B30),
    yellow40: Color(0xFF8C7328),
    yellow50: Color(0xFF6F5B20),
    yellow60: Color(0xFF524417),
    yellow70: Color(0xFF352C0F),
    yellow80: Color(0xFF191507),
    yellow90: Color(0xFF191507),
  );
}

class ThemeTexts {
  static const TextStyle largeTitleRegular = TextStyle(
    fontSize: 34,
    height: 41 / 34,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.4,
  );

  static const TextStyle largeTitleEmphasized = TextStyle(
    fontSize: 34,
    height: 41 / 34,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
  );

  static const TextStyle title1Regular = TextStyle(
    fontSize: 28,
    height: 34 / 28,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.4,
  );

  static const TextStyle title1Emphasized = TextStyle(
    fontSize: 28,
    height: 34 / 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
  );

  static const TextStyle title2Regular = TextStyle(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.4,
  );

  static const TextStyle title2Emphasized = TextStyle(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
  );

  static const TextStyle title3Regular = TextStyle(
    fontSize: 20,
    height: 25 / 20,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.4,
  );

  static const TextStyle title3Emphasized = TextStyle(
    fontSize: 20,
    height: 25 / 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  );

  static const TextStyle headlineRegular = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  );

  static const TextStyle headlineItalic = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.4,
  );

  static const TextStyle bodyRegular = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.4,
  );

  static const TextStyle bodyEmphasized = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  );

  static const TextStyle bodyItalic = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.4,
  );

  static const TextStyle bodyEmphasizedItalic = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.4,
  );

  static const TextStyle calloutRegular = TextStyle(
    fontSize: 16,
    height: 21 / 16,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.4,
  );

  static const TextStyle calloutEmphasized = TextStyle(
    fontSize: 16,
    height: 21 / 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  );

  static const TextStyle calloutItalic = TextStyle(
    fontSize: 16,
    height: 21 / 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.4,
  );

  static const TextStyle calloutEmphasizedItalic = TextStyle(
    fontSize: 16,
    height: 21 / 16,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.4,
  );

  static const TextStyle subheadlineRegular = TextStyle(
    fontSize: 15,
    height: 20 / 15,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.4,
  );

  static const TextStyle subheadlineEmphasized = TextStyle(
    fontSize: 15,
    height: 20 / 15,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  );

  static const TextStyle subheadlineItalic = TextStyle(
    fontSize: 15,
    height: 20 / 15,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.4,
  );

  static const TextStyle subheadlineEmphasizedItalic = TextStyle(
    fontSize: 15,
    height: 20 / 15,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.4,
  );

  static const TextStyle footnoteRegular = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.4,
  );

  static const TextStyle footnoteEmphasized = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  );

  static const TextStyle footnoteItalic = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.4,
  );

  static const TextStyle footnoteEmphasizedItalic = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.4,
  );

  static const TextStyle caption1Regular = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.4,
  );

  static const TextStyle caption1Emphasized = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.4,
  );

  static const TextStyle caption1Italic = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.4,
  );

  static const TextStyle caption1EmphasizedItalic = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.4,
  );

  static const TextStyle caption2Regular = TextStyle(
    fontSize: 11,
    height: 13 / 11,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.4,
  );

  static const TextStyle caption2Emphasized = TextStyle(
    fontSize: 11,
    height: 13 / 11,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.4,
  );

  static const TextStyle caption2Italic = TextStyle(
    fontSize: 11,
    height: 13 / 11,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.4,
  );

  static const TextStyle caption2EmphasizedItalic = TextStyle(
    fontSize: 11,
    height: 13 / 11,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    letterSpacing: -0.4,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData.light().copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppExtension.light().colors.background,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    extensions: <ThemeExtension<dynamic>>[AppExtension.light()],
  );

  static ThemeData get dark => ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppExtension.dark().colors.background,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    extensions: <ThemeExtension<dynamic>>[AppExtension.dark()],
  );
}