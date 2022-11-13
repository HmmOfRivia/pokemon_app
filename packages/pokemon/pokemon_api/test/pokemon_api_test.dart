import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_api/pokemon_api.dart';
import 'package:pokemon_api/src/models/pokemon_species.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client httpClient;
  late PokemonApiClient client;

  late Uri pokemonUri;
  late Uri pokemonDetailsUri;

  const pokemonDetails = PokemonDetails(
    weight: 40,
    baseExperience: 100,
    sprite:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iii/ruby-sapphire/back/132.png',
    stats: [PokemonStats(value: 40, effort: 0, name: 'hp')],
    types: [PokemonType(name: 'ground')],
    species:
        PokemonSpecies(url: 'https://pokeapi.co/api/v2/pokemon-species/132/'),
  );

  setUp(() {
    httpClient = MockHttpClient();
    client = PokemonApiClient(httpClient: httpClient);
    pokemonUri = Uri.https(
      PokemonApiClient.baseUrl,
      '/api/v2/pokemon',
      {'limit': '1500', 'offset': '0'},
    );
    pokemonDetailsUri = Uri.https(
      PokemonApiClient.baseUrl,
      '/api/v2/pokemon/ditto',
    );
  });

  group(
    'pokemon client request tests',
    () {
      test(
        'request is called once',
        () async {
          when(() => httpClient.get(pokemonDetailsUri)).thenAnswer(
            (_) async => http.Response(json.encode(pokemonDetails), 200),
          );

          await client.fetchPokemonDetails('ditto');

          verify(
            () => httpClient.get(pokemonDetailsUri),
          ).called(1);
        },
      );

      test(
        'client return correct pokemon details object',
        () async {
          when(() => httpClient.get(pokemonDetailsUri)).thenAnswer(
            (_) async => http.Response(json.encode(pokemonDetails), 200),
          );

          expect(
            client.fetchPokemonDetails('ditto'),
            completion(equals(pokemonDetails)),
          );
        },
      );

      test(
        'throws HttpRequestException when code is not 200',
        () {
          when(() => httpClient.get(pokemonUri)).thenAnswer(
            (_) async => http.Response('', 404),
          );

          expect(
            () => client.fetchAllPokemons(),
            throwsA(
              isA<HttpRequestException>()
                  .having((error) => error.statusCode, 'statusCode', 404),
            ),
          );
        },
      );

      test(
        'throws HttpRequestException when response status code is not 200',
        () {
          when(() => httpClient.get(pokemonUri)).thenAnswer(
            (_) async => http.Response('', 404),
          );

          expect(
            () => client.fetchAllPokemons(),
            throwsA(
              isA<HttpRequestException>()
                  .having((error) => error.statusCode, 'statusCode', 404),
            ),
          );
        },
      );

      test('throws HttpException when client throws exception', () {
        when(() => httpClient.get(pokemonUri)).thenThrow(Exception());

        expect(
          () => client.fetchAllPokemons(),
          throwsA(isA<HttpException>()),
        );
      });
    },
  );
}
