part of 'time_picker.dart';

class TekArrangeTimePickerWidget extends StatefulWidget {
  const TekArrangeTimePickerWidget({
    super.key,
    this.fromText,
    this.toText,
    this.presetTitle,
    this.textDone,
    this.textAM,
    this.textPM,
    this.initStartTime,
    this.initEndTime,
    this.startPresets = const [],
    this.endPresets = const [],
    required this.onPickTimes,
    this.mainSize,
    this.mainWeight,
    this.mainColor,
    this.presetSize,
    this.presetWeight,
    this.presetColor,
    this.titleSize,
    this.titleWeight,
    this.titleColor,
    this.errorText,
  });

  final String? fromText;
  final String? toText;
  final String? presetTitle;
  final String? textDone;
  final String? textAM;
  final String? textPM;
  final TimeOfDay? initStartTime;
  final TimeOfDay? initEndTime;
  final List<TimeOfDay> startPresets;
  final List<TimeOfDay> endPresets;
  final Future Function(TimeOfDay, TimeOfDay)? onPickTimes;
  final double? presetSize;
  final FontWeight? presetWeight;
  final Color? presetColor;
  final double? mainSize;
  final FontWeight? mainWeight;
  final Color? mainColor;
  final double? titleSize;
  final FontWeight? titleWeight;
  final Color? titleColor;
  final String? errorText;

  @override
  State<TekArrangeTimePickerWidget> createState() => _TekArrangeTimePickerWidgetState();
}

