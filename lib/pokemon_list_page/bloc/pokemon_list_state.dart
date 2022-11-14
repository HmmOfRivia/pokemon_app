// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_list_bloc.dart';

abstract class PokemonListState extends Equatable {
  const PokemonListState();

  @override
  List<Object> get props => [];
}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {}

class PokemonListError extends PokemonListState {}

class PokemonListLoaded extends PokemonListState {
  final List<Pokemon> pokemons;
  final List<Pokemon> filteredPokemon;
  final bool noSearchResultsFound;

  const PokemonListLoaded({
    required this.pokemons,
    this.filteredPokemon = const [],
    this.noSearchResultsFound = false,
  });

  @override
  List<Object> get props => [pokemons, filteredPokemon, noSearchResultsFound];

  PokemonListLoaded copyWith({
    List<Pokemon>? pokemons,
    List<Pokemon>? filteredPokemon,
    bool? noSearchResultsFound,
  }) {
    return PokemonListLoaded(
      pokemons: pokemons ?? this.pokemons,
      filteredPokemon: filteredPokemon ?? this.filteredPokemon,
      noSearchResultsFound: noSearchResultsFound ?? this.noSearchResultsFound,
    );
  }
}
