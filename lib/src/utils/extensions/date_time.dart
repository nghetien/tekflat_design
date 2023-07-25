import 'package:intl/intl.dart';

extension TekDateTimeEx on DateTime {
  String differenceFrom(DateTime from, {bool isCompact = true}) {
    var fromTime = from.subtract(const Duration(seconds: 2));
    var duration = difference(fromTime);
    final days = duration.inDays > 0 ? "${duration.inDays}d" : "";
    duration = duration - Duration(days: duration.inDays);
    final hours = duration.inHours > 0 ? "${duration.inHours}h" : "";
    duration = duration - Duration(hours: duration.inHours);
    final minutes =
        duration.inMinutes > 0 && !(days != "" && isCompact) ? "${duration.inMinutes}m" : "";
    duration = duration - Duration(minutes: duration.inMinutes);
    final seconds = duration.inSeconds > 0 && !((days != "" || hours != "") && isCompact)
        ? "${duration.inSeconds}s"
        : "";

    return "$days$hours$minutes$seconds";
  }

  String get dayOfWeek => DateFormat('EEEE').format(this);

  String get timeStr => DateFormat('HH:mm').format(this);

  String get dateStr => DateFormat('dd/MM/yyyy').format(this);

  String get dateTimeStr => DateFormat('dd/MM/yyyy HH:mm').format(this);

  String get dayOfMonthOfYear => DateFormat.yMMMEd().format(this);

  String customFormat(String format) => DateFormat(format).format(this);
}
