part of 'time_picker.dart';

class TekSingleTimePickerWidget extends StatefulWidget {
  const TekSingleTimePickerWidget({
    super.key,
    this.title,
    this.titleSize,
    this.titleWeight,
    this.titleColor,
    this.presetTitle,
    this.presetTitleSize,
    this.presetTitleWeight,
    this.presetTitleColor,
    this.textDone,
    this.initialTime,
    this.onPickTime,
    this.mainSize,
    this.mainWeight,
    this.mainColor,
    this.presets = const [],
    this.presetSize,
    this.presetWeight,
    this.presetColor,
    this.onTimeChanged,
  });

  final String? title;
  final double? titleSize;
  final FontWeight? titleWeight;
  final Color? titleColor;
  final String? presetTitle;
  final double? presetTitleSize;
  final FontWeight? presetTitleWeight;
  final Color? presetTitleColor;
  final String? textDone;
  final TimeOfDay? initialTime;
  final Future Function(TimeOfDay)? onPickTime;
  final double? mainSize;
  final FontWeight? mainWeight;
  final Color? mainColor;
  final List<TimeOfDay> presets;
  final double? presetSize;
  final FontWeight? presetWeight;
  final Color? presetColor;
  final Function(TimeOfDay)? onTimeChanged;

  @override
  State<TekSingleTimePickerWidget> createState() => _TekSingleTimePickerWidgetState();
}

class _TekSingleTimePickerWidgetState extends State<TekSingleTimePickerWidget> {
  @override
  void initState() {
    super.initState();
    _hourScrollController = FixedExtentScrollController();
    _minuteScrollController = FixedExtentScrollController();
    _timeOfDay = widget.initialTime ?? TimeOfDay.now();

    // jump to initial time
    WidgetsBinding.instance.addPostFrameCallback((_) => _handeChangeByPreset(_timeOfDay));
  }

  @override
  void dispose() {
    _hourScrollController.dispose();
    _minuteScrollController.dispose();
    super.dispose();
  }

  late final FixedExtentScrollController _hourScrollController;
  late final FixedExtentScrollController _minuteScrollController;

  late TimeOfDay _timeOfDay;
  bool _buttonLoading = false;
  bool _enableHourListenerScroll = true;
  bool _enableMinuteListenerScroll = true;

  void _setTimeOfDay(TimeOfDay timeOfDay, {bool onlyUpdate = false}) {
    if (_timeOfDay == timeOfDay) return;
    if (onlyUpdate) {
      _timeOfDay = timeOfDay;
    } else {
      setState(() => _timeOfDay = timeOfDay);
    }
    widget.onTimeChanged?.call(timeOfDay);
  }

  void _setButtonLoading(bool loading) => setState(() => _buttonLoading = loading);

  void _handleChangeByScrollController({
    int? valueHour,
    int? valueMinute,
  }) =>
      _setTimeOfDay(
        TimeOfDay(
          hour: valueHour ?? _timeOfDay.hour,
          minute: valueMinute ?? _timeOfDay.minute,
        ),
        onlyUpdate: (!_enableHourListenerScroll && valueHour != null) ||
            (!_enableMinuteListenerScroll && valueMinute != null),
      );

  void _handeChangeByPreset(
    TimeOfDay timeOfDay, {
    bool onlyJump = true,
  }) {
    if (onlyJump) {
      _hourScrollController.jumpToItem(timeOfDay.hour);
      _minuteScrollController.jumpToItem(timeOfDay.minute);
    } else {
      _enableHourListenerScroll = false;
      _hourScrollController
          .animateToItem(
        timeOfDay.hour,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .then(
        (_) {
          _enableHourListenerScroll = true;
          setState(() {});
        },
      );
      _enableMinuteListenerScroll = false;
      _minuteScrollController
          .animateToItem(
        timeOfDay.minute,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .then(
        (_) {
          _enableMinuteListenerScroll = true;
          setState(() {});
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(TekSpacings().mainSpacing),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
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
                      onHourChanged: (index) => _handleChangeByScrollController(valueHour: index),
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
                  ],
                ),
              ),
            ],
          ),
          if (widget.presets.isNotEmpty) ...[
            TekTypography(
              text: widget.presetTitle ?? 'Presets:',
              fontWeight: widget.presetTitleWeight,
              fontSize: widget.presetTitleSize,
              color: widget.presetTitleColor,
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
                      _handeChangeByPreset(item, onlyJump: false);
                    },
                    child: TekCard(
                      padding: EdgeInsets.symmetric(
                        horizontal: TekSpacings().mainSpacing,
                        vertical: TekSpacings().p8,
                      ),
                      border: Border.all(
                        color: _timeOfDay == item ? TekColors().primary : TekColors().greyOpacity04,
                        width: 1,
                      ),
                      child: TekTypography(
                        text: widget.presets[index].format(context),
                        type: TekTypographyType.titleMedium,
                        fontWeight: widget.presetWeight,
                        fontSize: widget.presetSize,
                        color:
                            widget.presetColor ?? (_timeOfDay == item ? TekColors().primary : null),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          if (widget.onPickTime != null) ...[
            TekVSpace.mainSpace,
            TekButton(
              text: widget.textDone ?? 'Done',
              width: double.infinity,
              fontWeight: FontWeight.w600,
              type: TekButtonType.primary,
              loading: _buttonLoading,
              onPressed: () {
                try {
                  _setButtonLoading(true);
                  widget.onPickTime?.call(_timeOfDay).then(
                    (_) {
                      _setButtonLoading(false);
                      context.popNavigator();
                    },
                  );
                } catch (e) {
                  TekLogger.errorLog("TekSingleTimePickerWidget $e");
                  _setButtonLoading(false);
                }
              },
            ),
            TekVSpace(context.viewPadding.bottom),
          ]
        ],
      ),
    );
  }
}
