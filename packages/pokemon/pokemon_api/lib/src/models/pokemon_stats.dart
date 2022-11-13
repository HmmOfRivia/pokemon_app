import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_stats.g.dart';

@JsonSerializable()
class PokemonStats extends Equatable {
  @JsonKey(name: 'base_stat')
  final int value;

  final int effort;

  @JsonKey(name: 'stat', fromJson: _decodeStat)
  final String name;

  const PokemonStats({
    required this.value,
    required this.effort,
    required this.name,
  });

  factory PokemonStats.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatsFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonStatsToJson(this);

  static String _decodeStat(Map input) {
    return input['name'];
  }

  @override
  List<Object?> get props => [value, effort, name];
}
