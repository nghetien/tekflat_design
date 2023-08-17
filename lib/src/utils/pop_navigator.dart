import 'package:flutter/material.dart';
import 'package:tekflat_design/src/utils/utils.dart';

void popNavigatorMultiPlatform(BuildContext context) {
  if (TekPlatform.isWeb) {
    context.popRootNavigator();
  } else {
    context.popNavigator();
  }
}
