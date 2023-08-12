part of 'inputs.dart';

class TekInputDateTimeStreamState extends TekState<DateTime?> {
  final DateTime? dateTime;

  const TekInputDateTimeStreamState(this.dateTime) : super(dateTime);

  @override
  List<Object?> get props => [data];
}

class TekInputDateTimeForm extends StatefulWidget {
  const TekInputDateTimeForm({
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
    this.ableClearValue = true,
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
  final ValueChanged<DateTime?>? onChanged;
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

  @override
  State<TekInputDateTimeForm> createState() => TekInputDateTimeFormState();
}

class TekInputDateTimeFormState extends State<TekInputDateTimeForm> {
  final StreamController<TekInputDateTimeStreamState> _stateStreamController =
      StreamController<TekInputDateTimeStreamState>.broadcast();

  void _onDateTimeChanged(DateTime? dateTime) {
    _stateStreamController.add(TekInputDateTimeStreamState(dateTime));
    widget.onDateTimeChanged?.call(dateTime);
  }

  void _onReset() {
    _stateStreamController.add(const TekInputDateTimeStreamState(null));
    widget.onReset?.call();
  }

  @override
  void dispose() {
    _stateStreamController.close();
    super.dispose();
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
          return TekInputDateTime(
            value: state.value,
            enabled: widget.enabled,
            onChanged: widget.onChanged,
            type: widget.type,
            size: widget.size,
            width: widget.width,
            controller: widget.controller,
            focusNode: widget.focusNode,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            textInputAction: widget.textInputAction,
            keyboardType: widget.autoOpenSelectDate ? widget.keyboardType : TextInputType.number,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            obscureText: widget.obscureText,
            cursorColor: widget.cursorColor,
            inputFormatters: widget.inputFormatters,
            onTap: widget.onTap,
            onTapOutside: widget.onTapOutside,
            onEditingComplete: widget.onEditingComplete,
            onSubmitted: widget.onSubmitted,
            isDense: widget.isDense,
            filled: widget.filled,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
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
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            errorText: widget.errorText ?? state.errorText,
            errorMaxLines: widget.errorMaxLines,
            errorStyle: widget.errorStyle,
            readOnly: widget.autoOpenSelectDate,
            autoOpenSelectDate: widget.autoOpenSelectDate,
            initialDate: widget.initialDate,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            currentDatePicker: widget.currentDatePicker,
            initialTime: widget.initialTime,
            ableClearValue: widget.ableClearValue,
            didChangeForm: state.setValue,
            streamController: _stateStreamController,
          );
        },
      );
}
