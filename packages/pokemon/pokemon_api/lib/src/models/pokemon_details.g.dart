// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDetails _$PokemonDetailsFromJson(Map<String, dynamic> json) =>
    PokemonDetails(
      weight: json['weight'] as int,
      baseExperience: json['base_experience'] as int,
      sprite: PokemonDetails._decodeSprite(json['sprites'] as Map),
      stats: (json['stats'] as List<dynamic>)
          .map((e) => PokemonStats.fromJson(e as Map<String, dynamic>))
          .toList(),
      types: PokemonDetails._decodeType(json['types'] as List),
      species: PokemonSpecies.fromJson(json['species'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonDetailsToJson(PokemonDetails instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'base_experience': instance.baseExperience,
      'sprites': PokemonDetails._encodeSprite(instance.sprite),
      'stats': instance.stats,
      'types': PokemonDetails._encodeType(instance.types),
      'species': instance.species,
    };
