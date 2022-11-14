import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pokemon_api/pokemon_api.dart';
import 'package:pokemon_repository/pokemon_repository.dart';

part 'pokemon_list_event.dart';
part 'pokemon_list_state.dart';

@lazySingleton
class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  PokemonListBloc(this._repository) : super(PokemonListInitial()) {
    on<SearchPokemonByName>(_onPokemonSearch);
    on<LoadPokemons>(_onLoadPokemons);
  }

  final PokemonRepository _repository;

  void _onPokemonSearch(
    SearchPokemonByName event,
    Emitter<PokemonListState> emit,
  ) {
    if (state is PokemonListLoaded) {
      final filteredPokemon = <Pokemon>[];

      for (final pokemon in (state as PokemonListLoaded).pokemons) {
        if (pokemon.name.contains(event.text)) {
          filteredPokemon.add(pokemon);
        }
      }

      if (event.text.isNotEmpty && filteredPokemon.isEmpty) {
        emit(
          (state as PokemonListLoaded).copyWith(
            noSearchResultsFound: true,
          ),
        );
      } else {
        emit(
          (state as PokemonListLoaded).copyWith(
            filteredPokemon: filteredPokemon,
            noSearchResultsFound: false,
          ),
        );
      }
    }
  }

  Future<void> _onLoadPokemons(
    LoadPokemons event,
    Emitter<PokemonListState> emit,
  ) async {
    emit(PokemonListLoading());
    try {
      final pokemons = await _repository.getPokemons();
      emit(PokemonListLoaded(pokemons: pokemons));
    } catch (error, stackTrace) {
      emit(PokemonListError());
      onError(error, stackTrace);
    }
  }
}
