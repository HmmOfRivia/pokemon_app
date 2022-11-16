import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:favourite_repository/favourite_repository.dart';
import 'package:pokemon_api/pokemon_api.dart';

part 'favourites_list_event.dart';
part 'favourites_list_state.dart';

class FavouritesListBloc
    extends Bloc<FavouritesListEvent, FavouritesListState> {
  FavouritesListBloc(this._favouriteRepository)
      : super(FavouritesListInitial()) {
    on<FavouritesListLoadEvent>(_onLoadFavouritesPokemons);
    on<FavouritesListReorderEvent>(_onFavouritesReorderable);
  }

  final FavouriteRepository _favouriteRepository;

  Future<void> _onLoadFavouritesPokemons(
    FavouritesListLoadEvent event,
    Emitter<FavouritesListState> emit,
  ) async {
    final pokemonNames = await _favouriteRepository.getFavouritesPokemons();

    final pokemons = pokemonNames.map((name) => Pokemon(name: name)).toList();

    emit(FavouritesListLoaded(favouritesPokemons: pokemons));
  }

  Future<void> _onFavouritesReorderable(
    FavouritesListReorderEvent event,
    Emitter<FavouritesListState> emit,
  ) async {
    final int newIndex;
    if (event.oldIndex < event.newIndex) {
      newIndex = event.newIndex - 1;
    } else {
      newIndex = event.newIndex;
    }
    final pokemonNames = await _favouriteRepository
        .reorderPokemonAndSaveInStorage(event.oldIndex, newIndex);

    final pokemons = pokemonNames.map((name) => Pokemon(name: name)).toList();

    emit(FavouritesListLoaded(favouritesPokemons: pokemons));
  }
}
