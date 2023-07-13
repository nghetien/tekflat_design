import 'package:flutter/material.dart';
import 'package:tekflat_design/src/styles/styles.dart';

class TekOutlineBorder {
  const TekOutlineBorder._();

  static const BeveledRectangleBorder none = BeveledRectangleBorder(
    side: BorderSide(
      color: Colors.transparent,
      width: 0,
    ),
    borderRadius: BorderRadius.zero,
  );

  static final RoundedRectangleBorder left = RoundedRectangleBorder(
    side: const BorderSide(
      color: Colors.transparent,
      width: 0,
    ),
    borderRadius: BorderRadius.only(
      topLeft: TekCorners().mainCornerRadius,
      bottomLeft: TekCorners().mainCornerRadius,
    ),
  );

  static final RoundedRectangleBorder right = RoundedRectangleBorder(
    side: const BorderSide(
      color: Colors.transparent,
      width: 0,
    ),
    borderRadius: BorderRadius.only(
      topRight: TekCorners().mainCornerRadius,
      bottomRight: TekCorners().mainCornerRadius,
    ),
  );
}
