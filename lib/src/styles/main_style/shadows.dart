part of '../styles.dart';

class TekShadows {
  const TekShadows._();

  static BoxShadow xsDown = const BoxShadow(
    color: Color.fromRGBO(38, 38, 38, 0.10), // Màu và độ trong suốt của shadow
    offset: Offset(0, 2), // Độ lệch theo trục x và y
    blurRadius: 2, // Bán kính blur
    spreadRadius: 0, // Bán kính phân tán
  );

  static BoxShadow sDown = const BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05), // Màu và độ trong suốt của shadow
    offset: Offset(0, 2), // Độ lệch theo trục x và y
    blurRadius: 4, // Bán kính blur
    spreadRadius: 0, // Bán kính phân tán
  );

  static BoxShadow mDown = const BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05), // Màu và độ trong suốt của shadow
    offset: Offset(0, 4), // Độ lệch theo trục x và y
    blurRadius: 8, // Bán kính blur
    spreadRadius: 0, // Bán kính phân tán
  );

  static List<BoxShadow> lDown = [
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05), // Màu và độ trong suốt của shadow
      offset: Offset(0, 8), // Độ lệch theo trục x và y
      blurRadius: 16, // Bán kính blur
      spreadRadius: 0, // Bán kính phân tán
    ),
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05), // Màu và độ trong suốt của shadow
      offset: Offset(0, 4), // Độ lệch theo trục x và y
      blurRadius: 16, // Bán kính blur
      spreadRadius: 0, // Bán kính phân tán
    ),
  ];

  static BoxShadow sUp = const BoxShadow(
    color: Color(0xFFE8E8E8), // Màu của shadow
    offset: Offset(0, -2), // Độ lệch theo trục x và y
    blurRadius: 4, // Bán kính blur
    spreadRadius: 0, // Bán kính phân tán
  );

  static BoxShadow mUp = const BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.05), // Màu và độ trong suốt của shadow
    offset: Offset(0, -4), // Độ lệch theo trục x và y
    blurRadius: 8, // Bán kính blur
    spreadRadius: 0, // Bán kính phân tán
  );

  static List<BoxShadow> lUp = [
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05), // Màu và độ trong suốt của shadow
      offset: Offset(0, -8), // Độ lệch theo trục x và y
      blurRadius: 16, // Bán kính blur
      spreadRadius: 0, // Bán kính phân tán
    ),
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05), // Màu và độ trong suốt của shadow
      offset: Offset(0, -4), // Độ lệch theo trục x và y
      blurRadius: 16, // Bán kính blur
      spreadRadius: 0, // Bán kính phân tán
    ),
  ];
}
