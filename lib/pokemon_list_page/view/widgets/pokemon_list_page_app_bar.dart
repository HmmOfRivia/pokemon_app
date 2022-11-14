import 'package:app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/l10n/l10n.dart';
import 'package:pokemon_app/pokemon_list_page/bloc/pokemon_list_bloc.dart';
import 'package:pokemon_app/theme/view/app_theme_wrapper.dart';

class PokemonListPageAppBar extends StatelessWidget {
  const PokemonListPageAppBar({super.key});

  static const double expandedHeight = 150;
  static const double toolbarHeight = 77;
  static const double searchBarHeight = 45;

  @override
  Widget build(BuildContext context) {
    final themeColors = context.theme.colors;
    final themeStyles = context.theme.textStyle;
    final l10n = context.l10n;

    return SliverAppBar(
      pinned: true,
      expandedHeight: expandedHeight,
      toolbarHeight: toolbarHeight,
      backgroundColor: themeColors.accentColor,
      titleSpacing: 20,
      title: Text(
        l10n.homeTitle,
        style: themeStyles.homeTitle,
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
                hintStyle: themeStyles.hint,
                prefixIcon: Icon(
                  Icons.search,
                  color: themeStyles.hint.color,
                ),
              ),
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
