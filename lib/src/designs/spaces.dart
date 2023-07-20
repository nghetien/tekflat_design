import 'package:flutter/material.dart';
import 'package:tekflat_design/src/styles/styles.dart';

class TekVSpace extends StatelessWidget {
  final double size;

  const TekVSpace(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(height: size);

  static TekVSpace get mainSpace => TekVSpace(TekSpacings().mainPadding);

  static TekVSpace get p4 => TekVSpace(TekSpacings().p4);

  static TekVSpace get p6 => TekVSpace(TekSpacings().p6);

  static TekVSpace get p8 => TekVSpace(TekSpacings().p8);

  static TekVSpace get p12 => TekVSpace(TekSpacings().p12);

  static TekVSpace get p14 => TekVSpace(TekSpacings().p14);

  static TekVSpace get p18 => TekVSpace(TekSpacings().p18);

  static TekVSpace get p32 => TekVSpace(TekSpacings().p32);
}

class TekHSpace extends StatelessWidget {
  final double size;

  const TekHSpace(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(width: size);

  static TekHSpace get mainSpace => TekHSpace(TekSpacings().mainPadding);

  static TekHSpace get p4 => TekHSpace(TekSpacings().p4);

  static TekHSpace get p6 => TekHSpace(TekSpacings().p6);

  static TekHSpace get p8 => TekHSpace(TekSpacings().p8);

  static TekHSpace get p12 => TekHSpace(TekSpacings().p12);

  static TekHSpace get p14 => TekHSpace(TekSpacings().p14);

  static TekHSpace get p18 => TekHSpace(TekSpacings().p18);

  static TekHSpace get p32 => TekHSpace(TekSpacings().p32);
}
