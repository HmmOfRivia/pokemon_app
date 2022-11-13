import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon_api/src/models/pokemon_species.dart';
import 'package:pokemon_api/src/models/pokemon_stats.dart';
import 'package:pokemon_api/src/models/pokemon_type.dart';

part 'pokemon_details.g.dart';

@JsonSerializable()
class PokemonDetails extends Equatable {
  final int weight;

  @JsonKey(name: 'base_experience')
  final int baseExperience;

  @JsonKey(name: 'sprites', fromJson: _decodeSprite, toJson: _encodeSprite)
  final String sprite;

  final List<PokemonStats> stats;

  @JsonKey(fromJson: _decodeType, toJson: _encodeType)
  final List<PokemonType> types;

  final PokemonSpecies species;

  const PokemonDetails({
    required this.weight,
    required this.baseExperience,
    required this.sprite,
    required this.stats,
    required this.types,
    required this.species,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDetailsToJson(this);

  static String _decodeSprite(Map input) {
    return input['other']['home']['front_default'];
  }

  static Map<String, dynamic> _encodeSprite(String input) {
    return <String, dynamic>{
      'other': {
        'home': {
          'front_default': input,
        }
      }
    };
  }

  static List<PokemonType> _decodeType(List input) {
    return input.map((type) => PokemonType.fromJson(type['type'])).toList();
  }

  static List<Map<String, dynamic>> _encodeType(List<PokemonType> input) {
    List<Map<String, dynamic>> typesList = [];
    for (final type in input) {
      typesList.add({
        'type': {'name': type.name}
      });
    }

    return typesList;
  }

  @override
  List<Object?> get props => [weight, baseExperience, sprite, types, species];

  PokemonDetails copyWith({
    int? weight,
    int? baseExperience,
    String? sprite,
    List<PokemonStats>? stats,
    List<PokemonType>? types,
    PokemonSpecies? species,
  }) {
    return PokemonDetails(
      weight: weight ?? this.weight,
      baseExperience: baseExperience ?? this.baseExperience,
      sprite: sprite ?? this.sprite,
      stats: stats ?? this.stats,
      types: types ?? this.types,
      species: species ?? this.species,
    );
  }
}
