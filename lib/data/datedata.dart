import 'package:intl/intl.dart';

final month = DateFormat("M").format(DateTime.now());
final day = DateFormat("d").format(DateTime.now());
final weekday = DateFormat("EEEE", "ko").format(DateTime.now());

final today = "$month월 $day일 $weekday";