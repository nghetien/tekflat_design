part of 'time_picker.dart';

class TimePickerMinuteWidget extends StatelessWidget {
  const TimePickerMinuteWidget({
    super.key,
    required this.minuteScrollController,
    required this.onMinuteChanged,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  final FixedExtentScrollController minuteScrollController;
  final Function(int) onMinuteChanged;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: ListWheelScrollView.useDelegate(
        controller: minuteScrollController,
        itemExtent: 30,
        perspective: 0.005,
        squeeze: 0.8,
        diameterRatio: 1.2,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 60,
          builder: (context, index) {
            return TekTypography(
              text: index.toString().padLeft(2, '0'),
              type: TekTypographyType.titleLarge,
              color: color ?? (minuteScrollController.selectedItem == index ? null : TekColors().grey),
              fontWeight: fontWeight,
              fontSize: fontSize,
            );
          },
        ),
        onSelectedItemChanged: (indexSelected) => onMinuteChanged(indexSelected),
      ),
    );
  }
}
