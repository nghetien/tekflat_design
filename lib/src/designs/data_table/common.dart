part of 'data_table.dart';

bool isShowInScreen<T>(List<TekScreenDevice>? showOnScreens) {
  return showOnScreens == null || showOnScreens.contains(TekResponsiveConfig().screenDevice);
}

double getWithAdditionColumn(TekDataTableAdditionColumn additionColumn) {
  switch (additionColumn) {
    case TekDataTableAdditionColumn.none:
      return 0;
    case TekDataTableAdditionColumn.numbered:
      return 60;
    case TekDataTableAdditionColumn.checkbox:
      return 40;
  }
}
