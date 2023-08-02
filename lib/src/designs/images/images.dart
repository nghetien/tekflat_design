library tek_images;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tekflat_design/src/designs/buttons/buttons.dart';
import 'package:tekflat_design/src/styles/styles.dart';
import 'package:tekflat_design/src/utils/utils.dart';

part 'tek_asset_image.dart';

part 'tek_network_image.dart';

part 'tek_network_image_form.dart';

enum TekImageSize {
  avatarSmall(24),
  avatarMedium(32),
  avatarLarge(40),
  avatarExtraLarge(48),
  normal(60);

  final double size;

  const TekImageSize(this.size);
}
