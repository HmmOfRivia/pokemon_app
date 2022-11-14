// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_theme/app_theme.dart';
import 'package:flutter/material.dart';

abstract class AppFontWeight {
  static const FontWeight bold = FontWeight.w700;

  static const FontWeight medium = FontWeight.w500;

  static const FontWeight regular = FontWeight.w400;

  static const FontWeight light = FontWeight.w300;
}

class AppTextStyle {
  factory AppTextStyle.light() {
    return AppTextStyle(
      homeTitle: headline1.copyWith(color: TextColors.white),
      cardTitle: headline3.copyWith(color: TextColors.white),
      cardNumber: subtitle1.copyWith(color: TextColors.white),
      chip: bodyText2.copyWith(color: TextColors.white),
      inputText: bodyText1.copyWith(color: TextColors.black),
      detailTitle: headline2.copyWith(color: TextColors.white),
      statsRow: bodyText1.copyWith(color: TextColors.grey),
      tab: subtitle2.copyWith(color: TextColors.grey),
      hint: bodyText1.copyWith(color: TextColors.grey),
    );
  }

  factory AppTextStyle.dark() {
    return AppTextStyle(
      homeTitle: headline1.copyWith(color: TextColors.white),
      cardTitle: headline3.copyWith(color: TextColors.white),
      cardNumber: subtitle1.copyWith(color: TextColors.white),
      chip: bodyText2.copyWith(color: TextColors.white),
      inputText: bodyText1.copyWith(color: TextColors.white),
      detailTitle: headline2.copyWith(color: TextColors.white),
      statsRow: bodyText1.copyWith(color: TextColors.grey),
      tab: subtitle2.copyWith(color: TextColors.grey),
      hint: bodyText1.copyWith(color: TextColors.grey),
    );
  }

  /// Home page text styles
  final TextStyle homeTitle;

  final TextStyle cardTitle;

  final TextStyle cardNumber;

  final TextStyle chip;

  final TextStyle inputText;

  /// Detail page text styles
  final TextStyle detailTitle;

  final TextStyle statsRow;

  final TextStyle tab;

  /// Common text styles
  final TextStyle hint;

  AppTextStyle({
    required this.homeTitle,
    required this.cardTitle,
    required this.cardNumber,
    required this.chip,
    required this.inputText,
    required this.detailTitle,
    required this.statsRow,
    required this.tab,
    required this.hint,
  });

  /// Default theme text styles
  static const headline1 = TextStyle(
    fontSize: 32,
    fontWeight: AppFontWeight.bold,
    height: 1.25,
  );

  static const headline2 = TextStyle(
    fontSize: 24,
    fontWeight: AppFontWeight.medium,
    height: 1.25,
  );

  static const headline3 = TextStyle(
    fontSize: 20,
    fontWeight: AppFontWeight.medium,
    height: 1.25,
  );

  static const subtitle1 = TextStyle(
    fontSize: 18,
    fontWeight: AppFontWeight.medium,
    height: 1.25,
  );

  static const subtitle2 = TextStyle(
    fontSize: 16,
    fontWeight: AppFontWeight.medium,
    height: 1.25,
  );

  static const hintText = TextStyle(
    fontSize: 14,
    fontWeight: AppFontWeight.regular,
    color: TextColors.grey,
  );

  static const bodyText1 = TextStyle(
    fontSize: 16,
  );

  static const bodyText2 = TextStyle(
    fontSize: 14,
  );

  static const buttonText = TextStyle(
    fontSize: 18,
    fontWeight: AppFontWeight.medium,
    letterSpacing: 1.25,
  );
}
