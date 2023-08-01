part of 'inputs.dart';

enum TekInputDateTimeType {
  date,
  time,
  dateTime,
}

class TekInputDateTime extends StatefulWidget {
  const TekInputDateTime({
    Key? key,
    this.name = '',
    this.initialValue,
    this.focusNodeForm,
    this.enabled = true,
    this.autoValidateMode,
    this.restorationId,
    this.validator,
    this.valueTransformer,
    this.onSaved,
    this.onDateTimeChanged,
    this.onReset,

    /// Text Field
    this.type = TekInputDateTimeType.date,
    this.size = TekInputSize.medium,
    this.width,
    this.controller,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textInputAction,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.obscureText = false,
    this.cursorColor,
    this.inputFormatters,
    this.onTap,
    this.onTapOutside,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.isDense,
    this.filled,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.fillColor,
    this.hoverColor,
    this.labelText,
    this.labelStyle,
    this.floatingLabelStyle,
    this.floatingLabelBehavior,
    this.hintText,
    this.hintStyle,
    this.errorText,
    this.errorMaxLines,
    this.errorStyle,
    this.readOnly = false,

    /// Date Time Picker
    this.autoOpenSelectDate = true,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.currentDatePicker,
    this.initialTime,
  }) : super(key: key);

  final String name;
  final DateTime? initialValue;
  final FocusNode? focusNodeForm;
  final bool enabled;
  final AutovalidateMode? autoValidateMode;
  final String? restorationId;
  final String? Function(DateTime?)? validator;
  final dynamic Function(DateTime?)? valueTransformer;
  final Function(DateTime?)? onSaved;
  final Function(DateTime?)? onDateTimeChanged;
  final Function()? onReset;

  /// Text Field
  final TekInputDateTimeType type;
  final TekInputSize size;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final bool obscureText;
  final Color? cursorColor;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String?>? onChanged;
  final Function()? onTap;
  final Function(PointerDownEvent)? onTapOutside;
  final Function()? onEditingComplete;
  final Function(String?)? onSubmitted;
  final bool? isDense;
  final bool? filled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final Color? fillColor;
  final Color? hoverColor;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? errorText;
  final int? errorMaxLines;
  final TextStyle? errorStyle;
  final bool readOnly;

  /// Date Time Picker
  final bool autoOpenSelectDate;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? currentDatePicker;
  final TimeOfDay? initialTime;

  @override
  State<TekInputDateTime> createState() => TekInputDateTimeState();
}

class TekInputDateTimeState extends State<TekInputDateTime> {
  late TextEditingController _controller;

  bool _isShowSelectDate = false;

  void setIsShowSelectDate(bool value) => _isShowSelectDate = value;

  DateTime get _initialDate {
    DateTime date = widget.initialDate ?? DateTime.now();
    if (_controller.text.isEmpty) return date;
    final convertFromText = _controller.text.toDateTimeWithFormat(_getDateTimeValidator());
    if (convertFromText != null) return convertFromText;
    return date;
  }

  DateTime get _firstDate {
    DateTime date = widget.firstDate ?? DateTime(DateTime.now().year - 15);
    if (_controller.text.isEmpty) return date;
    final convertFromText = _controller.text.toDateTimeWithFormat(_getDateTimeValidator());
    if (convertFromText != null) {
      if (convertFromText.isBefore(date)) return DateTime(convertFromText.year - 15);
    }
    return date;
  }

  DateTime get _lastDate {
    DateTime date = widget.lastDate ?? DateTime(DateTime.now().year + 15);
    if (_controller.text.isEmpty) return date;
    final convertFromText = _controller.text.toDateTimeWithFormat(_getDateTimeValidator());
    if (convertFromText != null) {
      if (convertFromText.isAfter(date)) return DateTime(convertFromText.year + 15);
    }
    return date;
  }

