import 'package:app_theme/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_app/theme/bloc/theme_bloc.dart';

void main() {
  group('ThemeState ', () {
    test('supports value comparison', () {
      expect(
        ThemeState(appTheme: AppTheme.light()),
        ThemeState(appTheme: AppTheme.light()),
      );
    });
  });
}
