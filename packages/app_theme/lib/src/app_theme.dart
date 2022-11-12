import 'package:app_theme/app_theme.dart';
import 'package:flutter/material.dart';

enum AppThemeVariants { light, dark }

class AppTheme {
  AppTheme({
    required this.variant,
    required this.colors,
    required this.textStyle,
    required this.brightness,
  });

  factory AppTheme.light() {
    return AppTheme(
      variant: AppThemeVariants.light,
      colors: AppColors.light(),
      textStyle: AppTextStyle.light(),
      brightness: Brightness.light,
    );
  }

  factory AppTheme.dark() {
    return AppTheme(
      variant: AppThemeVariants.dark,
      colors: AppColors.dark(),
      textStyle: AppTextStyle.light(),
      brightness: Brightness.dark,
    );
  }

  final AppThemeVariants variant;

  final AppColors colors;

  final AppTextStyle textStyle;

  final Brightness brightness;

  ThemeData get themeDataLight {
    final colors = AppColors.light();

    return ThemeData(
      primaryColor: colors.accentColor,
      indicatorColor: colors.accentColor,
      backgroundColor: colors.backgroundColor,
      scaffoldBackgroundColor: colors.backgroundColor,
      dialogTheme: _getDialogTheme(colors),
      iconTheme: _getIconTheme(colors),
      dividerTheme: _dividerTheme(colors),
      textTheme: _textTheme,
      inputDecorationTheme: _getInputDecorationTheme(colors),
      buttonTheme: _buttonTheme,
      snackBarTheme: _getSnackBarTheme(colors),
      elevatedButtonTheme: _elevatedButtonTheme,
      textButtonTheme: _textButtonTheme,
      colorScheme: colors.scheme,
      canvasColor: colors.backgroundColor,
      dialogBackgroundColor: colors.backgroundColor,
    );
  }

  ThemeData get themeDataDark {
    final colors = AppColors.dark();

    return ThemeData(
      primaryColor: colors.accentColor,
      indicatorColor: colors.accentColor,
      backgroundColor: colors.backgroundColor,
      scaffoldBackgroundColor: colors.backgroundColor,
      dialogTheme: _getDialogTheme(colors),
      iconTheme: _getIconTheme(colors),
      dividerTheme: _dividerTheme(colors),
      textTheme: _textTheme,
      inputDecorationTheme: _getInputDecorationTheme(colors),
      buttonTheme: _buttonTheme,
      snackBarTheme: _getSnackBarTheme(colors),
      elevatedButtonTheme: _elevatedButtonTheme,
      textButtonTheme: _textButtonTheme,
      colorScheme: colors.scheme,
      canvasColor: colors.backgroundColor,
      dialogBackgroundColor: colors.backgroundColor,
    );
  }

  SnackBarThemeData _getSnackBarTheme(AppColors colors) {
    return SnackBarThemeData(
      shape: RoundedRectangleBorder(),
      backgroundColor: colors.accentColor,
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
    );
  }

  DialogTheme _getDialogTheme(AppColors colors) {
    return DialogTheme(
      backgroundColor: colors.backgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius1x),
      ),
    );
  }

  IconThemeData _getIconTheme(AppColors colors) {
    return IconThemeData(
      color: colors.iconColor,
    );
  }

  DividerThemeData _dividerTheme(AppColors colors) {
    return DividerThemeData(
      color: colors.dividerColor,
      space: 1,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    );
  }

  TextTheme get _textTheme {
    return const TextTheme(
      headline1: AppTextStyle.headline1,
      headline2: AppTextStyle.headline2,
      headline3: AppTextStyle.headline3,
      subtitle1: AppTextStyle.subtitle1,
      subtitle2: AppTextStyle.subtitle2,
      bodyText1: AppTextStyle.bodyText1,
      bodyText2: AppTextStyle.bodyText2,
      button: AppTextStyle.buttonText,
    );
  }

  InputDecorationTheme _getInputDecorationTheme(AppColors colors) {
    return InputDecorationTheme(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppDimensions.space2x,
        vertical: AppDimensions.spacer4x,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.accentColor,
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.accentColor,
          width: 1.2,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.accentColor,
          width: 1.2,
        ),
      ),
    );
  }

  ButtonThemeData get _buttonTheme {
    return ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius1x),
      ),
    );
  }

  ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(AppDimensions.borderRadius1x)),
        ),
        padding: const EdgeInsets.all(AppDimensions.spacer4x),
        textStyle: _textTheme.button,
      ),
    );
  }

  TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: _textTheme.button?.copyWith(
          fontWeight: AppFontWeight.light,
        ),
      ),
    );
  }
}