  DateTime? get _currentDatePicker {
    if (_controller.text.isEmpty) return widget.currentDatePicker;
    return _controller.text.toDateTimeWithFormat(_getDateTimeValidator());
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    try {
      if (widget.initialValue != null) {
        switch (widget.type) {
          case TekInputDateTimeType.date:
            _controller.text = widget.initialValue!.dateStr;
            break;
          case TekInputDateTimeType.time:
            _controller.text = widget.initialValue!.timeStr;
            break;
          case TekInputDateTimeType.dateTime:
            _controller.text = widget.initialValue!.dateTimeStr;
            break;
        }
      }
    } catch (e) {
      TekLogger.errorLog('TekInputDateTime $e');
    }
  }

  TextInputFormatter _getFormatter() {
    switch (widget.type) {
      case TekInputDateTimeType.date:
        return TekDateTimeFormatter().dateInputFormatter;
      case TekInputDateTimeType.time:
        return TekDateTimeFormatter().timeInputFormatter;
      case TekInputDateTimeType.dateTime:
        return TekDateTimeFormatter().dateTimeInputFormatter;
    }
  }

  String _getDateTimeValidator() {
    switch (widget.type) {
      case TekInputDateTimeType.date:
        return TekDateTimeFormatter().dateFormatter;
      case TekInputDateTimeType.time:
        return TekDateTimeFormatter().timeFormatter;
      case TekInputDateTimeType.dateTime:
        return TekDateTimeFormatter().dateTimeFormatter;
    }
  }

  void _onFocusChange({
    bool? hasFocus,
    required FormFieldState<DateTime> state,
  }) {
    if (hasFocus == null || hasFocus == false) return;
    if (widget.autoOpenSelectDate) {
      FocusManager.instance.primaryFocus?.unfocus();
      if (_isShowSelectDate) return;
      _onSelectDate(state);
    }
  }

  void _onSelectDate(FormFieldState<DateTime> state) async {
    setIsShowSelectDate(true);
    DateTime? date;
    switch (widget.type) {
      case TekInputDateTimeType.date:
        date = await showDatePicker(
          context: context,
          initialDate: _initialDate,
          firstDate: _firstDate,
          lastDate: _lastDate,
          currentDate: _currentDatePicker,
        );
        break;
      case TekInputDateTimeType.time:
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: widget.initialTime ?? TimeOfDay.now(),
        );
        if (time != null) {
          date = DateTime.now().copyWith(
            hour: time.hour,
            minute: time.minute,
          );
        }
        break;
      case TekInputDateTimeType.dateTime:
        await showDatePicker(
          context: context,
          initialDate: _initialDate,
          firstDate: _firstDate,
          lastDate: _lastDate,
          currentDate: _currentDatePicker,
        ).then(
              (dateResult) async {
            date = dateResult;
            if (date != null) {
              await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then(
                    (time) {
                  if (time != null) {
                    date = DateTime(
                      date!.year,
                      date!.month,
                      date!.day,
                      time.hour,
                      time.minute,
                    );
                  }
                  return null;
                },
              );
            }
            return null;
          },
        );
        break;
    }
    if (date != null) {
      _controller.text = DateFormat(_getDateTimeValidator()).format(date!);
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
    FocusManager.instance.primaryFocus?.unfocus();
    state.didChange(date);
    widget.onDateTimeChanged?.call(
      date ??
          _controller.text.toDateTimeWithFormat(
            _getDateTimeValidator(),
          ),
    );
    setIsShowSelectDate(false);
  }

  void _onDateTimeChanged(DateTime? dateTime) {
    widget.onDateTimeChanged?.call(dateTime);
    if (dateTime != null) {
      _controller.text = DateFormat(_getDateTimeValidator()).format(dateTime);
    }
  }

  void _onReset() {
    _controller.text = '';
    widget.onReset?.call();
  }

