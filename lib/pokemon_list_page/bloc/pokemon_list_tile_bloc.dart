import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pokemon_api/pokemon_api.dart';
import 'package:pokemon_repository/pokemon_repository.dart';

part 'pokemon_list_tile_event.dart';
part 'pokemon_list_tile_state.dart';

@singleton
class PokemonListTileBloc
    extends Bloc<PokemonListTileEvent, PokemonListTileState> {
  PokemonListTileBloc(this._repository) : super(PokemonListTileInitial()) {
    on<LoadDetailsEvent>(_onLoadPokemons);
  }
  final PokemonRepository _repository;

  Future<void> _onLoadPokemons(
    LoadDetailsEvent event,
    Emitter<PokemonListTileState> emit,
  ) async {
    emit(PokemonListTileLoading());

    try {
      final pokemonDetails = await _repository.getPokemonDetails(event.name);

      final pokemonSpeciesDetails = await _repository.getPokemonSpecies(
        pokemonDetails.species.url,
      );

      final updatedDetails = pokemonDetails.copyWith(
        species:
            pokemonDetails.species.copyWith(details: pokemonSpeciesDetails),
      );

      emit(
        PokemonListTileLoaded(pokemonDetails: updatedDetails, name: event.name),
      );
    } catch (error, stackTrace) {
      emit(PokemonListTileError());
      onError(error, stackTrace);
    }
  }
}
