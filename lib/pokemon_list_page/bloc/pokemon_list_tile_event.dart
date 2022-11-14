part of 'pokemon_list_tile_bloc.dart';

abstract class PokemonListTileEvent {
  const PokemonListTileEvent();
}

class LoadDetailsEvent extends PokemonListTileEvent {
  const LoadDetailsEvent(this.name);
  final String name;
}
