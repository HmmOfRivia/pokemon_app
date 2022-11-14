import 'package:app_theme/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AppThemeVariants { light, dark }

class AppTheme extends Equatable {
  AppTheme({
    required this.variant,
    required this.colors,
    required this.textStyle,
    required this.theme,
    required this.brightness,
  });

  factory AppTheme.light() {
    return AppTheme(
      variant: AppThemeVariants.light,
      colors: AppColors.light(),
      textStyle: AppTextStyle.light(),
      theme: AppThemeData.themeDataLight,
      brightness: Brightness.light,
    );
  }

  factory AppTheme.dark() {
    return AppTheme(
      variant: AppThemeVariants.dark,
      colors: AppColors.dark(),
      textStyle: AppTextStyle.dark(),
      theme: AppThemeData.themeDataDark,
      brightness: Brightness.dark,
    );
  }

  final AppThemeVariants variant;

  final AppColors colors;

  final AppTextStyle textStyle;

  final ThemeData theme;

  final Brightness brightness;

  @override
  List<Object?> get props => [variant];
}

class AppThemeData {
  static ThemeData get themeDataLight {
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

  static ThemeData get themeDataDark {
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

  static SnackBarThemeData _getSnackBarTheme(AppColors colors) {
    return SnackBarThemeData(
      shape: RoundedRectangleBorder(),
      backgroundColor: colors.accentColor,
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
    );
  }

  static DialogTheme _getDialogTheme(AppColors colors) {
    return DialogTheme(
      backgroundColor: colors.backgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius1x),
      ),
    );
  }

  static IconThemeData _getIconTheme(AppColors colors) {
    return IconThemeData(
      color: colors.iconColor,
    );
  }

  static DividerThemeData _dividerTheme(AppColors colors) {
    return DividerThemeData(
      color: colors.dividerColor,
      space: 1,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    );
  }

  static TextTheme get _textTheme {
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

  static InputDecorationTheme _getInputDecorationTheme(AppColors colors) {
    return InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spacer2x,
        vertical: AppDimensions.spacer4x,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.accentColor,
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius2x),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.accentColor,
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius2x),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.accentColor,
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius2x),
      ),
    );
  }

  static ButtonThemeData get _buttonTheme {
    return ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius1x),
      ),
    );
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
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

  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: _textTheme.button?.copyWith(
          fontWeight: AppFontWeight.light,
        ),
      ),
    );
  }
}
