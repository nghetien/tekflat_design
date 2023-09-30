import 'package:flutter/material.dart';
import 'package:tekflat_design/src/utils/utils.dart';

void popNavigatorMultiPlatform<T extends Object?>(BuildContext context, [T? result]) {
  if (TekPlatform.isWeb) {
    context.popRootNavigator<T>(result);
  } else {
    context.popNavigator<T>(result);
  }
}
