// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonStats _$PokemonStatsFromJson(Map<String, dynamic> json) => PokemonStats(
      value: json['base_stat'] as int,
      effort: json['effort'] as int,
      name: PokemonStats._decodeStat(json['stat'] as Map),
    );

Map<String, dynamic> _$PokemonStatsToJson(PokemonStats instance) =>
    <String, dynamic>{
      'base_stat': instance.value,
      'effort': instance.effort,
      'stat': instance.name,
    };
