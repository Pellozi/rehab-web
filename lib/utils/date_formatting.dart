import 'package:date_format/date_format.dart' as df;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart';

String dateAsString(DateTime dateTime) {
  return df.formatDate(dateTime.toLocal(), [df.dd, '/', df.mm, '/', df.yyyy]);
}

String dateAsStringYearShort(DateTime dateTime) {
  return df.formatDate(dateTime.toLocal(), [df.dd, '/', df.mm, '/', df.yy]);
}

String dateAsStringShort(DateTime dateTime) {
  return df.formatDate(dateTime.toLocal(), [
    df.dd,
    '/',
    df.mm,
  ]);
}

String dateAsDayMonthStringShort(DateTime dateTime) {
  var formatter = new DateFormat("dd' 'MMM'", ('pt_BR'));
  return capitalizeFirstLetter(formatter.format(dateTime));
}

String timeSimplified(DateTime timeOfDay) {
  return "${timeOfDay.minute.toString().padLeft(2, '0')}m${timeOfDay.second.toString().padLeft(2, '0')}s";
}

String dateAsDaYOfWeekShort(DateTime dateTime) {
  var formatter = new DateFormat("EEE'", ('pt_BR'));
  return capitalizeFirstLetter(formatter.format(dateTime));
}

String dateAsDaYOfWeekLong(DateTime dateTime) {
  var formatter = new DateFormat("EEEE'", ('pt_BR'));
  return capitalizeFirstLetter(formatter.format(dateTime));
}

String dateAsMonthYearStringShort(DateTime dateTime) {
  return df.formatDate(dateTime.toLocal(), [
    df.mm,
    '/',
    df.yyyy,
  ]);
}

String dateAsMonthStringShort(DateTime dateTime) {
  var formatter = new DateFormat("MMM'", ('pt_BR'));
  return capitalizeFirstLetter(formatter.format(dateTime));
}

String dateAsStringExtended(DateTime dateTime) {
  var formatter = new DateFormat("EEEE',' d 'de' MMM yyyy", ('pt_BR'));
  return capitalizeFirstLetter(formatter.format(dateTime));
}

int dateAsYearShort(DateTime dateTime) {
  return int.tryParse(df.formatDate(dateTime.toLocal(), [
    df.yy,
  ]));
}

int dateAsDayShort(DateTime dateTime) {
  return int.tryParse(df.formatDate(dateTime.toLocal(), [
    df.dd,
  ]));
}

String dateAsStringLongMonth(DateTime dateTime) {
  var formatter = new DateFormat("dd 'de' MMMM, yyyy", ('pt_BR'));
  return formatter.format(dateTime);
}

String dateAsLongMonthYear(DateTime dateTime) {
  var formatter = new DateFormat("MMMM yyyy", ('pt_BR'));
  return capitalizeFirstLetter(formatter.format(dateTime));
}

String dateAsShortMonth(DateTime dateTime) {
  var formatter = new DateFormat("MMM", ('pt_BR'));
  return capitalizeFirstLetter(formatter.format(dateTime));
}

String dateTimeAsStringShortMonth(DateTime dateTime) {
  var formatter = new DateFormat("dd MMM yyyy '-' HH:mm", ('pt_BR'));
  return formatter.format(dateTime);
}

String dateTimeAsStringNumeric(DateTime dateTime) {
  var formatter = new DateFormat("dd/MM/yyyy '-' HH:mm", ('pt_BR'));
  return formatter.format(dateTime);
}

String dateAsDBFormat(DateTime dateTime) {
  var formatter = new DateFormat("yyyy-MM-dd", ('pt_BR'));
  return formatter.format(dateTime);
}

String shortTimeAsString(DateTime dateTime) {
  return df.formatDate(dateTime.toLocal(), [
    df.HH,
    ':',
    df.nn,
  ]);
}

String shortTimeExtendedAsString(DateTime dateTime) {
  return df.formatDate(dateTime.toLocal(), [df.HH, ':', df.nn, ':', df.ss]);
}

