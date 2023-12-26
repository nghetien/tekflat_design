part of 'data_table_reorderable.dart';

bool isShowInScreenReorderable<T>(List<TekScreenDevice>? showOnScreens) {
  return showOnScreens == null || showOnScreens.contains(TekResponsiveConfig().screenDevice);
}

double getWithAdditionColumnReorderable(TekDataTableReorderableAdditionColumn additionColumn) {
  switch (additionColumn) {
    case TekDataTableReorderableAdditionColumn.none:
      return 0;
    case TekDataTableReorderableAdditionColumn.numbered:
      return 60;
    case TekDataTableReorderableAdditionColumn.checkbox:
      return 40;
  }
}
