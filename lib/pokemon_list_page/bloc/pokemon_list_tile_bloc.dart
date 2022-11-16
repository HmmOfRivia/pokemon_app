import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:favourite_repository/favourite_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:pokemon_api/pokemon_api.dart';
import 'package:pokemon_repository/pokemon_repository.dart';

part 'pokemon_list_tile_event.dart';
part 'pokemon_list_tile_state.dart';

@singleton
class PokemonListTileBloc
    extends Bloc<PokemonListTileEvent, PokemonListTileState> {
  PokemonListTileBloc(
    this._repository,
    this._favouriteRepository,
  ) : super(PokemonListTileInitial()) {
    on<LoadDetailsEvent>(_onLoadPokemon);
    on<PokemonChangeFavouriteEvent>(_onChangeFavourite);
    on<RemovedFromMemoryEvent>(_onRemovedFromMemory);

    removedFromFavStream =
        _favouriteRepository.removePokemonStream.stream.listen((name) async {
      add(RemovedFromMemoryEvent(name: name));
    });
  }
  final PokemonRepository _repository;

  final FavouriteRepository _favouriteRepository;

  late StreamSubscription<String> removedFromFavStream;

  Future<void> _onLoadPokemon(
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
        species: pokemonDetails.species.copyWith(
          details: pokemonSpeciesDetails,
        ),
      );

      final isFavourite = await _favouriteRepository.isPokemonFavourite(
        event.name,
      );

      emit(
        PokemonListTileLoaded(
          pokemonDetails: updatedDetails,
          name: event.name,
          isFavourite: isFavourite,
        ),
      );
    } catch (error, stackTrace) {
      emit(PokemonListTileError());
      onError(error, stackTrace);
    }
  }

  Future<void> _onChangeFavourite(
    PokemonChangeFavouriteEvent event,
    Emitter<PokemonListTileState> emit,
  ) async {
    if (state is PokemonListTileLoaded) {
      emit(
        (state as PokemonListTileLoaded)
            .copyWith(isFavourite: event.isFavourite),
      );

      event.isFavourite
          ? await _favouriteRepository.writeFavouriteToStorage(
              (state as PokemonListTileLoaded).name,
            )
          : await _favouriteRepository.removeFavouriteFromStorage(
              (state as PokemonListTileLoaded).name,
            );

      // TODO(fliszkiewicz): catch exceptions and emit state
      // based on memory if write action fails
    }
  }

  Future<void> _onRemovedFromMemory(
    RemovedFromMemoryEvent event,
    Emitter<PokemonListTileState> emit,
  ) async {
    final isFavourite =
        await _favouriteRepository.isPokemonFavourite(event.name);
    if (state is PokemonListTileLoaded) {
      if ((state as PokemonListTileLoaded).name == event.name) {
        emit(
          (state as PokemonListTileLoaded).copyWith(isFavourite: isFavourite),
        );
      }
    }
  }

  @override
  Future<void> close() {
    removedFromFavStream.cancel();
    return super.close();
  }
}
