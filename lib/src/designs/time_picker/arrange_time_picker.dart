part of 'time_picker.dart';

class TekArrangeTimePickerWidget extends StatefulWidget {
  const TekArrangeTimePickerWidget({
    super.key,
    this.titleStart,
    this.titleEnd,
    this.presetTitle,
    this.presetTitleSize,
    this.presetTitleWeight,
    this.presetTitleColor,
    this.textDone,
    this.initialStartTime,
    this.initialEndTime,
    this.onPickTime,
    this.mainSize,
    this.mainWeight,
    this.mainColor,
    this.presetsStart = const [],
    this.presetsEnd = const [],
    this.presetSize,
    this.presetWeight,
    this.presetColor,
    this.onStartTimeChanged,
    this.onEndTimeChanged,
  });

  final String? titleStart;
  final String? titleEnd;
  final String? presetTitle;
  final double? presetTitleSize;
  final FontWeight? presetTitleWeight;
  final Color? presetTitleColor;
  final String? textDone;
  final TimeOfDay? initialStartTime;
  final TimeOfDay? initialEndTime;
  final Future Function(TimeOfDay, TimeOfDay)? onPickTime;
  final double? mainSize;
  final FontWeight? mainWeight;
  final Color? mainColor;
  final List<TimeOfDay> presetsStart;
  final List<TimeOfDay> presetsEnd;
  final double? presetSize;
  final FontWeight? presetWeight;
  final Color? presetColor;
  final Function(TimeOfDay)? onStartTimeChanged;
  final Function(TimeOfDay)? onEndTimeChanged;

  @override
  State<TekArrangeTimePickerWidget> createState() => _TekArrangeTimePickerWidgetState();
}

class _TekArrangeTimePickerWidgetState extends State<TekArrangeTimePickerWidget> {
  @override
  void initState() {
    super.initState();
    _startTime = widget.initialStartTime ?? TimeOfDay.now();
    _endTime =
        widget.initialEndTime ?? TimeOfDay.now().add(const Duration(hours: 1)) ?? TimeOfDay.now();
  }

  @override
  void dispose() {
    super.dispose();
  }

  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  bool _buttonLoading = false;

  void _setButtonLoading(bool value) {
    setState(() {
      _buttonLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ablePreset = widget.presetsStart.isNotEmpty || widget.presetsEnd.isNotEmpty;
    return SizedBox(
      height: 420 - (ablePreset ? 0 : 70) - (widget.onPickTime != null ? 0 : 60),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: <Widget>[
                Tab(
                  text: "${widget.titleStart ?? "Start time"}: ${_startTime.format(context)}",
                ),
                Tab(
                  text: "${widget.titleEnd ?? "End time"}: ${_endTime.format(context)}",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  TekSingleTimePickerWidget(
                    key: const ValueKey("TekSingleTimePickerWidgetStart"),
                    presetTitle: widget.presetTitle,
                    presetTitleSize: widget.presetTitleSize,
                    presetTitleWeight: widget.presetTitleWeight,
                    presetTitleColor: widget.presetTitleColor,
                    initialTime: _startTime,
                    mainSize: widget.mainSize,
                    mainWeight: widget.mainWeight,
                    mainColor: widget.mainColor,
                    presets: widget.presetsStart,
                    presetSize: widget.presetSize,
                    presetWeight: widget.presetWeight,
                    presetColor: widget.presetColor,
                    onTimeChanged: (time) {
                      setState(() {
                        _startTime = time;
                      });
                      widget.onStartTimeChanged?.call(time);
                    },
                  ),
                  TekSingleTimePickerWidget(
                    key: const ValueKey("TekSingleTimePickerWidgetEnd"),
                    presetTitle: widget.presetTitle,
                    presetTitleSize: widget.presetTitleSize,
                    presetTitleWeight: widget.presetTitleWeight,
                    presetTitleColor: widget.presetTitleColor,
                    initialTime: _endTime,
                    mainSize: widget.mainSize,
                    mainWeight: widget.mainWeight,
                    mainColor: widget.mainColor,
                    presets: widget.presetsEnd,
                    presetSize: widget.presetSize,
                    presetWeight: widget.presetWeight,
                    presetColor: widget.presetColor,
                    onTimeChanged: (time) {
                      setState(() {
                        _endTime = time;
                      });
                      widget.onEndTimeChanged?.call(time);
                    },
                  ),
                ],
              ),
            ),
            if (widget.onPickTime != null) Padding(
              padding: EdgeInsets.symmetric(
                horizontal: TekSpacings().mainSpacing,
              ).copyWith(
                bottom: context.viewPadding.bottom,
              ),
              child: TekButton(
                text: widget.textDone ?? 'Done',
                width: double.infinity,
                fontWeight: FontWeight.w600,
                type: TekButtonType.primary,
                loading: _buttonLoading,
                onPressed: () {
                  try {
                    _setButtonLoading(true);
                    widget.onPickTime?.call(_startTime, _endTime).then(
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
            ),
          ],
        ),
      ),
    );
  }
}
