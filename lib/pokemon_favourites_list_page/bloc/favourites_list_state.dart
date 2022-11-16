part of 'favourites_list_bloc.dart';

abstract class FavouritesListState extends Equatable {
  const FavouritesListState();

  @override
  List<Object> get props => [];
}

class FavouritesListInitial extends FavouritesListState {}

class FavouritesListLoaded extends FavouritesListState {
  const FavouritesListLoaded({
    required this.favouritesPokemons,
  });

  final List<Pokemon> favouritesPokemons;

  @override
  List<Object> get props => favouritesPokemons;
}
