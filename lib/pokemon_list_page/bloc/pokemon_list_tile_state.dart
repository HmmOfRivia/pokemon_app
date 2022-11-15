// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    required this.name,
    required this.pokemonDetails,
    this.isFavourite = false,
  });

  final String name;

  final PokemonDetails pokemonDetails;

  final bool isFavourite;

  @override
  List<Object> get props => [name, pokemonDetails, isFavourite];

  PokemonListTileLoaded copyWith({
    String? name,
    PokemonDetails? pokemonDetails,
    bool? isFavourite,
  }) {
    return PokemonListTileLoaded(
      name: name ?? this.name,
      pokemonDetails: pokemonDetails ?? this.pokemonDetails,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
