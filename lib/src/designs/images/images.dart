library tek_images;

import 'package:tekflat_design/src/styles/styles.dart';
import 'package:tekflat_design/src/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

part 'tek_asset_image.dart';

part 'tek_network_image.dart';

enum TekImageSize {
  small(32),
  medium(40),
  large(60);

  final double size;

  const TekImageSize(this.size);
}