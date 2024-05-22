import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

abstract class _MyColors {
  Color get primaryColor;

  Color get secondaryColor;

  Color get hintTextColor;

  Color get descTextColor;

  Color get doctorsCardColor;

  Color get notesCardColor;

  Color get productsCardColor;

  Color get scaffoldBackgroundColor;

  Color get appBarTextColor;

  Color get cardBackgroundColor;

  Color get appBarBackgroundColor;
}

class MyColors extends _MyColors {
  final bool lightMode;

  MyColors(this.lightMode);

  @override
  Color get doctorsCardColor => HexColor('0D8B40');

  @override
  Color get hintTextColor => HexColor('7D7D7D');

  @override
  Color get notesCardColor => HexColor('004346');

  @override
  Color get primaryColor => HexColor('2148C0');

  @override
  Color get productsCardColor => HexColor('101419');

  @override
  Color get secondaryColor => HexColor('4B61A5');

  @override
  Color get descTextColor => HexColor('7D7D7D');

  @override
  Color get scaffoldBackgroundColor => HexColor('EBEBEB');

  @override
  Color get appBarTextColor => HexColor('2148C0');

  @override
  Color get cardBackgroundColor => HexColor('D9D9D9');

  @override
  Color get appBarBackgroundColor => HexColor('EBEBEB');
}

mixin CustomTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      scaffoldBackgroundColor: MyColors(true).scaffoldBackgroundColor,
      // fontFamily: GoogleFonts.cairo().fontFamily,
      cupertinoOverrideTheme:
          CupertinoThemeData(primaryColor: MyColors(true).primaryColor),
      primaryTextTheme: const TextTheme(),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors(true).secondaryColor, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors(true).secondaryColor, width: 1)),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors(true).secondaryColor, width: 1)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors(true).secondaryColor, width: 1)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors(true).secondaryColor, width: 1))),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: MyColors(true).appBarTextColor,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            // fontFamily: GoogleFonts.cairo().fontFamily,
            color: Colors.white),
      ));
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: MyColors(false).scaffoldBackgroundColor,
      // fontFamily: GoogleFonts.cairo().fontFamily,

      cupertinoOverrideTheme:
          CupertinoThemeData(primaryColor: MyColors(false).primaryColor),
      primaryTextTheme: const TextTheme(),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors(false).secondaryColor, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors(false).secondaryColor, width: 1)),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors(false).secondaryColor, width: 1)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors(false).secondaryColor, width: 1)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1)),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: MyColors(false).secondaryColor, width: 1))),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: MyColors(false).appBarTextColor,
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            // fontFamily: GoogleFonts.cairo().fontFamily,
            color: Colors.white),
      ));
}