String shortTimeMinSecAsString(DateTime dateTime) {
  return df.formatDate(dateTime.toLocal(), [
    df.nn,
    ':',
    df.ss,
  ]);
}

DateTime dateTimeWithoutTime(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

String timeToMinuteSecond(DateTime dateTime) {
  return df.formatDate(dateTime.toLocal(), [
    df.nn,
    ':',
    df.ss,
  ]);
}

String shortTimeWithSecAsString(DateTime dateTime) {
  return df.formatDate(dateTime.toLocal(), [df.HH, ':', df.nn, ':', df.ss]);
}

String timeStartTimeEndString(TimeOfDay timeOfDayInit, TimeOfDay timeOfDayEnd) {
  return "${timeOfDayInit.hour.toString().padLeft(2, '0')}:${timeOfDayInit.minute.toString().padLeft(2, '0')} - " +
      "${timeOfDayEnd.hour.toString().padLeft(2, '0')}:${timeOfDayEnd.minute.toString().padLeft(2, '0')}";
}

String timeAsString(TimeOfDay timeOfDay) {
  return "${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}";
}

TimeOfDay timeOfDayFromMinutes(int minutes) {
  return TimeOfDay(hour: (minutes / 60).floor(), minute: (minutes % 60).floor());
}

TimeOfDay timeOfDayFromString(String time) {
  return TimeOfDay(hour: int.parse(time.split(":")[0]), minute: int.parse(time.split(":")[1]));
}

bool isTimeOfDayBefore(TimeOfDay a, TimeOfDay b) {
  return timeOfDayInMinutes(a) <= timeOfDayInMinutes(b);
}

bool isTimeOfDayBetween(TimeOfDay timeOfDay, TimeOfDay a, TimeOfDay b) {
  return isTimeOfDayBefore(timeOfDay, b) && isTimeOfDayBefore(a, timeOfDay);
}

int timeOfDayInMinutes(TimeOfDay timeOfDay) {
  return timeOfDay.hour * 60 + timeOfDay.minute;
}

String durationToStringLong(Duration duration) {
  var s = duration.inSeconds % 60;
  var m = duration.inMinutes % 60;
  var h = duration.inHours;

  if (h == 0) {
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  return "$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
}

Duration durationFromString(String s) {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  List<String> parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  if (parts.length > 0) {
    seconds = int.parse(parts[parts.length - 1]);
  }
  return Duration(hours: hours, minutes: minutes, seconds: seconds);
}

DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday));
}

String capitalizeFirstLetter(String input) {
  return (input.length > 0) ? "${input[0].toUpperCase()}${input.substring(1).toLowerCase()}" : "";
}

String capitalizeFirstLetterAllWords(String str) {
  var splitStr = str.toLowerCase().split(' ');
  for (var i = 0; i < splitStr.length; i++) {
    if (splitStr[i] == '') continue;
    splitStr[i] = splitStr[i][0].toUpperCase() + splitStr[i].substring(1);
  }
  return splitStr.join(' ');
}

String getFirstName(String name) {
  return name.split(' ')[0];
}

class PtBrShortMessagesModified implements LookupMessages {
  String prefixAgo() => '';
  String prefixFromNow() => '';
  String suffixAgo() => '';
  String suffixFromNow() => '';
  String lessThanOneMinute(int seconds) => 'agora';
  String aboutAMinute(int minutes) => 'Há 1 min';
  String minutes(int minutes) => '${minutes} min';
  String aboutAnHour(int minutes) => 'Há 1h';
  String hours(int hours) => 'Há ${hours} h';
  String aDay(int hours) => 'Há 1 dia';
  String days(int days) => 'Há ${days} dias';
  String aboutAMonth(int days) => 'Há 1 mês';
  String months(int months) => 'Há ${months} meses';
  String aboutAYear(int year) => 'Há 1 ano';
  String years(int years) => 'Há ${years} anos';
  String wordSeparator() => ' ';
}
