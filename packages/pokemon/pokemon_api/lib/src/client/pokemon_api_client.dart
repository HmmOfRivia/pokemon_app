import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_api/pokemon_api.dart';
import 'package:pokemon_api/src/models/pokemon_species.dart';

class PokemonApiClient {
  PokemonApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  /// This should be injected as enviromental variable during build
  /// Its visible only because it is public project
  static const String baseUrl = 'pokeapi.co';

  Future<List<Pokemon>> fetchAllPokemons() async {
    final uri = Uri.https(
      baseUrl,
      '/api/v2/pokemon',
      {'limit': '1500', 'offset': '0'},
    );
    final response = await _get(uri);

    try {
      return (response['results'] as List)
          .map(
            (dynamic item) => Pokemon.fromJson(item),
          )
          .toList();
    } catch (_) {
      throw JsonDeserializationException();
    }
  }

  Future<PokemonDetails> fetchPokemonDetails(String name) async {
    final uri = Uri.https(baseUrl, '/api/v2/pokemon/$name');
    final response = await _get(uri);

    try {
      return PokemonDetails.fromJson(response);
    } catch (_) {
      throw JsonDeserializationException();
    }
  }

  Future<PokemonSpeciesDetails> fetchPokemonSpecies(String uriSting) async {
    final uri = Uri.parse(uriSting);
    final response = await _get(uri);

    try {
      return PokemonSpeciesDetails.fromJson(response);
    } catch (_) {
      throw JsonDeserializationException();
    }
  }

  Future<Map<String, dynamic>> _get(Uri uri) async {
    http.Response response;

    try {
      response = await _httpClient.get(uri);
    } catch (_) {
      throw HttpException();
    }

    /// TODO(fliszkiewicz): more responses codes can be handled if needed
    if (response.statusCode != 200) {
      throw HttpRequestException(response.statusCode);
    }

    try {
      return json.decode(response.body) as Map<String, dynamic>;
    } catch (_) {
      throw JsonDecodeException();
    }
  }
}
