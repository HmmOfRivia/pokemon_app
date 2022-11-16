import 'package:app_theme/app_theme.dart';
import 'package:favourite_repository/favourite_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/common/custom_app_bar.dart';
import 'package:pokemon_app/l10n/l10n.dart';
import 'package:pokemon_app/pokemon_favourites_list_page/bloc/favourites_list_bloc.dart';
import 'package:pokemon_app/pokemon_list_page/view/widgets/pokemon_list_tile.dart';
import 'package:pokemon_app/theme/view/app_theme_wrapper.dart';

class PokemonFavouritesListPage extends StatelessWidget {
  const PokemonFavouritesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => FavouritesListBloc(
          GetIt.I<FavouriteRepository>(),
        )..add(FavouritesListLoadEvent()),
        child: const PokemonFavouritesListView(),
      ),
    );
  }
}

class PokemonFavouritesListView extends StatelessWidget {
  const PokemonFavouritesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CustomAppBar(),
        BlocBuilder<FavouritesListBloc, FavouritesListState>(
          builder: (context, state) {
            if (state is FavouritesListLoaded) {
              if (state.favouritesPokemons.isEmpty) {
                return const _NoFavouritesPokemonsPlaceholder();
              }
              return Expanded(
                child: ReorderableListView(
                  padding: EdgeInsets.zero,
                  children: state.favouritesPokemons
                      .map(
                        (pokemon) => PokemonListTile(
                          key: Key(pokemon.name),
                          name: pokemon.name,
                        ),
                      )
                      .toList(),
                  onReorder: (oldIndex, newIndex) {
                    context.read<FavouritesListBloc>().add(
                          FavouritesListReorderEvent(
                            oldIndex: oldIndex,
                            newIndex: newIndex,
                          ),
                        );
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}

class _NoFavouritesPokemonsPlaceholder extends StatelessWidget {
  const _NoFavouritesPokemonsPlaceholder();

  static const double iconSize = 50;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;

    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.preview,
              color: theme.textStyle.hint.color,
              size: iconSize,
            ),
            const SizedBox(height: AppDimensions.spacer4x),
            Text(
              l10n.addFirstPokemon,
              style: theme.textStyle.hint,
            ),
          ],
        ),
      ),
    );
  }
}
