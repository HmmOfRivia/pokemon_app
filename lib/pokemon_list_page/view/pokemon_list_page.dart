import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/pokemon_list_page/bloc/pokemon_list_bloc.dart';
import 'package:pokemon_app/pokemon_list_page/view/widgets/pokemon_list_page_app_bar.dart';
import 'package:pokemon_app/pokemon_list_page/view/widgets/pokemon_list_tile.dart';

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
    return CustomScrollView(
      slivers: <Widget>[
        const PokemonListPageAppBar(),
        BlocBuilder<PokemonListBloc, PokemonListState>(
          builder: (context, state) {
            if (state is PokemonListLoaded) {
              if (state.noSearchResultsFound) {
                // TODO(fliszkiewicz): add placeholder if no search results
                return const SliverToBoxAdapter();
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

            // TODO(fliszkiewicz): no connection placeholder
            // TODO(fliszkiewicz): error placeholder
            // TODO(fliszkiewicz): loading placeholder

            return const SliverToBoxAdapter();
          },
        )
      ],
    );
  }
}
