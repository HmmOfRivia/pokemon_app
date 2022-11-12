import 'package:app_theme/app_theme.dart';
import 'package:flutter/material.dart';

extension AppThemeX on BuildContext {
  AppTheme get theme => AppThemeWrapper.of(this);
}

class AppThemeWrapper extends InheritedWidget {
  const AppThemeWrapper({
    super.key,
    required this.data,
    required super.child,
  });

  final AppTheme data;

  @override
  bool updateShouldNotify(covariant AppThemeWrapper oldWidget) {
    return data != oldWidget.data;
  }

  static AppTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppThemeWrapper>()!.data;
}
