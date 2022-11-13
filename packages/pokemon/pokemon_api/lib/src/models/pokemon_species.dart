import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_species.g.dart';

@JsonSerializable()
class PokemonSpecies extends Equatable {
  final String url;

  @JsonKey(ignore: true)
  final PokemonSpeciesDetails? details;

  const PokemonSpecies({
    required this.url,
    this.details,
  });

  bool get hasDetails => details != null;

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpeciesFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonSpeciesToJson(this);

  @override
  List<Object?> get props => [url, details];

  PokemonSpecies copyWith({
    String? url,
    PokemonSpeciesDetails? details,
  }) {
    return PokemonSpecies(
      url: url ?? this.url,
      details: details ?? this.details,
    );
  }
}

@JsonSerializable(createFactory: false)
class PokemonSpeciesDetails extends Equatable {
  final String color;

  const PokemonSpeciesDetails({
    required this.color,
  });

  factory PokemonSpeciesDetails.fromJson(Map<String, dynamic> json) {
    return PokemonSpeciesDetails(color: json['color']['name'] as String);
  }

  Map<String, dynamic> toJson() => _$PokemonSpeciesDetailsToJson(this);

  @override
  List<Object?> get props => [color];
}
