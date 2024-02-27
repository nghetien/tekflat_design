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
    double? titleSize,
    FontWeight? titleWeight,
    Color? titleColor,
    String? presetTitle,
    double? presetTitleSize,
    FontWeight? presetTitleWeight,
    Color? presetTitleColor,
    String? textDone,
    TimeOfDay? initialTime,
    Future Function(TimeOfDay)? onPickTime,
    double? mainSize,
    FontWeight? mainWeight,
    Color? mainColor,
    List<TimeOfDay> presets = const [],
    double? presetSize,
    FontWeight? presetWeight,
    Color? presetColor,
    Function(TimeOfDay)? onTimeChanged,
  }) async {
    return TekBottomSheet.customizeBottomSheet(
      context,
      builder: (context) {
        return TekSingleTimePickerWidget(
          title: title,
          titleSize: titleSize,
          titleWeight: titleWeight,
          titleColor: titleColor,
          presetTitle: presetTitle,
          presetTitleSize: presetTitleSize,
          presetTitleWeight: presetTitleWeight,
          presetTitleColor: presetTitleColor,
          textDone: textDone,
          initialTime: initialTime,
          onPickTime: onPickTime,
          mainSize: mainSize,
          mainWeight: mainWeight,
          mainColor: mainColor,
          presets: presets,
          presetSize: presetSize,
          presetWeight: presetWeight,
          presetColor: presetColor,
          onTimeChanged: onTimeChanged,
        );
      },
      isCustomize: true,
      useRootNavigator: true,
      isScrollControlled: true,
    );
  }

  static Future<T?> arrangeTimePicker<T>(
    BuildContext context, {
    String? titleStart,
    String? titleEnd,
    String? presetTitle,
    double? presetTitleSize,
    FontWeight? presetTitleWeight,
    Color? presetTitleColor,
    String? textDone,
    TimeOfDay? initialTime,
    Future Function(TimeOfDay, TimeOfDay)? onPickTime,
    double? mainSize,
    FontWeight? mainWeight,
    Color? mainColor,
    List<TimeOfDay> presetsStart = const [],
    List<TimeOfDay> presetsEnd = const [],
    double? presetSize,
    FontWeight? presetWeight,
    Color? presetColor,
    Function(TimeOfDay)? onStartTimeChanged,
    Function(TimeOfDay)? onEndTimeChanged,
  }) async {
    return TekBottomSheet.customizeBottomSheet(
      context,
      builder: (context) {
        return TekArrangeTimePickerWidget(
          titleStart: titleStart,
          titleEnd: titleEnd,
          presetTitle: presetTitle,
          presetTitleSize: presetTitleSize,
          presetTitleWeight: presetTitleWeight,
          presetTitleColor: presetTitleColor,
          textDone: textDone,
          initialStartTime: initialTime,
          initialEndTime: initialTime,
          onPickTime: onPickTime,
          mainSize: mainSize,
          mainWeight: mainWeight,
          mainColor: mainColor,
          presetsStart: presetsStart,
          presetsEnd: presetsEnd,
          presetSize: presetSize,
          presetWeight: presetWeight,
          presetColor: presetColor,
          onStartTimeChanged: onStartTimeChanged,
          onEndTimeChanged: onEndTimeChanged,
        );
      },
      isCustomize: true,
      useRootNavigator: true,
      isScrollControlled: true,
    );
  }
}
