part of 'pokemon_list_tile_bloc.dart';

abstract class PokemonListTileState extends Equatable {
  const PokemonListTileState();

  @override
  List<Object> get props => [];
}

class PokemonListTileInitial extends PokemonListTileState {}

class PokemonListTileLoading extends PokemonListTileState {}

class PokemonListTileError extends PokemonListTileState {}

class PokemonListTileLoaded extends PokemonListTileState {
  const PokemonListTileLoaded({
    required this.pokemonDetails,
  });

  final PokemonDetails pokemonDetails;

  @override
  List<Object> get props => [pokemonDetails];
}