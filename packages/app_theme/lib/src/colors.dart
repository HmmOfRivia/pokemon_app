import 'package:flutter/material.dart';

class AppColors {
  AppColors({
    required this.accentColor,
    required this.backgroundColor,
    required this.iconColor,
    required this.dividerColor,
    required this.placeholderColor,
    required this.textInputColor,
  });

  factory AppColors.light() {
    return AppColors(
      accentColor: Color.fromARGB(255, 129, 166, 190),
      backgroundColor: Colors.white,
      iconColor: Colors.white,
      dividerColor: Color.fromARGB(255, 129, 166, 190),
      placeholderColor: Color.fromARGB(255, 230, 230, 230),
      textInputColor: Colors.white,
    );
  }

  factory AppColors.dark() {
    return AppColors(
      accentColor: Color.fromARGB(255, 129, 166, 190),
      backgroundColor: Color.fromARGB(255, 54, 54, 54),
      iconColor: Colors.white,
      dividerColor: Color.fromARGB(255, 170, 175, 178),
      placeholderColor: Color.fromARGB(255, 76, 76, 77),
      textInputColor: Color.fromARGB(255, 59, 59, 59),
    );
  }

  final Color accentColor;

  final Color backgroundColor;

  final Color iconColor;

  final Color dividerColor;

  final Color placeholderColor;

  final Color textInputColor;

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

  static Color getCardColor(String color) {
    // TODO(fliszkiewicz): Match colors with API values
    const Color greenCardColor = Color.fromARGB(255, 108, 200, 177);
    const Color redCardColor = Color.fromARGB(255, 207, 118, 141);
    const Color puprleCardColor = Color.fromARGB(255, 64, 50, 97);
    const Color blueCardColor = Color.fromARGB(255, 62, 109, 150);
    const Color brownCardColor = Color.fromARGB(255, 92, 77, 62);
    const Color yellowCardColor = Color.fromARGB(255, 233, 148, 58);
    const Color pinkCardColor = Color.fromARGB(255, 255, 149, 243);

    const Color unknownCardColor = Colors.black12;

    final cardColor = <String, Color>{
      'green': greenCardColor,
      'red': redCardColor,
      'purple': puprleCardColor,
      'blue': blueCardColor,
      'brown': brownCardColor,
      'yellow': yellowCardColor,
      'pink': pinkCardColor,
    }[color];

    return cardColor ?? unknownCardColor;
  }
}

abstract class TextColors {
  static const Color grey = Color.fromARGB(255, 166, 166, 166);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}
