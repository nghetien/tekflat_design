import 'package:flutter/material.dart';
import 'package:tekflat_design/src/styles/styles.dart';

class VSpace extends StatelessWidget {
  final double size;

  const VSpace(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(height: size);

  static VSpace get mainSpace => VSpace(TekPaddings().mainPadding);

  static VSpace get p4 => VSpace(TekPaddings().p4);

  static VSpace get p8 => VSpace(TekPaddings().p8);

  static VSpace get p12 => VSpace(TekPaddings().p12);

  static VSpace get p14 => VSpace(TekPaddings().p14);

  static VSpace get p18 => VSpace(TekPaddings().p18);

  static VSpace get p32 => VSpace(TekPaddings().p32);
}

class HSpace extends StatelessWidget {
  final double size;

  const HSpace(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(width: size);

  static HSpace get mainSpace => HSpace(TekPaddings().mainPadding);

  static HSpace get p4 => HSpace(TekPaddings().p4);

  static HSpace get p8 => HSpace(TekPaddings().p8);

  static HSpace get p12 => HSpace(TekPaddings().p12);

  static HSpace get p14 => HSpace(TekPaddings().p14);

  static HSpace get p18 => HSpace(TekPaddings().p18);

  static HSpace get p32 => HSpace(TekPaddings().p32);
}
