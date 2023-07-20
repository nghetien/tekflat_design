part of 'styles.dart';

class TekThemes {
  const TekThemes._();

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: TekColors().primary,
      onPrimary: TekColors.white,
      onSurface: TekColors.black,
      background: TekColors().bgSecondaryThemeLight,
      onBackground: TekColors().bgPrimaryThemeLight,
      error: TekColors.red,
    ),
    scaffoldBackgroundColor: TekColors().bgPrimaryThemeLight,
    primaryColor: TekColors().primary,
    primaryColorDark: TekColors().primaryDark,
    primaryColorLight: TekColors().primaryLight,
    hoverColor: TekColors().primaryOpacity01,
    splashColor: TekColors().primaryOpacity01,
    highlightColor: TekColors().primaryOpacity01,
    dividerColor: Colors.transparent,
    fontFamily: TekFonts().defaultFont,
    appBarTheme: AppBarTheme(
      backgroundColor: TekColors.white,
      iconTheme: const IconThemeData(color: TekColors.black),
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      titleTextStyle: TekTextStyles.titleLarge.copyWith(color: TekColors.white),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: TekColors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: true,
      fillColor: TekColors.white,
      suffixIconColor: TekColors.black,
      contentPadding: EdgeInsets.symmetric(
        horizontal: TekSpacings().p8,
        vertical: TekSpacings().p12,
      ),
      // contentPadding: EdgeInsets.zero,
      enabledBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: BorderSide(
          color: TekColors().greyOpacity04,
          width: TekBorders.thin,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: BorderSide(
          color: TekColors().greyOpacity04,
          width: TekBorders.thin,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: BorderSide(
          color: TekColors().primary,
          width: TekBorders.thin,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: const BorderSide(
          color: TekColors.red,
          width: TekBorders.thin,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: const BorderSide(
          color: TekColors.red,
          width: TekBorders.thin,
        ),
      ),
      floatingLabelStyle: TekTextStyles.label.copyWith(color: TekColors().primary),
      labelStyle: TekTextStyles.label.copyWith(color: TekColors.grey),
      errorStyle: TekTextStyles.label.copyWith(color: TekColors.red),
    ),
    cardTheme: CardTheme(color: TekColors().cardThemeLight),
    cardColor: TekColors().cardThemeLight,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: TekColors().bgPrimaryThemeLight),
    iconTheme: const IconThemeData(color: TekColors.black),
    textTheme: TextTheme(
      titleMedium: TekTextStyles.body.copyWith(color: TekColors.black),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(TekColors().primary),
      checkColor: MaterialStateProperty.all(TekColors().primary),
      side: BorderSide(width: TekBorders.med, color: TekColors().primary),
      splashRadius: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(TekColors().bgSecondaryThemeLight),
        foregroundColor: MaterialStateProperty.all(TekColors.black),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: TekCorners().mainCornerBorder,
          ),
        ),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: TekColors().bgSecondaryThemeLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: TekCorners().mainCornerBorder,
        side: BorderSide(color: TekColors().greyOpacity02, width: TekBorders.thin),
      ),
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: MaterialStateProperty.all(TekColors().bgSecondaryThemeLight),
        surfaceTintColor: MaterialStateProperty.all(TekColors().bgSecondaryThemeLight),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: TekCorners().mainCornerBorder,
        side: BorderSide(color: TekColors().greyOpacity01, width: TekBorders.thin),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: TekColors().bgSecondaryThemeLight,
      // màu bên phải date picker
      backgroundColor: TekColors().bgSecondaryThemeLight,
      // màu chọn ngày
      headerForegroundColor: TekColors.black,
      // màu chữ
      surfaceTintColor: TekColors().bgSecondaryThemeLight,
      rangePickerShape: RoundedRectangleBorder(
        borderRadius: TekCorners().mainCornerBorder,
        side: BorderSide(color: TekColors().greyOpacity01, width: TekBorders.thin),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: TekCorners().mainCornerBorder,
        side: BorderSide(color: TekColors().greyOpacity01, width: TekBorders.thin),
      ),
      dayStyle: TekTextStyles.body,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: TekColors().primary,
      surface: TekColors().bgPrimaryThemeDark,
      onSurface: TekColors.white,
      background: TekColors().bgSecondaryThemeDark,
      onBackground: TekColors().bgPrimaryThemeDark,
      error: TekColors.red,
    ),
    scaffoldBackgroundColor: TekColors().bgPrimaryThemeDark,
    primaryColor: TekColors().primary,
    primaryColorDark: TekColors().primaryDark,
    primaryColorLight: TekColors().primaryLight,
    hoverColor: TekColors().primaryOpacity01,
    splashColor: TekColors().primaryOpacity01,
    highlightColor: TekColors().primaryOpacity01,
    dividerColor: Colors.transparent,
    fontFamily: TekFonts().defaultFont,
    appBarTheme: AppBarTheme(
      backgroundColor: TekColors().bgSecondaryThemeDark,
      iconTheme: const IconThemeData(color: TekColors.white),
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      titleTextStyle: TekTextStyles.titleLarge.copyWith(color: TekColors.white),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: TekColors().primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: true,
      fillColor: TekColors().bgPrimaryThemeDark,
      suffixIconColor: TekColors.white,
      contentPadding: EdgeInsets.symmetric(
        horizontal: TekSpacings().p8,
        vertical: TekSpacings().p12,
      ),
      // contentPadding: EdgeInsets.zero,
      enabledBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: BorderSide(
          color: TekColors().bgPrimaryThemeDark,
          width: TekBorders.thin,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: BorderSide(
          color: TekColors().greyOpacity04,
          width: TekBorders.thin,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: BorderSide(
          color: TekColors().primary,
          width: TekBorders.thin,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: const BorderSide(
          color: TekColors.red,
          width: TekBorders.thin,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: const BorderSide(
          color: TekColors.red,
          width: TekBorders.thin,
        ),
      ),
      floatingLabelStyle: TekTextStyles.label.copyWith(color: TekColors().primary),
      labelStyle: TekTextStyles.label.copyWith(color: TekColors.grey),
      errorStyle: TekTextStyles.label.copyWith(color: TekColors.red),
    ),
    cardTheme: CardTheme(color: TekColors().cardThemeDark),
    cardColor: TekColors().cardThemeDark,
    canvasColor: TekColors().bgSecondaryThemeDark,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: TekColors().bgPrimaryThemeDark),
    iconTheme: const IconThemeData(color: TekColors.white),
    textTheme: TextTheme(
      titleMedium: TekTextStyles.body.copyWith(color: TekColors.white),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dialogBackgroundColor: TekColors().bgSecondaryThemeDark,
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(TekColors().primary),
      checkColor: MaterialStateProperty.all(TekColors().primary),
      side: BorderSide(width: TekBorders.med, color: TekColors().primary),
      splashRadius: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(TekColors().bgSecondaryThemeDark),
        foregroundColor: MaterialStateProperty.all(TekColors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: TekCorners().mainCornerBorder,
          ),
        ),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: TekColors().bgSecondaryThemeDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: TekCorners().mainCornerBorder,
        side: BorderSide(color: TekColors().greyOpacity02, width: TekBorders.thin),
      ),
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: MaterialStateProperty.all(TekColors().bgPrimaryThemeDark),
        surfaceTintColor: MaterialStateProperty.all(TekColors().bgPrimaryThemeDark),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: TekCorners().mainCornerBorder,
        side: BorderSide(color: TekColors().greyOpacity01, width: TekBorders.thin),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: TekColors().bgSecondaryThemeDark,
      // màu bên phải date picker
      backgroundColor: TekColors().bgSecondaryThemeDark,
      // màu chọn ngày
      headerForegroundColor: TekColors.white,
      // màu chữ
      surfaceTintColor: TekColors().bgSecondaryThemeDark,
      rangePickerShape: RoundedRectangleBorder(
        borderRadius: TekCorners().mainCornerBorder,
        side: BorderSide(color: TekColors().greyOpacity01, width: TekBorders.thin),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: TekCorners().mainCornerBorder,
        side: BorderSide(color: TekColors().greyOpacity01, width: TekBorders.thin),
      ),
      dayStyle: TekTextStyles.body,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );
}
