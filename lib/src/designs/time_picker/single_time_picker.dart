part of 'time_picker.dart';

class TekSingleTimePickerWidget extends StatefulWidget {
  const TekSingleTimePickerWidget({
    super.key,
    this.title,
    this.presetTitle,
    this.initialTime,
    this.textDone,
    this.textAM,
    this.textPM,
    this.presets = const [],
    this.onPickTime,
    this.mainSize,
    this.mainWeight,
    this.mainColor,
    this.presetSize,
    this.presetWeight,
    this.presetColor,
    this.titleSize,
    this.titleWeight,
    this.titleColor,
  });

  final String? title;
  final double? titleSize;
  final FontWeight? titleWeight;
  final Color? titleColor;
  final String? presetTitle;
  final String? textDone;
  final String? textAM;
  final String? textPM;
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay>? onPickTime;
  final double? mainSize;
  final FontWeight? mainWeight;
  final Color? mainColor;
  final List<TimeOfDay> presets;
  final double? presetSize;
  final FontWeight? presetWeight;
  final Color? presetColor;

  @override
  State<TekSingleTimePickerWidget> createState() => _TekSingleTimePickerWidgetState();
}

class _TekSingleTimePickerWidgetState extends State<TekSingleTimePickerWidget> {
  @override
  void initState() {
    super.initState();
    _hourScrollController = FixedExtentScrollController();
    _minuteScrollController = FixedExtentScrollController();
    _amPmScrollController = FixedExtentScrollController();
    _timeOfDay = widget.initialTime ?? TimeOfDay.now();
    _isAM = _timeOfDay.period == DayPeriod.am;

    // jump to initial time
    WidgetsBinding.instance.addPostFrameCallback((_) => _handeChangeByPreset(_timeOfDay));
  }

  @override
  void dispose() {
    _hourScrollController.dispose();
    _minuteScrollController.dispose();
    _amPmScrollController.dispose();
    super.dispose();
  }

  late final FixedExtentScrollController _hourScrollController;
  late final FixedExtentScrollController _minuteScrollController;
  late final FixedExtentScrollController _amPmScrollController;

  late TimeOfDay _timeOfDay;
  late bool _isAM;

  void _setTimeOfDay(TimeOfDay timeOfDay) {
    if (_timeOfDay == timeOfDay) return;
    if (timeOfDay.period == DayPeriod.am) {
      _isAM = true;
      _timeOfDay = timeOfDay;
    } else {
      _isAM = false;
      _timeOfDay = TimeOfDay(
        hour: timeOfDay.hour - 12,
        minute: timeOfDay.minute,
      );
    }
    setState(() {});
  }

  void _setIsAM(bool isAM) => setState(() => _isAM = isAM);

  void _handleChangeByScrollController({
    int? valueHour,
    int? valueMinute,
  }) {
    final hour = valueHour ?? _timeOfDay.hour;
    final minute = valueMinute ?? _timeOfDay.minute;
    final timeOfDay = TimeOfDay(
      hour: hour,
      minute: minute,
    );
    _setTimeOfDay(timeOfDay);
  }

  void _handeChangeByPreset(TimeOfDay timeOfDay) {
    _hourScrollController.jumpToItem(
      timeOfDay.hourOfPeriod - 1,
    );
    _minuteScrollController.jumpToItem(
      timeOfDay.minute,
    );
    _amPmScrollController.jumpToItem(
      _isAM ? 0 : 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(TekSpacings().mainSpacing),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TekTypography(
                text: widget.title ?? 'Time',
                fontWeight: widget.titleWeight ?? FontWeight.w700,
                fontSize: widget.titleSize ?? TekFontSizes().s18,
                color: widget.titleColor,
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 210,
                  decoration: BoxDecoration(
                    color: TekColors().grey.withOpacity(0.1),
                    borderRadius: TekCorners().mainCornerBorder,
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TimePickerHourWidget(
                      hourScrollController: _hourScrollController,
                      onHourChanged: (index) =>
                          _handleChangeByScrollController(valueHour: index + 1),
                      fontSize: widget.mainSize,
                      fontWeight: widget.mainWeight,
                      color: widget.mainColor,
                    ),
                    TekHSpace.p4,
                    const TekTypography(
                      text: ":",
                      type: TekTypographyType.headlineBold,
                    ),
                    TekHSpace.p4,
                    TimePickerMinuteWidget(
                      minuteScrollController: _minuteScrollController,
                      onMinuteChanged: (index) =>
                          _handleChangeByScrollController(valueMinute: index),
                      fontSize: widget.mainSize,
                      fontWeight: widget.mainWeight,
                      color: widget.mainColor,
                    ),
                    TekHSpace.p4,
                    const TekTypography(
                      text: " ",
                      type: TekTypographyType.headlineBold,
                    ),
                    TekHSpace.p4,
                    TimePickerAMPMWidget(
                      amPmScrollController: _amPmScrollController,
                      onAMPMChanged: _setIsAM,
                      textAM: widget.textAM,
                      textPM: widget.textPM,
                      fontSize: widget.mainSize,
                      fontWeight: widget.mainWeight,
                      color: widget.mainColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (widget.presets.isNotEmpty) ...[
            TekTypography(
              text: widget.presetTitle ?? 'Presets',
            ),
            TekVSpace.p8,
            SizedBox(
              height: 41,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.presets.length,
                separatorBuilder: (_, __) => TekHSpace.mainSpace,
                itemBuilder: (_, index) {
                  final item = widget.presets[index];
                  return TekButtonInkwell(
                    onPressed: () {
                      _setTimeOfDay(item);
                      _handeChangeByPreset(item);
                    },
                    child: TekCard(
                      padding: EdgeInsets.symmetric(
                        horizontal: TekSpacings().mainSpacing,
                        vertical: TekSpacings().p8,
                      ),
                      border: Border.all(
                        color: TimeOfDay(
                                  hour: _isAM ? _timeOfDay.hour : _timeOfDay.hour + 12,
                                  minute: _timeOfDay.minute,
                                ) ==
                                item
                            ? TekColors().primary
                            : TekColors().greyOpacity04,
                        width: 1,
                      ),
                      child: TekTypography(
                        text: widget.presets[index].format(context),
                        type: TekTypographyType.titleMedium,
                        fontWeight: widget.presetWeight,
                        fontSize: widget.presetSize,
                        color: widget.presetColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          TekVSpace.mainSpace,
          TekButton(
            text: widget.textDone ?? 'Done',
            width: double.infinity,
            fontWeight: FontWeight.w600,
            type: TekButtonType.primary,
            onPressed: () {
              widget.onPickTime?.call(
                TimeOfDay(
                  hour: _isAM ? _timeOfDay.hour : _timeOfDay.hour + 12,
                  minute: _timeOfDay.minute,
                ),
              );
              context.popNavigator();
            },
          ),
        ],
      ),
    );
  }
}
