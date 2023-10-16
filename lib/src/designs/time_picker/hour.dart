part of 'time_picker.dart';

class TimePickerHourWidget extends StatelessWidget {
  const TimePickerHourWidget({
    super.key,
    required this.hourScrollController,
    required this.onHourChanged,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  final FixedExtentScrollController hourScrollController;
  final Function(int) onHourChanged;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: ListWheelScrollView.useDelegate(
        controller: hourScrollController,
        itemExtent: 30,
        perspective: 0.005,
        squeeze: 0.8,
        diameterRatio: 1.2,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 12,
          builder: (context, index) {
            return TekTypography(
              text: (index + 1).toString(),
              type: TekTypographyType.titleLarge,
              color:
                  color ?? (hourScrollController.selectedItem == index ? null : TekColors().grey),
              fontWeight: fontWeight,
              fontSize: fontSize,
            );
          },
        ),
        onSelectedItemChanged: (indexSelected) => onHourChanged(indexSelected),
      ),
    );
  }
}
