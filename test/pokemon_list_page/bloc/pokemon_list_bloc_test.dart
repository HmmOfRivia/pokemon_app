import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_api/pokemon_api.dart';
import 'package:pokemon_app/pokemon_list_page/bloc/pokemon_list_bloc.dart';
import 'package:pokemon_repository/pokemon_repository.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

void main() {
  late PokemonRepository pokemonRepository;

  setUp(() {
    pokemonRepository = MockPokemonRepository();
  });

  final pokemonsListMock = List.generate(
    10,
    (i) => Pokemon(name: 'name$i'),
  );

  group(
    'pokemonListBloc tests',
    () {
      test(
        'state is initial',
        () => expect(
          PokemonListBloc(pokemonRepository).state,
          equals(PokemonListInitial()),
        ),
      );

      blocTest<PokemonListBloc, PokemonListState>(
        'on loadPokemonsEvent emits loading and loaded state',
        build: () {
          when(() => pokemonRepository.getPokemons()).thenAnswer(
            (_) async => pokemonsListMock,
          );

          return PokemonListBloc(pokemonRepository);
        },
        act: (bloc) => bloc.add(LoadPokemons()),
        expect: () => [
          PokemonListLoading(),
          PokemonListLoaded(pokemons: pokemonsListMock),
        ],
      );

      blocTest<PokemonListBloc, PokemonListState>(
        'on SearchPokemonByName with exact pokemon name '
        'emits loaded state with filtered pokemons',
        build: () {
          return PokemonListBloc(pokemonRepository);
        },
        seed: () => PokemonListLoaded(pokemons: pokemonsListMock),
        act: (bloc) => bloc.add(const SearchPokemonByName(text: 'name1')),
        expect: () => [
          PokemonListLoaded(
            pokemons: pokemonsListMock,
            filteredPokemon: const [Pokemon(name: 'name1')],
          ),
        ],
      );

      blocTest<PokemonListBloc, PokemonListState>(
        'on SearchPokemonByName with no existing pokemon '
        'emits loaded state with no results found',
        build: () {
          return PokemonListBloc(pokemonRepository);
        },
        seed: () => PokemonListLoaded(pokemons: pokemonsListMock),
        act: (bloc) => bloc.add(const SearchPokemonByName(text: 'noExist')),
        expect: () => [
          PokemonListLoaded(
            pokemons: pokemonsListMock,
            noSearchResultsFound: true,
          ),
        ],
      );
    },
  );
}
