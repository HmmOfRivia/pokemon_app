import 'package:app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/l10n/l10n.dart';
import 'package:pokemon_app/pokemon_list_page/bloc/pokemon_list_bloc.dart';
import 'package:pokemon_app/pokemon_list_page/view/widgets/theme_switcher_button.dart';
import 'package:pokemon_app/theme/view/app_theme_wrapper.dart';

class PokemonListPageAppBar extends StatelessWidget {
  const PokemonListPageAppBar({super.key});

  static const double expandedHeight = 150;
  static const double toolbarHeight = 77;
  static const double searchBarHeight = 45;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final l10n = context.l10n;

    return SliverAppBar(
      pinned: true,
      expandedHeight: expandedHeight,
      toolbarHeight: toolbarHeight,
      backgroundColor: theme.colors.accentColor,
      titleSpacing: 20,
      title: Row(
        children: [
          Text(
            l10n.homeTitle,
            style: theme.textStyle.homeTitle,
          ),
          const Spacer(),
          ThemeSwitcherButton(
            isLightTheme: theme.variant == AppThemeVariants.light,
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppDimensions.borderRadius2x),
          bottomRight: Radius.circular(AppDimensions.borderRadius2x),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacer4x),
          child: SizedBox(
            height: searchBarHeight,
            child: TextField(
              decoration: const InputDecoration().copyWith(
                hintText: l10n.searchPokemonHint,
                hintStyle: theme.textStyle.hint,
                prefixIcon: Icon(
                  Icons.search,
                  color: theme.textStyle.hint.color,
                ),
              ),
              style: theme.textStyle.inputText,
              onChanged: (value) => context
                  .read<PokemonListBloc>()
                  .add(SearchPokemonByName(text: value)),
            ),
          ),
        ),
      ),
    );
  }
}
