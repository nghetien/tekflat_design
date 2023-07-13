part of '../data_table.dart';

class TekDataTableLoadingWidget extends StatelessWidget {
  const TekDataTableLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: TekCorners.cornerBorder8,
        color: context.theme.colorScheme.background.withOpacity(0.5),
      ),
      child: const TekLoadingWidget(),
    );
  }
}
