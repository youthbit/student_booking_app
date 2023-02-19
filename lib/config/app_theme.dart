import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ========================================================================================================
  // ============================================= Light theme ==============================================
  // ========================================================================================================
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: const IconThemeData(
      color: Colors.black,
      opacity: 1,
      size: 24,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black45,
    ),
    textTheme: TextTheme(
      /// main screen title
      displayLarge: GoogleFonts.mulish(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.w900,
      ),

      /// sub-title
      displayMedium: GoogleFonts.mulish(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),

      /// sub-title thin
      displaySmall: GoogleFonts.mulish(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),

      /// section sub title thin
      headlineLarge: GoogleFonts.mulish(
        color: Colors.white12,
        fontSize: 32,
      ),

      /// section title thin
      headlineMedium: GoogleFonts.mulish(
        color: Colors.black,
        fontSize: 18,
      ),

      /// section sub title thin
      headlineSmall: GoogleFonts.mulish(
        color: Colors.black54,
        fontSize: 14,
      ),
      bodyLarge: GoogleFonts.mulish(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      bodyMedium: GoogleFonts.mulish(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      bodySmall: GoogleFonts.mulish(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),

      /// section alert dialog
      titleLarge: GoogleFonts.mulish(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      hoverColor: Colors.green,
      splashColor: Colors.white12,
      backgroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF479F99),

      // ignore: deprecated_member_use
      primaryVariant: Colors.grey.shade300,
      secondary: const Color(0xFF1A1910),
      tertiary: const Color(0xffd0d0d0),
    ),
    // green
    primaryColor: const Color(0xff00A19A),
    // light grey
    primaryColorLight: const Color(0xff969CAE),
    // dark blue
    primaryColorDark: const Color(0xff00fff5),
    // grey not black
    canvasColor: Color(0xFFF7F6F9),
    scaffoldBackgroundColor: const Color(0xffffffff),
    cardColor: const Color(0xff424242 + 0x00555555),
    dividerColor: const Color(0x1fffffff),
    highlightColor: const Color(0x40cccccc),
    splashColor: Colors.grey,
    unselectedWidgetColor: const Color(0xb3ffffff),
    disabledColor: const Color(0x62ffffff),
    secondaryHeaderColor: const Color(0xff616161),
    dialogBackgroundColor: const Color(0xff424242),
    indicatorColor: const Color(0xff64ffda),
    hintColor: const Color(0x80ffffff),
    shadowColor: Colors.black.withOpacity(0.05),
    buttonTheme: const ButtonThemeData(
      padding: EdgeInsets.only(left: 16, right: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      buttonColor: Colors.red,
      disabledColor: Color(0x61ffffff),
      highlightColor: Color(0x29ffffff),
      splashColor: Color(0xafffffff),
      focusColor: Color(0x4fffffff),
      hoverColor: Color(0xaaffffff),
      colorScheme: ColorScheme(
        primary: Color(0xff00A19A),
        secondary: Color(0xff1E254E),
        surface: Color(0xff424242),
        background: Color(0xff121212),
        error: Color(0xffd32f2f),
        onPrimary: Color(0xff1E254E),
        onSecondary: Color(0xff000000),
        onSurface: Color(0xffffffff),
        // onBackground: Color(0xff969CAE),
        onBackground: Color(0xffffffff),
        onError: Color(0xff000000),
        brightness: Brightness.light,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle?>(
          GoogleFonts.mulish(
            color: const Color(0xff00A19A),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        // backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        // color: Colors.white.withOpacity(.5),
        color: const Color.fromARGB(255, 56, 56, 56).withOpacity(.5),
      ),
      hintStyle: TextStyle(
        color: const Color.fromARGB(255, 56, 56, 56).withOpacity(.6),
      ),
      errorStyle: const TextStyle(color: Colors.redAccent),
      // hasFloatingPlaceholder: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      prefixStyle: const TextStyle(
        color: Color(0xff969CAE),
        // color: Color(0xffffffff),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      suffixStyle: const TextStyle(
        color: Color(0xffffffff),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      counterStyle: const TextStyle(
        color: Color(0xffffffff),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 224, 224, 224),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Color(0xff00A19A),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(.5),
        ),
      ),
      suffixIconColor: Colors.white.withOpacity(.3),
    ),

    primaryIconTheme: const IconThemeData(
      color: Colors.white,
      size: 24,
    ),

    sliderTheme: const SliderThemeData(
      valueIndicatorTextStyle: TextStyle(
        color: Color(0xdd000000),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),

    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Color(0xffffffff),
      unselectedLabelColor: Color(0xb2ffffff),
    ),

    chipTheme: const ChipThemeData(
      backgroundColor: Color(0x1fffffff),
      brightness: Brightness.dark,
      deleteIconColor: Color(0xdeffffff),
      disabledColor: Color(0x0cffffff),
      labelPadding: EdgeInsets.only(left: 8, right: 8),
      labelStyle: TextStyle(
        color: Color(0xdeffffff),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
      secondaryLabelStyle: TextStyle(
        color: Color(0x3dffffff),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      secondarySelectedColor: Color(0x3d212121),
      selectedColor: Color(0x3dffffff),
      shape: StadiumBorder(),
    ),

    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(),
    ),

    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xff424242)),
  );

  // ========================================================================================================
  // ============================================== Dark theme ==============================================
  // ========================================================================================================
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    // green
    primaryColor: const Color(0xFF6C7DF7),
    // light grey
    primaryColorLight: const Color(0xff969CAE),
    // dark blue
    primaryColorDark: const Color(0xff1E254E),
    // grey not black
    canvasColor: const Color(0xff2C2C2C),
    scaffoldBackgroundColor: const Color(0xFF1A1910),
    cardColor: const Color(0xff424242),
    dividerColor: const Color(0x1fffffff),
    highlightColor: const Color(0x40cccccc),
    splashColor: const Color(0x40cccccc),
    unselectedWidgetColor: const Color(0xb3ffffff),
    disabledColor: const Color(0x62ffffff),
    secondaryHeaderColor: const Color(0xff616161),
    dialogBackgroundColor: const Color(0xff424242),
    indicatorColor: const Color(0xFF6C7DF7),
    hintColor: const Color(0x80ffffff),
      shadowColor: Colors.black.withOpacity(0.3),
    buttonTheme: const ButtonThemeData(
      padding: EdgeInsets.only(left: 16, right: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      buttonColor: Colors.red,
      disabledColor: Color(0x61ffffff),
      highlightColor: Color(0x29ffffff),
      splashColor: Color(0x1fffffff),
      focusColor: Color(0x1fffffff),
      hoverColor: Color(0x0affffff),
      colorScheme: ColorScheme(
        primary: Color(0xFF6C7DF7),
        secondary: Color(0xff1E254E),
        surface: Color(0xff424242),
        background: Color(0xffffffff),
        error: Color(0xffd32f2f),
        onPrimary: Color(0xff1E254E),
        onSecondary: Color(0xff000000),
        onSurface: Color(0xffffffff),
        // onBackground: Color(0xff969CAE),
        onBackground: Color(0xff2C2C2C),
        onError: Color(0xff000000),
        brightness: Brightness.dark,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle?>(
          GoogleFonts.mulish(
            color: const Color(0xFF6C7DF7),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        // backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),

    textTheme: TextTheme(
      /// main screen title
      displayLarge: GoogleFonts.mulish(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.w900,
      ),

      /// sub-title
      displayMedium: GoogleFonts.mulish(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),

      /// sub-title thin
      displaySmall: GoogleFonts.mulish(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),

      /// section sub title thin
      headlineLarge: GoogleFonts.mulish(
        color: Colors.white54,
        fontSize: 32,
      ),

      /// section title thin
      headlineMedium: GoogleFonts.mulish(
        color: Colors.white,
        fontSize: 18,
      ),

      /// section sub title thin
      headlineSmall: GoogleFonts.mulish(
        color: Colors.white54,
        fontSize: 14,
      ),
      bodyLarge: GoogleFonts.mulish(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      bodyMedium: GoogleFonts.mulish(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      bodySmall: GoogleFonts.mulish(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),

      /// section alert dialog
      titleLarge: GoogleFonts.mulish(
        color: Colors.white,
        fontSize: 14,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(.5),
      ),
      hintStyle: TextStyle(color: Colors.white.withOpacity(.6)),
      errorStyle: const TextStyle(color: Colors.redAccent),
      // hasFloatingPlaceholder: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      prefixStyle: const TextStyle(
        color: Color(0xff969CAE),
        // color: Color(0xffffffff),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      suffixStyle: const TextStyle(
        color: Color(0xffffffff),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      counterStyle: const TextStyle(
        color: Color(0xffffffff),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      filled: true,
      fillColor: const Color(0xFF1D1C23),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Color(0xFF6C7DF7),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(.5),
        ),
      ),
      suffixIconColor: Colors.white.withOpacity(.3),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      hoverColor: Colors.green,
      splashColor: Colors.white,
      backgroundColor: Colors.white12,
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color.fromRGBO(30, 37, 78, 1),
      secondary: Color.fromRGBO(150, 156, 174, 1),
      background: Color(0xFF18171F),
      tertiary: Color(0xff25242d),
      // onBackground: ba
    ),

    iconTheme: const IconThemeData(
      color: Colors.white,
      opacity: 1,
      size: 24,
    ),

    primaryIconTheme: const IconThemeData(
      color: Colors.black,
      size: 24,
    ),

    sliderTheme: const SliderThemeData(
      valueIndicatorTextStyle: TextStyle(
        color: Color(0xdd000000),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),

    tabBarTheme: const TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Color(0xffffffff),
      unselectedLabelColor: Color(0xb2ffffff),
    ),

    chipTheme: const ChipThemeData(
      backgroundColor: Color(0x1fffffff),
      brightness: Brightness.dark,
      deleteIconColor: Color(0xdeffffff),
      disabledColor: Color(0x0cffffff),
      labelPadding: EdgeInsets.only(left: 8, right: 8),
      labelStyle: TextStyle(
        color: Color(0xdeffffff),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      padding: EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
      secondaryLabelStyle: TextStyle(
        color: Color(0x3dffffff),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      secondarySelectedColor: Color(0x3d212121),
      selectedColor: Color(0x3dffffff),
      shape: StadiumBorder(),
    ),

    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(),
    ),

    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xff424242)),
  );
}
