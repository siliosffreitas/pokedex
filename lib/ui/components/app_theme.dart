import 'package:flutter/material.dart';

ThemeData makeAppTheme() {
  final primaryColor = Color(0xFFDC0A2D);

  return ThemeData(
      primaryColor: primaryColor,
      iconTheme: IconThemeData(
        color: primaryColor,
      )
      // primaryColorLight: primaryColorLight,
      // primaryColorDark: primaryColorDark,
      // secondaryHeaderColor: secondaryColorDark,
      // highlightColor: secondaryColor,
      // accentColor: primaryColor,
      // backgroundColor: Colors.white,
      // disabledColor: disabledColor,
      // dividerColor: dividerColor,
      // textTheme: TextTheme(
      //   headline1: TextStyle(
      //     fontSize: 30,
      //     fontWeight: FontWeight.bold,
      //     color: primaryColorDark,
      //   ),
      // ),
      // inputDecorationTheme: InputDecorationTheme(
      //   enabledBorder: UnderlineInputBorder(
      //     borderSide: BorderSide(
      //       color: primaryColorLight,
      //     ),
      //   ),
      //   focusedBorder: UnderlineInputBorder(
      //     borderSide: BorderSide(
      //       color: primaryColor,
      //     ),
      //   ),
      //   alignLabelWithHint: true,
      // ),
      // buttonTheme: ButtonThemeData(
      //   colorScheme: ColorScheme.light(primary: primaryColor),
      //   buttonColor: primaryColor,
      //   splashColor: primaryColorLight,
      //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      //   textTheme: ButtonTextTheme.primary,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      // ),
      );
}
