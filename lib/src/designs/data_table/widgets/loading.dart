part of '../data_table.dart';

class TekDataTableLoadingWidget extends StatelessWidget {
  const TekDataTableLoadingWidget({
    Key? key,
    this.borderRadius,
  }) : super(key: key);

  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? TekCorners().mainCornerBorder,
        color: context.theme.colorScheme.surface.withOpacity(0.5),
      ),
      child: const TekLoadingWidget(),
    );
  }
}
