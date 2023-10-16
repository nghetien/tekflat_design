part of 'time_picker.dart';

class TimePickerAMPMWidget extends StatelessWidget {
  const TimePickerAMPMWidget({
    super.key,
    required this.amPmScrollController,
    required this.onAMPMChanged,
    this.textAM,
    this.textPM,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  final FixedExtentScrollController amPmScrollController;
  final Function(bool) onAMPMChanged;
  final String? textAM;
  final String? textPM;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: ListWheelScrollView.useDelegate(
        controller: amPmScrollController,
        itemExtent: 30,
        perspective: 0.005,
        squeeze: 0.8,
        diameterRatio: 1.2,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 2,
          builder: (context, index) {
            if (index == 0) {
              return TekTypography(
                text: textAM ?? 'am',
                type: TekTypographyType.titleLarge,
                color:
                    color ?? (amPmScrollController.selectedItem == index ? null : TekColors().grey),
                fontWeight: fontWeight,
                fontSize: fontSize,
              );
            } else {
              return TekTypography(
                text: textPM ?? 'pm',
                type: TekTypographyType.titleLarge,
                color:
                    color ?? (amPmScrollController.selectedItem == index ? null : TekColors().grey),
                fontWeight: fontWeight,
                fontSize: fontSize,
              );
            }
          },
        ),
        onSelectedItemChanged: (indexSelected) => onAMPMChanged(
          indexSelected == 0,
        ),
      ),
    );
  }
}
