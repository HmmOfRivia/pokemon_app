import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_api/pokemon_api.dart';
import 'package:pokemon_app/config/injection.dart';
import 'package:pokemon_app/pokemon_list_page/bloc/pokemon_list_bloc.dart';
import 'package:pokemon_app/pokemon_list_page/view/pokemon_list_page.dart';
import 'package:pokemon_app/pokemon_list_page/view/widgets/pokemon_list_tile.dart';
import 'package:pokemon_app/theme/bloc/theme_bloc.dart';
import 'package:pokemon_repository/pokemon_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/pump_app.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {}

class MockPokemonListBloc extends MockBloc<PokemonListEvent, PokemonListState>
    implements PokemonListBloc {}

class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState>
    implements ThemeBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PokemonListBloc pokemonListBloc;

  final pokemonsListMock = List.generate(
    10,
    (i) => Pokemon(name: 'name$i'),
  );

  setUp(() async {
    pokemonListBloc = MockPokemonListBloc();
    SharedPreferences.setMockInitialValues({});
    configureInjection('');
    await GetIt.I.allReady();
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group(
    'pokomon list view tests',
    () {
      testWidgets(
        'find tiles when state is loaded',
        (tester) async {
          when(() => pokemonListBloc.state).thenReturn(
            PokemonListLoaded(pokemons: pokemonsListMock),
          );

          await tester.pumpApp(
            BlocProvider(
              create: (_) => pokemonListBloc,
              child: const PokemonListView(),
            ),
          );

          expect(find.byType(PokemonListTile), findsWidgets);
        },
      );

      testWidgets(
        'finds only one tile when filtered pokemons has one element',
        (tester) async {
          when(() => pokemonListBloc.state).thenReturn(
            PokemonListLoaded(
              pokemons: pokemonsListMock,
              filteredPokemon: [pokemonsListMock.first],
            ),
          );

          await tester.pumpApp(
            BlocProvider(
              create: (_) => pokemonListBloc,
              child: const PokemonListView(),
            ),
          );

          expect(find.byType(PokemonListTile), findsOneWidget);
        },
      );

      testWidgets(
        'finds placeholder when no filter results',
        (tester) async {
          when(() => pokemonListBloc.state).thenReturn(
            PokemonListLoaded(
              pokemons: pokemonsListMock,
              noSearchResultsFound: true,
            ),
          );

          await tester.pumpApp(
            BlocProvider(
              create: (_) => pokemonListBloc,
              child: const PokemonListView(),
            ),
          );

          expect(find.text('No results found'), findsOneWidget);
        },
      );
    },
  );
}
