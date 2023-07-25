part of 'inputs.dart';

enum TekInputDateTimeType {
  date,
  time,
  dateTime,
}

class TekInputDateTime extends StatefulWidget {
  const TekInputDateTime({
    Key? key,
    this.name,
    this.type = TekInputDateTimeType.date,
    this.autoOpenSelectDate = true,
    this.initialValue,
    this.onDateChanged,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.currentDate,
    this.initialTime,
    this.size = TekInputSize.medium,
    this.width,
    this.controller,
    this.focusNode,
    this.onFocusChange,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textInputAction,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.enabled = true,
    this.obscureText = false,
    this.scrollPadding,
    this.cursorColor,
    this.autoValidateMode,
    this.validator,
    this.inputFormatters,
    this.valueTransformer,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onSaved,
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
  }) : super(key: key);

  final String? name;
  final TekInputDateTimeType type;
  final bool autoOpenSelectDate;
  final DateTime? initialValue;
  final Function(DateTime?)? onDateChanged;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? currentDate;
  final TimeOfDay? initialTime;
  final TekInputSize size;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(bool)? onFocusChange;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final bool enabled;
  final bool obscureText;
  final EdgeInsets? scrollPadding;
  final Color? cursorColor;
  final AutovalidateMode? autoValidateMode;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final ValueTransformer<String?>? valueTransformer;
  final ValueChanged<DateTime?>? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final FormFieldSetter? onSaved;
  final ValueChanged<String?>? onSubmitted;
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

  @override
  State<TekInputDateTime> createState() => TekInputDateTimeState();
}

class TekInputDateTimeState extends State<TekInputDateTime> {
  bool _isShowSelectDate = false;

  void setIsShowSelectDate(bool value) => _isShowSelectDate = value;

  late FocusNode _focusNode;
  late TextEditingController _controller;

  void _onFocusChange() {
    if (widget.autoOpenSelectDate && _focusNode.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
      if (_isShowSelectDate) return;
      _onSelectDate();
    }
    widget.onFocusChange?.call(_focusNode.hasFocus);
  }

  void resetCurrentData(DateTime? value) {
    if (value == null) {
      _controller.clear();
      return;
    }
    switch (widget.type) {
      case TekInputDateTimeType.date:
        _controller.text = value.dateStr;
        break;
      case TekInputDateTimeType.time:
        _controller.text = value.timeStr;
        break;
      case TekInputDateTimeType.dateTime:
        _controller.text = value.dateTimeStr;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
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

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    super.dispose();
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

  FormFieldValidator<String> _getValidator() {
    switch (widget.type) {
      case TekInputDateTimeType.date:
        return TekFormValidator.dateTime(
          errorText: TekFormValidatorMessageError().dateTime,
          validator: _getDateTimeValidator(),
        );
      case TekInputDateTimeType.time:
        return TekFormValidator.timeOfDay(
          errorText: TekFormValidatorMessageError().timeOfDay,
        );
      case TekInputDateTimeType.dateTime:
        return TekFormValidator.dateTime(
          errorText: TekFormValidatorMessageError().dateTime,
          validator: _getDateTimeValidator(),
        );
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

  void _onSelectDate() async {
    setIsShowSelectDate(true);
    DateTime? date;
    switch (widget.type) {
      case TekInputDateTimeType.date:
        date = await showDatePicker(
          context: context,
          initialDate: widget.initialDate ?? DateTime.now(),
          firstDate: widget.firstDate ?? DateTime(DateTime.now().year - 5),
          lastDate: widget.lastDate ?? DateTime(DateTime.now().year + 5),
          currentDate: widget.currentDate,
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
          initialDate: widget.initialDate ?? DateTime.now(),
          firstDate: widget.firstDate ?? DateTime(DateTime.now().year - 5),
          lastDate: widget.lastDate ?? DateTime(DateTime.now().year + 5),
          currentDate: widget.currentDate,
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
    widget.onDateChanged?.call(
      date ??
          _controller.text.toDateTimeWithFormat(
            _getDateTimeValidator(),
          ),
    );
    setIsShowSelectDate(false);
  }

  void _onChanged(String? value) {
    widget.onChanged?.call(value?.toDateTimeWithFormat(_getDateTimeValidator()));
  }

  @override
  Widget build(BuildContext context) => TekInput(
        name: widget.name,
        size: widget.size,
        width: widget.width,
        controller: _controller,
        focusNode: _focusNode,
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        enabled: widget.enabled,
        obscureText: widget.obscureText,
        cursorColor: widget.cursorColor,
        autoValidateMode: widget.autoValidateMode,
        validator: widget.validator ?? FormBuilderValidators.compose([_getValidator()]),
        inputFormatters: widget.inputFormatters ?? [_getFormatter()],
        valueTransformer: (value) {
          if (value == null || value.isEmpty) return null;
          return value.toDateTimeWithFormat(_getDateTimeValidator());
        },
        onChanged: _onChanged,
        onTap: widget.onTap,
        onEditingComplete: widget.onEditingComplete,
        onSaved: widget.onSaved,
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
    return InkWell(
      onTap: () => _onSelectDate(),
      child: Icon(
        iconData,
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