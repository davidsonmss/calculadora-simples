import 'package:flutter/material.dart';

// ignore: camel_case_types
class calculadoraSimplesTheme {
  static final ThemeData ligth = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.red,
    iconTheme: const IconThemeData(
      color: Colors.red,
    ),
    textTheme: textTheme,
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.orange,
    iconTheme: const IconThemeData(
      color: Colors.orange,
    ),
    textTheme: textTheme,
  );

  static const textTheme = TextTheme(
    bodyText2: TextStyle(fontSize: 20),
    button: TextStyle(fontSize: 20),
  );
}
