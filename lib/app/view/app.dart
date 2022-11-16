import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/l10n/l10n.dart';
import 'package:pokemon_app/pokemon_list_page/view/pokemon_list_page.dart';
import 'package:pokemon_app/theme/bloc/theme_bloc.dart';
import 'package:pokemon_app/theme/view/app_theme_wrapper.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ThemeBloc>()..add(ThemeLoad()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return AppThemeWrapper(
            data: state.appTheme,
            child: MaterialApp(
              theme: state.appTheme.theme,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const PokemonListPage(),
            ),
          );
        },
      ),
    );
  }
}
