

import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: const Color.fromARGB(255, 0, 105, 65),
          // primary: const Color.fromARGB(255, 0, 255, 76),
          surface: const Color(0xFFf5f5f5),
        ),
        useMaterial3: true,
        );