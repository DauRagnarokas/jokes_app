import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  LightTheme._();

  static const Color skinColor = Color(0xffF3CF3C);

  static ThemeData data() {
    return ThemeData(
      primarySwatch: Colors.yellow,
      scaffoldBackgroundColor: const Color(0xffF4E4CE),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: Color(0xffF3753C)),
      fontFamily:
          GoogleFonts.comicNeue(fontSize: 18, fontWeight: FontWeight.bold)
              .fontFamily,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
      cardTheme: _cardTheme,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      floatingActionButtonTheme: _floatingActionButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
    );
  }

  static final CardTheme _cardTheme = CardTheme(
    margin: EdgeInsets.zero.copyWith(bottom: 16),
  );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusColor: Colors.black,
    prefixIconColor: Colors.black,
    suffixIconColor: Colors.black,
    contentPadding: EdgeInsets.zero,
    labelStyle: const TextStyle(fontSize: 18),
    hintStyle: const TextStyle(fontSize: 18),
  );

  static final AppBarTheme _appBarTheme = AppBarTheme(
      color: skinColor,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontFamily: GoogleFonts.londrinaSolid().fontFamily,
      ));

  static final TextTheme _textTheme = TextTheme(
    bodyText1: const TextStyle(fontSize: 18.0),
    bodyText2: const TextStyle(fontSize: 18.0),
    headline1: TextStyle(
        fontSize: 48,
        fontFamily: GoogleFonts.londrinaSolid().fontFamily,
        color: Colors.black),
    headline4: TextStyle(
        fontSize: 20,
        fontFamily: GoogleFonts.roboto(fontWeight: FontWeight.w500).fontFamily,
        color: Colors.black),
    headline5:
        TextStyle(fontSize: 14, fontFamily: GoogleFonts.roboto().fontFamily),
    headline6:
        TextStyle(fontSize: 24, fontFamily: GoogleFonts.roboto().fontFamily),
  );

  static const FloatingActionButtonThemeData _floatingActionButtonTheme =
      FloatingActionButtonThemeData(
    backgroundColor: skinColor,
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.white;
          } else if (states.contains(MaterialState.pressed)) {
            return Colors.white;
          }
          return Colors.white;
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.black;
          }
          return Colors.black;
        },
      ),
    ),
  );
}
