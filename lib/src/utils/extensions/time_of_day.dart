import 'package:flutter/material.dart';

extension TekTimeOfDayEx on TimeOfDay? {
  String get convertToString => this == null
      ? ""
      : "${this!.hour.toString().padLeft(2, '0')}:${this!.minute.toString().padLeft(2, '0')}";

  TimeOfDay? add(Duration duration) {
    if (this == null) return null;
    int newMinutes = this!.minute + duration.inMinutes % 60;
    int newHours = this!.hour + duration.inMinutes ~/ 60;
    return TimeOfDay(hour: newHours % 24, minute: newMinutes % 60);
  }

  TimeOfDay? subtract(Duration duration) {
    if (this == null) return null;
    int newMinutes = this!.minute - duration.inMinutes % 60;
    int newHours = this!.hour - duration.inMinutes ~/ 60;
    newMinutes = newMinutes < 0 ? 60 + newMinutes : newMinutes;
    newHours = newHours < 0 ? 24 + newHours : newHours;
    return TimeOfDay(hour: newHours % 24, minute: newMinutes % 60);
  }
}
