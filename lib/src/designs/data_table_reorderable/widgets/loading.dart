part of '../data_table_reorderable.dart';

class TekDataTableReorderableLoadingWidget extends StatelessWidget {
  const TekDataTableReorderableLoadingWidget({
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
