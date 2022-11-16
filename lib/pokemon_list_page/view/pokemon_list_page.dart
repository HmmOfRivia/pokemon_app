import 'package:app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/l10n/l10n.dart';
import 'package:pokemon_app/pokemon_favourites_list_page/pokemon_favourites_list_page.dart';
import 'package:pokemon_app/pokemon_list_page/bloc/pokemon_list_bloc.dart';
import 'package:pokemon_app/pokemon_list_page/view/widgets/pokemon_list_page_app_bar.dart';
import 'package:pokemon_app/pokemon_list_page/view/widgets/pokemon_list_tile.dart';
import 'package:pokemon_app/theme/view/app_theme_wrapper.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<PokemonListBloc>()..add(LoadPokemons()),
      child: const PokemonListView(),
    );
  }
}

class PokemonListView extends StatelessWidget {
  const PokemonListView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const PokemonListPageAppBar(),
          BlocBuilder<PokemonListBloc, PokemonListState>(
            builder: (context, state) {
              if (state is PokemonListLoaded) {
                if (state.noSearchResultsFound) {
                  return const _SliverPokemonListSearchNoResultsPlaceholder();
                }

                final pokemons = state.filteredPokemon.isNotEmpty
                    ? state.filteredPokemon
                    : state.pokemons;

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return PokemonListTile(
                        key: Key(pokemons[index].name),
                        name: pokemons[index].name,
                      );
                    },
                    childCount: pokemons.length,
                  ),
                );
              }

              if (state is PokemonListConnectionError) {
                return const _SliverPokemonListConnectionErrorPlaceholder();
              }

              if (state is PokemonListLoading) {
                return const _SliverListLoadingPlaceholder();
              }

              // TODO(fliszkiewicz): error placeholder

              return const SliverToBoxAdapter();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: [
            Text(l10n.myFavourites, style: theme.textStyle.chip),
            const SizedBox(width: AppDimensions.spacer1x),
            Icon(Icons.star, color: theme.colors.iconColor)
          ],
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<dynamic>(
              builder: (_) => const PokemonFavouritesListPage(),
            ),
          );
        },
      ),
    );
  }
}

class _SliverPokemonListSearchNoResultsPlaceholder extends StatelessWidget {
  const _SliverPokemonListSearchNoResultsPlaceholder();

  static const double iconSize = 50;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_dissatisfied_rounded,
              color: theme.textStyle.hint.color,
              size: iconSize,
            ),
            const SizedBox(height: AppDimensions.spacer4x),
            Text(
              l10n.noResultsFound,
              style: theme.textStyle.hint,
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverPokemonListConnectionErrorPlaceholder extends StatelessWidget {
  const _SliverPokemonListConnectionErrorPlaceholder();

  static const double iconSize = 50;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;

    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi,
              color: theme.textStyle.hint.color,
              size: iconSize,
            ),
            const SizedBox(height: AppDimensions.spacer4x),
            Text(
              l10n.noConnection,
              style: theme.textStyle.hint,
            ),
            const SizedBox(height: AppDimensions.spacer4x),
            MaterialButton(
              onPressed: () =>
                  context.read<PokemonListBloc>().add(LoadPokemons()),
              color: theme.colors.accentColor,
              child: Text(l10n.tryAgain),
            )
          ],
        ),
      ),
    );
  }
}

class _SliverListLoadingPlaceholder extends StatelessWidget {
  const _SliverListLoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const TileLoadingPlaceholder();
        },
        childCount: 5,
      ),
    );
  }
}
