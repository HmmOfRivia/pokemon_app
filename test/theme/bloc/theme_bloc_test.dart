import 'package:app_theme/app_theme.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:pokemon_app/theme/bloc/theme_bloc.dart';
import 'package:pokemon_app/theme/repository/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockThemeRepository extends Mock implements ThemeRepository {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences sharedPreferences;
  late PersistentStorage persistentStorage;
  late ThemeRepository themeRepository;

  const themeVariantKey = 'ThemeRepository_ThemeVariant';
  const darkThemeString = 'dark';

  setUp(() async {
    SharedPreferences.setMockInitialValues({themeVariantKey: darkThemeString});

    sharedPreferences = await SharedPreferences.getInstance();
    persistentStorage = PersistentStorage(sharedPreferences: sharedPreferences);
    themeRepository = ThemeRepository(persistentStorage);
  });

  group(
    'themeBloc test',
    () {
      test(
        'initial state is light',
        () async => {
          expect(
            ThemeBloc(themeRepository).state,
            equals(ThemeState(appTheme: AppTheme.light())),
          )
        },
      );

      blocTest<ThemeBloc, ThemeState>(
        'changes state from light to dark on event',
        build: () {
          sharedPreferences.setString(themeVariantKey, darkThemeString);

          return ThemeBloc(themeRepository);
        },
        act: (bloc) => bloc.add(
          ThemeChanged(appTheme: AppTheme.dark()),
        ),
        expect: () => [ThemeState(appTheme: AppTheme.dark())],
      );

      blocTest<ThemeBloc, ThemeState>(
        'get saved theme from shared prefs and emit proper state',
        build: () {
          sharedPreferences.getString(themeVariantKey);

          return ThemeBloc(themeRepository);
        },
        act: (bloc) => bloc.add(ThemeLoad()),
        expect: () => [
          ThemeState(appTheme: AppTheme.dark()),
        ],
      );
    },
  );
}
