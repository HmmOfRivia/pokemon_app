import 'package:flutter/material.dart';

class AppColors {
  AppColors({
    required this.accentColor,
    required this.backgroundColor,
    required this.iconColor,
    required this.dividerColor,
  });

  factory AppColors.light() {
    return AppColors(
      accentColor: Color.fromARGB(255, 129, 166, 190),
      backgroundColor: Colors.white,
      iconColor: Colors.white,
      dividerColor: Color.fromARGB(255, 129, 166, 190),
    );
  }

  factory AppColors.dark() {
    return AppColors(
      accentColor: Color.fromARGB(255, 129, 166, 190),
      backgroundColor: Color.fromARGB(255, 54, 54, 54),
      iconColor: Colors.white,
      dividerColor: Color.fromARGB(255, 129, 166, 190),
    );
  }

  final Color accentColor;

  final Color backgroundColor;

  final Color iconColor;

  final Color dividerColor;

  final ColorScheme scheme = ColorScheme.fromSwatch(
    primarySwatch: MaterialColor(0xFF81A6BE, {
      50: Color.fromRGBO(129, 166, 190, .1),
      100: Color.fromRGBO(129, 166, 190, .2),
      200: Color.fromRGBO(129, 166, 190, .3),
      300: Color.fromRGBO(129, 166, 190, .4),
      400: Color.fromRGBO(129, 166, 190, .5),
      500: Color.fromRGBO(129, 166, 190, .6),
      600: Color.fromRGBO(129, 166, 190, .7),
      700: Color.fromRGBO(129, 166, 190, .8),
      800: Color.fromRGBO(129, 166, 190, .9),
      900: Color.fromRGBO(129, 166, 190, 1),
    }),
  );

  Color? getCardColors(String color) {
    //TODO(fliszkiewicz) : Match colors with API values

    const Color greenCardColor = Color.fromARGB(255, 108, 200, 177);
    const Color redCardColor = Color.fromARGB(255, 207, 118, 141);
    const Color puprleCardColor = Color.fromARGB(255, 64, 50, 97);
    const Color blueCardColor = Color.fromARGB(255, 62, 109, 150);

    return <String, Color>{
      'green': greenCardColor,
      'red': redCardColor,
      'purple': puprleCardColor,
      'blue': blueCardColor,
    }[color];
  }
}

abstract class TextColors {
  static const Color grey = Color.fromARGB(255, 94, 94, 94);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}
