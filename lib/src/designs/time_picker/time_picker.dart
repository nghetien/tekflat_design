library time_picker;

import 'package:flutter/material.dart';
import 'package:tekflat_design/src/src.dart';

part 'am_pm.dart';

part 'arrange_time_picker.dart';

part 'hour.dart';

part 'minute.dart';

part 'single_time_picker.dart';

class TekTimePicker {
  const TekTimePicker._();

  static Future<T?> singleTimePicker<T>(
    BuildContext context, {
    String? title,
    String? presetTitle,
    String? textDone,
    TimeOfDay? initialTime,
    String? textAM,
    String? textPM,
    List<TimeOfDay> presets = const [],
    required ValueChanged<TimeOfDay> onPickTime,
    double? mainSize,
    FontWeight? mainWeight,
    Color? mainColor,
    double? presetSize,
    FontWeight? presetWeight,
    Color? presetColor,
    double? titleSize,
    FontWeight? titleWeight,
    Color? titleColor,
  }) async {
    return TekBottomSheet.customizeBottomSheet(
      context,
      builder: (context) {
        return TekSingleTimePickerWidget(
          title: title,
          presetTitle: presetTitle,
          textDone: textDone,
          initialTime: initialTime,
          textAM: textAM,
          textPM: textPM,
          presets: presets,
          onPickTime: onPickTime,
          mainSize: mainSize,
          mainWeight: mainWeight,
          mainColor: mainColor,
          presetSize: presetSize,
          presetWeight: presetWeight,
          presetColor: presetColor,
          titleSize: titleSize,
          titleWeight: titleWeight,
          titleColor: titleColor,
        );
      },
      isCustomize: true,
      useRootNavigator: true,
      isScrollControlled: true,
    );
  }

  static Future<T?> arrangeTimePicker<T>(
    BuildContext context, {
    String? fromText,
    String? toText,
    String? presetTitle,
    String? textDone,
    String? textAM,
    String? textPM,
    TimeOfDay? initStartTime,
    TimeOfDay? initEndTime,
    List<TimeOfDay> startPresets = const [],
    List<TimeOfDay> endPresets = const [],
    required Function(TimeOfDay, TimeOfDay) onPickTimes,
    double? mainSize,
    FontWeight? mainWeight,
    Color? mainColor,
    double? presetSize,
    FontWeight? presetWeight,
    Color? presetColor,
    double? titleSize,
    FontWeight? titleWeight,
    Color? titleColor,
  }) async {
    return TekBottomSheet.customizeBottomSheet(
      context,
      builder: (context) {
        return TekArrangeTimePickerWidget(
          fromText: fromText,
          toText: toText,
          presetTitle: presetTitle,
          textDone: textDone,
          textAM: textAM,
          textPM: textPM,
          initStartTime: initStartTime,
          initEndTime: initEndTime,
          startPresets: startPresets,
          endPresets: endPresets,
          onPickTimes: onPickTimes,
          mainSize: mainSize,
          mainWeight: mainWeight,
          mainColor: mainColor,
          presetSize: presetSize,
          presetWeight: presetWeight,
          presetColor: presetColor,
          titleSize: titleSize,
          titleWeight: titleWeight,
          titleColor: titleColor,
        );
      },
      isCustomize: true,
      useRootNavigator: true,
      isScrollControlled: true,
    );
  }
}
