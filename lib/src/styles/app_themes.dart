part of 'styles.dart';

class TekThemes {
  const TekThemes._();

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: TekColors().primary,
      onPrimary: TekColors().white,
      // onSurface: TekColors().black,
      surface: TekColors().bgSecondaryThemeLight,
      onSurface: TekColors().bgPrimaryThemeLight,
      error: TekColors().red,
      secondary: TekColors().primary,
    ),
    scaffoldBackgroundColor: TekColors().bgPrimaryThemeLight,
    primaryColor: TekColors().primary,
    primaryColorDark: TekColors().primaryDark,
    primaryColorLight: TekColors().primaryLight,
    hoverColor: TekColors().primaryOpacity01,
    splashColor: TekColors().primaryOpacity01,
    highlightColor: TekColors().primaryOpacity01,
    dividerColor: TekColors().dividerThemeLight,
    fontFamily: TekFonts().defaultFont,
    appBarTheme: AppBarTheme(
      backgroundColor: TekColors().white,
      iconTheme: IconThemeData(color: TekColors().iconThemeLight),
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      titleTextStyle: TekTextStyles().titleLarge.copyWith(color: TekColors().black),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: TekColors().primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: true,
      fillColor: TekColors().inputBgThemeLight,
      suffixIconColor: TekColors().iconThemeLight,
      enabledBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: BorderSide(
          color: TekColors().inputBorderThemeLight,
          width: TekBorders.thin,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: BorderSide(
          color: TekColors().inputDisabledBorderThemeLight,
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
        borderSide: BorderSide(
          color: TekColors().red,
          width: TekBorders.thin,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: BorderSide(
          color: TekColors().red,
          width: TekBorders.thin,
        ),
      ),
      floatingLabelStyle: TekTextStyles().label.copyWith(color: TekColors().primary),
      labelStyle: TekTextStyles().label.copyWith(color: TekColors().textSecondary),
      errorStyle: TekTextStyles().label.copyWith(color: TekColors().red),
    ),
    cardTheme: CardTheme(color: TekColors().cardThemeLight),
    cardColor: TekColors().cardThemeLight,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: TekColors().bgSecondaryThemeLight,
    ),
    iconTheme: IconThemeData(color: TekColors().iconThemeLight),
    textTheme: TextTheme(
      titleMedium: TekTextStyles().body.copyWith(color: TekColors().textPrimaryThemeLight),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(TekColors().primary),
      side: BorderSide(width: TekBorders.med, color: TekColors().grey),
      splashRadius: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(TekColors().bgSecondaryThemeLight),
        foregroundColor: WidgetStateProperty.all(TekColors().black),
        shape: WidgetStateProperty.all(
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
        backgroundColor: WidgetStateProperty.all(TekColors().bgSecondaryThemeLight),
        surfaceTintColor: WidgetStateProperty.all(TekColors().bgSecondaryThemeLight),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: TekCorners().mainCornerBorder,
        side: BorderSide(color: TekColors().greyOpacity01, width: TekBorders.thin),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: TekColors().primary,
      // màu bên phải date picker
      backgroundColor: TekColors().bgSecondaryThemeLight,
      // màu chọn ngày
      headerForegroundColor: TekColors().white,
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
      dayStyle: TekTextStyles().body,
    ),
    timePickerTheme: TimePickerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: TekCorners().mainCornerBorder,
        side: BorderSide(color: TekColors().greyOpacity01, width: TekBorders.thin),
      ),
      dialTextStyle: TekTextStyles().body,
      backgroundColor: TekColors().bgSecondaryThemeLight,
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
      // surface: TekColors().bgPrimaryThemeDark,
      // onSurface: TekColors().white,
      surface: TekColors().bgSecondaryThemeDark,
      onSurface: TekColors().bgPrimaryThemeDark,
      error: TekColors().red,
      secondary: TekColors().primary,
    ),
    scaffoldBackgroundColor: TekColors().bgPrimaryThemeDark,
    primaryColor: TekColors().primary,
    primaryColorDark: TekColors().primaryDark,
    primaryColorLight: TekColors().primaryLight,
    hoverColor: TekColors().primaryOpacity01,
    splashColor: TekColors().primaryOpacity01,
    highlightColor: TekColors().primaryOpacity01,
    dividerColor: TekColors().dividerThemeDark,
    fontFamily: TekFonts().defaultFont,
    appBarTheme: AppBarTheme(
      backgroundColor: TekColors().bgSecondaryThemeDark,
      iconTheme: IconThemeData(color: TekColors().iconThemeDark),
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      titleTextStyle: TekTextStyles().titleLarge.copyWith(color: TekColors().white),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: TekColors().primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: true,
      fillColor: TekColors().inputBgThemeDark,
      suffixIconColor: TekColors().inputBgThemeDark,
      enabledBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: BorderSide(
          color: TekColors().inputBorderThemeDark,
          width: TekBorders.thin,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: BorderSide(
          color: TekColors().inputDisabledBorderThemeDark,
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
        borderSide: BorderSide(
          color: TekColors().red,
          width: TekBorders.thin,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: TekCorners().mainCornerBorder,
        borderSide: BorderSide(
          color: TekColors().red,
          width: TekBorders.thin,
        ),
      ),
      floatingLabelStyle: TekTextStyles().label.copyWith(color: TekColors().primary),
      labelStyle: TekTextStyles().label.copyWith(color: TekColors().textSecondary),
      errorStyle: TekTextStyles().label.copyWith(color: TekColors().red),
    ),
    cardTheme: CardTheme(color: TekColors().cardThemeDark),
    cardColor: TekColors().cardThemeDark,
    canvasColor: TekColors().bgSecondaryThemeDark,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: TekColors().bgSecondaryThemeDark,
    ),
    iconTheme: IconThemeData(color: TekColors().iconThemeDark),
    textTheme: TextTheme(
      titleMedium: TekTextStyles().body.copyWith(color: TekColors().textPrimaryThemeDark),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dialogBackgroundColor: TekColors().bgSecondaryThemeDark,
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(TekColors().black),
      side: BorderSide(width: TekBorders.med, color: TekColors().grey),
      splashRadius: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(TekColors().bgSecondaryThemeDark),
        foregroundColor: WidgetStateProperty.all(TekColors().white),
        shape: WidgetStateProperty.all(
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
        backgroundColor: WidgetStateProperty.all(TekColors().bgPrimaryThemeDark),
        surfaceTintColor: WidgetStateProperty.all(TekColors().bgPrimaryThemeDark),
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: TekCorners().mainCornerBorder,
        side: BorderSide(color: TekColors().greyOpacity01, width: TekBorders.thin),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: TekColors().primary,
      // màu bên phải date picker
      backgroundColor: TekColors().bgSecondaryThemeDark,
      // màu chọn ngày
      headerForegroundColor: TekColors().white,
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
      dayStyle: TekTextStyles().body,
    ),
    timePickerTheme: TimePickerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: TekCorners().mainCornerBorder,
        side: BorderSide(color: TekColors().greyOpacity01, width: TekBorders.thin),
      ),
      dialTextStyle: TekTextStyles().body,
      backgroundColor:  const Color(0xFF0D2141),
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
