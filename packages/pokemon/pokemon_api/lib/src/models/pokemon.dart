import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon extends Equatable {
  final String name;

  @JsonKey(name: 'url')
  final String detailsUrl;

  const Pokemon({
    required this.name,
    required this.detailsUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonToJson(this);

  @override
  List<Object?> get props => [name, detailsUrl];
}
