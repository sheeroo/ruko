import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme(BuildContext context) {
  return ThemeData(
    primaryColor: Colors.white,
    splashFactory: NoSplash.splashFactory,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        visualDensity: VisualDensity.compact,
        textStyle: WidgetStateProperty.all(
          GoogleFonts.pressStart2p(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all(Colors.white),
        iconSize: WidgetStateProperty.all(24),
        backgroundColor: WidgetStateProperty.all(Colors.black),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        visualDensity: VisualDensity.compact,
        splashFactory: NoSplash.splashFactory,
        textStyle: WidgetStateProperty.all(
          GoogleFonts.pressStart2p(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.only(bottom: 100),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      contentTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
    listTileTheme: ListTileThemeData(
      visualDensity: VisualDensity.compact,
      selectedTileColor: Colors.white.withValues(alpha: 0.1),
      selectedColor: Colors.white,
      iconColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white.withValues(alpha: 0.1),
      splashColor: Colors.black.withValues(alpha: 0.1),
      iconSize: 14,
      highlightElevation: 0,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      disabledElevation: 0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.black.withValues(alpha: 0.1),
      disabledColor: Colors.white.withValues(alpha: 0.5),
      selectedColor: Colors.white.withValues(alpha: 0.75),
      secondarySelectedColor: Colors.white.withValues(alpha: 0.5),
      labelPadding: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      labelStyle: GoogleFonts.pressStart2p(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      secondaryLabelStyle: GoogleFonts.pressStart2p(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      brightness: Brightness.dark,
    ),
    buttonTheme: const ButtonThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      buttonColor: Colors.white,
      textTheme: ButtonTextTheme.primary,
    ),
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStateProperty.all(Colors.black),
    ),
    scaffoldBackgroundColor: Colors.black,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.white.withValues(alpha: 0.1),
      cursorColor: Colors.white,
      selectionHandleColor: Colors.white,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.black,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      // activeIndicatorBorder: InputBorder.none,
      labelStyle: TextStyle(
        color: Colors.white.withValues(alpha: 0.5),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      floatingLabelStyle: TextStyle(
        color: Colors.white.withValues(alpha: 0.5),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,
      barBackgroundColor: Colors.black,
      textTheme: CupertinoTextThemeData(
        primaryColor: Colors.white,
        navTitleTextStyle: GoogleFonts.pressStart2p(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        navLargeTitleTextStyle: GoogleFonts.pressStart2p(
          fontSize: 34,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        textStyle: GoogleFonts.pressStart2p(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(iconColor: WidgetStateProperty.all(Colors.white)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.pressStart2p(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.pressStart2pTextTheme(
      Theme.of(
        context,
      ).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
    ),
  );
}
