// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_list_bloc.dart';

abstract class PokemonListEvent extends Equatable {
  const PokemonListEvent();

  @override
  List<Object> get props => [];
}

class LoadPokemons extends PokemonListEvent {}

class SearchPokemonByName extends PokemonListEvent {
  final String text;

  const SearchPokemonByName({
    required this.text,
  });

  @override
  List<Object> get props => [text];
}
