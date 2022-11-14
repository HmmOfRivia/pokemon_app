import 'package:app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_api/pokemon_api.dart';
import 'package:pokemon_app/l10n/l10n.dart';
import 'package:pokemon_app/pokemon_list_page/bloc/pokemon_list_tile_bloc.dart';
import 'package:pokemon_app/theme/view/app_theme_wrapper.dart';
import 'package:pokemon_repository/pokemon_repository.dart';

class PokemonListTile extends StatelessWidget {
  const PokemonListTile({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: key,
      create: (context) => PokemonListTileBloc(
        GetIt.I<PokemonRepository>(),
      )..add(LoadDetailsEvent(name)),
      child: _PokemonListTile(name: name),
    );
  }
}

class _PokemonListTile extends StatelessWidget {
  const _PokemonListTile({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonListTileBloc, PokemonListTileState>(
      builder: (context, state) {
        if (state is PokemonListTileLoaded) {
          return _LoadedListTile(
            key: key,
            name: name,
            pokemonDetails: state.pokemonDetails,
          );
        }

        if (state is PokemonListTileLoading) {
          return const _TileLoadingPlaceholder();
        }

        if (state is PokemonListTileError) {
          return const _TileErrorPlaceholder();
        }

        return const _TileLoadingPlaceholder();
      },
    );
  }
}

class _LoadedListTile extends StatelessWidget {
  const _LoadedListTile({
    super.key,
    required this.name,
    required this.pokemonDetails,
  });

  final String name;
  final PokemonDetails pokemonDetails;

  static const double tileHeight = 140;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      height: tileHeight,
      decoration: BoxDecoration(
        color: AppColors.getCardColor(
          pokemonDetails.species.details!.color,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius1x),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacer4x,
        vertical: AppDimensions.spacer1x,
      ),
      child: Stack(
        children: [
          Align(
            alignment: const FractionalOffset(0.1, 0.6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.textStyle.cardTitle),
                const SizedBox(height: AppDimensions.spacer2x),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final type in pokemonDetails.types) ...[
                      Chip(
                        label: Text(
                          type.name,
                          style: theme.textStyle.chip,
                        ),
                        backgroundColor: theme.colors.accentColor,
                      ),
                      const SizedBox(width: AppDimensions.spacer2x)
                    ],
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: const FractionalOffset(0.8, 0.5),
            child: Image.network(
              pokemonDetails.sprite,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 500),
                  child: child,
                );
              },
            ),
          ),
          // TODO(fliszkiewicz): add favourites icon logic
          Positioned(
            top: 20,
            right: 20,
            child: Icon(
              Icons.star_border_outlined,
              color: theme.colors.iconColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _TileLoadingPlaceholder extends StatelessWidget {
  const _TileLoadingPlaceholder();

  static const double tileHeight = 140;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      height: tileHeight,
      decoration: BoxDecoration(
        color: theme.colors.placeholderColor,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius1x),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacer4x,
        vertical: AppDimensions.spacer1x,
      ),
    );
  }
}

class _TileErrorPlaceholder extends StatelessWidget {
  const _TileErrorPlaceholder();

  static const double tileHeight = 140;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;

    return Container(
      height: tileHeight,
      decoration: BoxDecoration(
        color: theme.colors.placeholderColor,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius1x),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacer4x,
        vertical: AppDimensions.spacer1x,
      ),
      child: Center(
        child: Text(
          l10n.tileLoadingError,
          style: theme.textStyle.cardTitle,
        ),
      ),
    );
  }
}
