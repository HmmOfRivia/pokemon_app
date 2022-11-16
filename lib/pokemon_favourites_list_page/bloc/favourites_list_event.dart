part of 'favourites_list_bloc.dart';

abstract class FavouritesListEvent extends Equatable {
  const FavouritesListEvent();

  @override
  List<Object> get props => [];
}

class FavouritesListLoadEvent extends FavouritesListEvent {}

class FavouritesListReorderEvent extends FavouritesListEvent {
  const FavouritesListReorderEvent({
    required this.oldIndex,
    required this.newIndex,
  });

  final int oldIndex;

  final int newIndex;
}

class PokemonRemovedEvent extends FavouritesListEvent {
  const PokemonRemovedEvent({
    required this.name,
  });

  final String name;
}
