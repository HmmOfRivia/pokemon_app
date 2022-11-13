import 'package:pokemon_api/pokemon_api.dart';

class PokemonRepository {
  PokemonRepository({PokemonApiClient? client})
      : _client = client ?? PokemonApiClient();

  final PokemonApiClient _client;

  Future<List<Pokemon>> getPokemons() async {
    return await _client.fetchAllPokemons();
  }

  Future<PokemonDetails> getPokemonDetails(String name) async {
    return await _client.fetchPokemonDetails(name);
  }

  Future<PokemonSpeciesDetails> getPokemonSpecies(String url) async {
    return await _client.fetchPokemonSpecies(url);
  }
}