  void _onChange({
    String? dateTimeString,
    required FormFieldState<DateTime> state,
  }) {
    if (widget.autoOpenSelectDate) return;
    if (dateTimeString?.length == 10) {
      final convertDate = dateTimeString?.toDateTimeWithFormat(_getDateTimeValidator());
      if (convertDate == null) {
        state.didChange(null);
        widget.onDateTimeChanged?.call(null);
        state.validate();
      } else {
        state.didChange(convertDate);
        widget.onDateTimeChanged?.call(convertDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) => FormBuilderField<DateTime>(
        name: widget.name,
        initialValue: widget.initialValue,
        focusNode: widget.focusNodeForm,
        enabled: widget.enabled,
        autovalidateMode: widget.autoValidateMode,
        restorationId: widget.restorationId,
        validator: widget.validator,
        valueTransformer: widget.valueTransformer,
        onSaved: widget.onSaved,
        onChanged: _onDateTimeChanged,
        onReset: _onReset,
        builder: (FormFieldState<DateTime> state) {
          return Focus(
            onFocusChange: (hasFocus) => _onFocusChange(
              hasFocus: hasFocus,
              state: state,
            ),
            child: TekTextField(
              size: widget.size,
              width: widget.width,
              controller: _controller,
              focusNode: widget.focusNode,
              textAlign: widget.textAlign,
              textAlignVertical: widget.textAlignVertical,
              textInputAction: widget.textInputAction,
              keyboardType: widget.autoOpenSelectDate ? widget.keyboardType : TextInputType.number,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              maxLength: widget.maxLength,
              enabled: widget.enabled,
              obscureText: widget.obscureText,
              cursorColor: widget.cursorColor,
              inputFormatters: widget.inputFormatters ?? [_getFormatter()],
              onChanged: (text) => _onChange(
                state: state,
                dateTimeString: text,
              ),
              onTap: widget.onTap,
              onTapOutside: widget.onTapOutside,
              onEditingComplete: widget.onEditingComplete,
              onSubmitted: widget.onSubmitted,
              isDense: widget.isDense,
              filled: widget.filled,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon ?? _getIcon(state),
              contentPadding: widget.contentPadding,
              focusedBorder: widget.focusedBorder,
              enabledBorder: widget.enabledBorder,
              disabledBorder: widget.disabledBorder,
              errorBorder: widget.errorBorder,
              focusedErrorBorder: widget.focusedErrorBorder,
              fillColor: widget.fillColor,
              hoverColor: widget.hoverColor,
              labelText: widget.labelText,
              labelStyle: widget.labelStyle,
              floatingLabelStyle: widget.floatingLabelStyle,
              floatingLabelBehavior: widget.floatingLabelBehavior,
              hintText: _getHintText(),
              hintStyle: widget.hintStyle,
              errorText: widget.errorText ?? state.errorText,
              errorMaxLines: widget.errorMaxLines,
              errorStyle: widget.errorStyle,
              readOnly: widget.autoOpenSelectDate,
            ),
          );
        },
      );

  double get _iconSize {
    switch (widget.size) {
      case TekInputSize.extraLarge:
        return TekIconSizes().s24;
      case TekInputSize.large:
        return TekIconSizes().s20;
      case TekInputSize.medium:
        return TekIconSizes().s20;
      default:
        return TekIconSizes().s20;
    }
  }

  Widget _getIcon(FormFieldState<DateTime> state) {
    if (state.value == null) {
      IconData iconData = Icons.calendar_today_rounded;
      switch (widget.type) {
        case TekInputDateTimeType.date:
          iconData = Icons.calendar_today_rounded;
          break;
        case TekInputDateTimeType.time:
          iconData = Icons.watch_later_rounded;
          break;
        case TekInputDateTimeType.dateTime:
          iconData = Icons.calendar_month_rounded;
      }
      return widget.autoOpenSelectDate
          ? Icon(
              iconData,
              size: _iconSize,
            )
          : InkWell(
              onTap: () => _onSelectDate(state),
              child: Icon(
                iconData,
                size: _iconSize,
              ),
            );
    }
    return InkWell(
      onTap: () {
        state.didChange(null);
        _controller.clear();
        widget.onDateTimeChanged?.call(null);
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {});
      },
      child: Icon(
        Icons.cancel_rounded,
        size: _iconSize,
      ),
    );
  }

  String _getHintText() {
    if (widget.hintText != null) return widget.hintText!;
    switch (widget.type) {
      case TekInputDateTimeType.date:
        return 'DD/MM/YYYY';
      case TekInputDateTimeType.time:
        return 'HH:MM';
      case TekInputDateTimeType.dateTime:
        return 'DD/MM/YYYY HH:MM';
    }
  }
}