class _TekArrangeTimePickerWidgetState extends State<TekArrangeTimePickerWidget> {
  @override
  void initState() {
    super.initState();
    _hourScrollFromController = FixedExtentScrollController();
    _minuteScrollFromController = FixedExtentScrollController();
    _amPmScrollFromController = FixedExtentScrollController();
    _timeOfDayFrom = widget.initStartTime ?? TimeOfDay.now();
    _isAMFrom = _timeOfDayFrom.period == DayPeriod.am;

    _hourScrollToController = FixedExtentScrollController();
    _minuteScrollToController = FixedExtentScrollController();
    _amPmScrollToController = FixedExtentScrollController();
    _timeOfDayTo = widget.initEndTime ?? TimeOfDay.now();
    _isAMTo = _timeOfDayTo.period == DayPeriod.am;

    // set State in initState
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _handeTimeFromChangeByPreset(_timeOfDayFrom);
        _handeTimeToChangeByPreset(_timeOfDayTo);
      },
    );
  }

  @override
  void dispose() {
    _hourScrollFromController.dispose();
    _minuteScrollFromController.dispose();
    _amPmScrollFromController.dispose();
    _hourScrollToController.dispose();
    _minuteScrollToController.dispose();
    _amPmScrollToController.dispose();
    super.dispose();
  }

  bool _buttonLoading = false;

  void _setButtonLoading(bool loading) => setState(() => _buttonLoading = loading);

  late final FixedExtentScrollController _hourScrollFromController;
  late final FixedExtentScrollController _minuteScrollFromController;
  late final FixedExtentScrollController _amPmScrollFromController;

  late TimeOfDay _timeOfDayFrom;
  late bool _isAMFrom;

  void _setTimeOfDayFrom(TimeOfDay timeOfDay) {
    if (_timeOfDayFrom == timeOfDay) return;
    if (timeOfDay.period == DayPeriod.am) {
      _isAMFrom = true;
      _timeOfDayFrom = timeOfDay;
    } else {
      _isAMFrom = false;
      _timeOfDayFrom = TimeOfDay(
        hour: timeOfDay.hour - 12,
        minute: timeOfDay.minute,
      );
    }
    setState(() {});
  }

  void _setIsAMFrom(bool value) => setState(() => _isAMFrom = value);

  void _handleTimeFromChangeByScrollController({
    int? valueHour,
    int? valueMinute,
  }) {
    final hour = valueHour ?? _timeOfDayFrom.hour;
    final minute = valueMinute ?? _timeOfDayFrom.minute;
    final timeOfDay = TimeOfDay(
      hour: hour,
      minute: minute,
    );
    _setTimeOfDayFrom(timeOfDay);
  }

  void _handeTimeFromChangeByPreset(TimeOfDay timeOfDay) {
    _hourScrollFromController.jumpToItem(
      timeOfDay.hourOfPeriod - 1,
    );
    _minuteScrollFromController.jumpToItem(
      timeOfDay.minute,
    );
    _amPmScrollFromController.jumpToItem(
      _isAMFrom ? 0 : 1,
    );
  }

  late final FixedExtentScrollController _hourScrollToController;
  late final FixedExtentScrollController _minuteScrollToController;
  late final FixedExtentScrollController _amPmScrollToController;

  late TimeOfDay _timeOfDayTo;
  late bool _isAMTo;

  void _setTimeOfDayTo(TimeOfDay timeOfDay) {
    if (_timeOfDayTo == timeOfDay) return;
    if (timeOfDay.period == DayPeriod.am) {
      _isAMTo = true;
      _timeOfDayTo = timeOfDay;
    } else {
      _isAMTo = false;
      _timeOfDayTo = TimeOfDay(
        hour: timeOfDay.hour - 12,
        minute: timeOfDay.minute,
      );
    }
    setState(() {});
  }

  void _setIsAMTo(bool value) => setState(() => _isAMTo = value);

  void _handleTimeToChangeByScrollController({
    int? valueHour,
    int? valueMinute,
  }) {
    final hour = valueHour ?? _timeOfDayTo.hour;
    final minute = valueMinute ?? _timeOfDayTo.minute;
    final timeOfDay = TimeOfDay(
      hour: hour,
      minute: minute,
    );
    _setTimeOfDayTo(timeOfDay);
  }

  void _handeTimeToChangeByPreset(TimeOfDay timeOfDay) {
    _hourScrollToController.jumpToItem(
      timeOfDay.hourOfPeriod - 1,
    );
    _minuteScrollToController.jumpToItem(
      timeOfDay.minute,
    );
    _amPmScrollToController.jumpToItem(
      _isAMTo ? 0 : 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(TekSpacings().mainSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFromTabWidget(),
          TekVSpace.mainSpace,
          _buildToTabWidget(),
          TekVSpace.mainSpace,
          TekButton(
            text: widget.textDone ?? 'Done',
            width: double.infinity,
            fontWeight: FontWeight.w600,
            type: TekButtonType.primary,
            loading: _buttonLoading,
            onPressed: () {
              try {
                final startTime = TimeOfDay(
                  hour: _isAMFrom ? _timeOfDayFrom.hour : _timeOfDayFrom.hour + 12,
                  minute: _timeOfDayFrom.minute,
                );
                final endTime = TimeOfDay(
                  hour: _isAMTo ? _timeOfDayTo.hour : _timeOfDayTo.hour + 12,
                  minute: _timeOfDayTo.minute,
                );
                if (startTime.hour > endTime.hour) {
                  TekToast.error(msg: widget.errorText ?? 'Start time must be before end time');
                  return;
                }
                _setButtonLoading(true);
                widget.onPickTimes
                    ?.call(
                  startTime,
                  endTime,
                )
                    .then(
                  (_) {
                    _setButtonLoading(false);
                    context.popNavigator();
                  },
                );
              } catch (e) {
                TekLogger.errorLog("TekArangeTimePickerWidget $e");
                _setButtonLoading(false);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFromTabWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TekTypography(
          text: widget.fromText ?? 'From',
          fontWeight: widget.titleWeight ?? FontWeight.w700,
          fontSize: widget.titleSize ?? TekFontSizes().s18,
          color: widget.titleColor,
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
                    hourScrollController: _hourScrollFromController,
                    onHourChanged: (index) => _handleTimeFromChangeByScrollController(
                      valueHour: index + 1,
                    ),
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
                    minuteScrollController: _minuteScrollFromController,
                    onMinuteChanged: (index) => _handleTimeFromChangeByScrollController(
                      valueMinute: index,
                    ),
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
                    amPmScrollController: _amPmScrollFromController,
                    onAMPMChanged: _setIsAMFrom,
                    fontSize: widget.mainSize,
                    fontWeight: widget.mainWeight,
                    color: widget.mainColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (widget.startPresets.isNotEmpty) ...[
          TekTypography(
            text: widget.presetTitle ?? 'Presets',
          ),
          TekVSpace.p8,
          SizedBox(
            height: 41,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.startPresets.length,
              separatorBuilder: (_, __) => TekHSpace.mainSpace,
              itemBuilder: (_, index) {
                final item = widget.startPresets[index];
                return TekButtonInkwell(
                  onPressed: () {
                    _setTimeOfDayFrom(item);
                    _handeTimeFromChangeByPreset(item);
                  },
                  child: TekCard(
                    padding: EdgeInsets.symmetric(
                      horizontal: TekSpacings().mainSpacing,
                      vertical: TekSpacings().p8,
                    ),
                    border: Border.all(
                      color: TimeOfDay(
                                hour: _isAMFrom ? _timeOfDayFrom.hour : _timeOfDayFrom.hour + 12,
                                minute: _timeOfDayFrom.minute,
                              ) ==
                              item
                          ? TekColors().primary
                          : TekColors().greyOpacity04,
                      width: 1,
                    ),
                    child: TekTypography(
                      text: widget.startPresets[index].format(context),
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
      ],
    );
  }

  Widget _buildToTabWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TekTypography(
          text: widget.toText ?? 'To',
          fontWeight: widget.titleWeight ?? FontWeight.w700,
          fontSize: widget.titleSize ?? TekFontSizes().s18,
          color: widget.titleColor,
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
                    hourScrollController: _hourScrollToController,
                    onHourChanged: (index) => _handleTimeToChangeByScrollController(
                      valueHour: index + 1,
                    ),
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
                    minuteScrollController: _minuteScrollToController,
                    onMinuteChanged: (index) => _handleTimeToChangeByScrollController(
                      valueMinute: index,
                    ),
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
                    amPmScrollController: _amPmScrollToController,
                    onAMPMChanged: _setIsAMTo,
                    fontSize: widget.mainSize,
                    fontWeight: widget.mainWeight,
                    color: widget.mainColor,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (widget.endPresets.isNotEmpty) ...[
          TekTypography(
            text: widget.presetTitle ?? 'Presets',
          ),
          TekVSpace.p8,
          SizedBox(
            height: 41,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.endPresets.length,
              separatorBuilder: (_, __) => TekHSpace.mainSpace,
              itemBuilder: (_, index) {
                final item = widget.endPresets[index];
                return TekButtonInkwell(
                  onPressed: () {
                    _setTimeOfDayTo(item);
                    _handeTimeToChangeByPreset(item);
                  },
                  child: TekCard(
                    padding: EdgeInsets.symmetric(
                      horizontal: TekSpacings().mainSpacing,
                      vertical: TekSpacings().p8,
                    ),
                    border: Border.all(
                      color: TimeOfDay(
                                hour: _isAMTo ? _timeOfDayTo.hour : _timeOfDayTo.hour + 12,
                                minute: _timeOfDayTo.minute,
                              ) ==
                              item
                          ? TekColors().primary
                          : TekColors().greyOpacity04,
                      width: 1,
                    ),
                    child: TekTypography(
                      text: widget.endPresets[index].format(context),
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
      ],
    );
  }
}
