// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

ThemeData LightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: Colors.black45,
      selectedItemColor: Colors.blue,
    ),
    appBarTheme: const AppBarTheme(
        color: Colors.black,
        actionsIconTheme: IconThemeData(color: Colors.black)),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        bodyMedium: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        bodySmall: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black45)));
