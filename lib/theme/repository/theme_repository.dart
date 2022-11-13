import 'package:app_theme/app_theme.dart';
import 'package:injectable/injectable.dart';
import 'package:persistent_storage/persistent_storage.dart';

@singleton
class ThemeRepository {
  ThemeRepository(this._storage);

  final PersistentStorage _storage;

  static const String _themeVariantKey = 'ThemeRepository_ThemeVariant';

  Future<void> saveThemeToStorage(AppTheme theme) async {
    if (theme.variant == AppThemeVariants.light) {
      await _storage.write(key: _themeVariantKey, value: theme.variant.name);
    } else if (theme.variant == AppThemeVariants.dark) {
      await _storage.write(key: _themeVariantKey, value: theme.variant.name);
    }
  }

  Future<AppTheme?> getThemeFromStorage() async {
    final themeString = await _storage.read(key: _themeVariantKey);

    if (themeString == null) return null;

    final variant = AppThemeVariants.values.byName(themeString);

    if (variant == AppThemeVariants.light) {
      return AppTheme.light();
    } else if (variant == AppThemeVariants.dark) {
      return AppTheme.dark();
    }
    return null;
  }
}
