part of 'inputs.dart';

enum TekInputDateTimeType {
  date,
  time,
  dateTime,
}

class TekInputDateTime extends StatefulWidget {
  const TekInputDateTime({
    Key? key,
    this.value,
    this.enabled = true,
    this.onChanged,

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
    this.ableClearValue = true,
    this.didChangeForm,
    this.streamController,
  }) : super(key: key);

  final DateTime? value;
  final bool enabled;
  final Function(DateTime?)? onChanged;

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
  final DateTime? Function()? initialDate;
  final DateTime? Function()? firstDate;
  final DateTime? Function()? lastDate;
  final DateTime? Function()? currentDatePicker;
  final TimeOfDay? initialTime;
  final bool ableClearValue;
  final Function(DateTime?)? didChangeForm;
  final StreamController<TekInputDateTimeStreamState>? streamController;

  @override
  State<TekInputDateTime> createState() => TekInputDateTimeState();
}

class TekInputDateTimeState extends State<TekInputDateTime> {
  late TextEditingController _controller;
  StreamSubscription<TekInputDateTimeStreamState>? _listenerStreamState;

  DateTime? _value;

  DateTime get _initialDate {
    DateTime date = widget.initialDate?.call() ?? DateTime.now();
    if (_controller.text.isNotEmpty) {
      final convertFromText = _controller.text.toDateTimeWithFormat(_getDateTimeValidator());
      if (convertFromText != null) {
        date = convertFromText;
      }
    }
    if (date.isBefore(_firstDate)) return _firstDate;
    if (date.isAfter(_lastDate)) return _lastDate;
    return date;
  }

  DateTime get _firstDate {
    DateTime date = widget.firstDate?.call() ?? DateTime(DateTime.now().year - 15);
    if (_controller.text.isEmpty) return date;
    final convertFromText = _controller.text.toDateTimeWithFormat(_getDateTimeValidator());
    if (convertFromText != null && !widget.autoOpenSelectDate) {
      if (convertFromText.isBefore(date)) return DateTime(convertFromText.year - 15);
    }
    return date;
  }

  DateTime get _lastDate {
    DateTime date = widget.lastDate?.call() ?? DateTime(DateTime.now().year + 15);
    if (_controller.text.isEmpty) return date;
    final convertFromText = _controller.text.toDateTimeWithFormat(_getDateTimeValidator());
    if (convertFromText != null && !widget.autoOpenSelectDate) {
      if (convertFromText.isAfter(date)) return DateTime(convertFromText.year + 15);
    }
    return date;
  }

  DateTime? get _currentDatePicker {
    if (_controller.text.isEmpty) return widget.currentDatePicker?.call();
    return _controller.text.toDateTimeWithFormat(_getDateTimeValidator());
  }

  bool get _ableClearValue {
    if (!widget.enabled) return false;
    return widget.ableClearValue;
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

  void _listenStream(TekInputDateTimeStreamState state) {
    if (state.dateTime == _value) return;
    _setValue(state.dateTime);
  }

  @override
  void initState() {
    super.initState();
    _listenerStreamState = widget.streamController?.stream.listen(_listenStream);
    _controller = widget.controller ?? TextEditingController();
    _setValue(
      widget.value,
      callOnChanged: false,
      callSetState: false,
    );
  }

  @override
  void didUpdateWidget(TekInputDateTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _setValue(
        widget.value,
        callOnChanged: false,
      );
    }
  }

  @override
  void dispose() {
    _listenerStreamState?.cancel();
    super.dispose();
  }

  void _setValue(
    DateTime? value, {
    bool callOnChanged = true,
    bool callSetState = true,
  }) {
    if (value == _value) return;
    _value = value;
    if (value != null) {
      _controller.text = DateFormat(_getDateTimeValidator()).format(value);
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    } else {
      _controller.clear();
    }
    if (callSetState) {
      widget.didChangeForm?.call(value);
      setState(() {});
    }
    if (callOnChanged) widget.onChanged?.call(value);
  }

  void _onSelectDate() async {
    if (mounted) {
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
      if (date != null) _setValue(date);
    }
  }

  void _onChange({String? dateTimeString}) {
    if (widget.autoOpenSelectDate) return;
    if (dateTimeString?.length == 10) {
      final convertDate = dateTimeString?.toDateTimeWithFormat(_getDateTimeValidator());
      if (convertDate == null) {
        _setValue(null);
      } else {
        _setValue(convertDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TekTextField(
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
        dateTimeString: text,
      ),
      onTap: () {
        if (!widget.enabled) return;
        if (widget.autoOpenSelectDate) _onSelectDate();
        widget.onTap?.call();
      },
      onTapOutside: widget.onTapOutside,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onSubmitted,
      isDense: widget.isDense,
      filled: widget.filled,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon ?? _getIcon(),
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
      errorText: widget.errorText,
      errorMaxLines: widget.errorMaxLines,
      errorStyle: widget.errorStyle,
      readOnly: widget.autoOpenSelectDate,
    );
  }

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

  Widget _getIcon() {
    if (_value != null && _ableClearValue) {
      return InkWell(
        onTap: () => _setValue(
          null,
          callSetState: true,
        ),
        child: Icon(
          Icons.cancel_rounded,
          size: _iconSize,
        ),
      );
    }
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
            onTap: () => _onSelectDate(),
            child: Icon(
              iconData,
              size: _iconSize,
            ),
          );
  }
}