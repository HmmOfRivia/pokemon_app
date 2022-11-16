import 'package:animations/animations.dart';
import 'package:app_theme/app_theme.dart';
import 'package:favourite_repository/favourite_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:pokemon_api/pokemon_api.dart';
import 'package:pokemon_app/l10n/l10n.dart';
import 'package:pokemon_app/pokemon_details_page/view/pokemon_details_page.dart';
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
        GetIt.I<FavouriteRepository>(),
      )..add(LoadDetailsEvent(name)),
      child: const _PokemonListTile(),
    );
  }
}

class _PokemonListTile extends StatelessWidget {
  const _PokemonListTile();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonListTileBloc, PokemonListTileState>(
      builder: (context, state) {
        if (state is PokemonListTileLoaded) {
          return _TileLoaded(
            name: state.name,
            details: state.pokemonDetails,
            isFavourite: state.isFavourite,
          );
        }

        if (state is PokemonListTileLoading) {
          return const TileLoadingPlaceholder();
        }

        if (state is PokemonListTileError) {
          return const _TileErrorPlaceholder();
        }

        return const TileLoadingPlaceholder();
      },
    );
  }
}

class _TileLoaded extends StatelessWidget {
  const _TileLoaded({
    required this.name,
    required this.details,
    required this.isFavourite,
  });

  final String name;
  final PokemonDetails details;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppDimensions.spacer4x,
        AppDimensions.spacer4x,
        AppDimensions.spacer4x,
        0,
      ),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadius1x,
          ),
        ),
        closedColor: AppColors.getCardColor(
          details.species.details!.color,
        ),
        openColor: AppColors.getCardColor(
          details.species.details!.color,
        ),
        closedBuilder: (_, __) {
          return _LoadedListTile(
            key: key,
            name: name,
            pokemonDetails: details,
            isFavourite: isFavourite,
          );
        },
        openBuilder: (_, __) {
          return BlocProvider.value(
            value: context.read<PokemonListTileBloc>(),
            child: PokemonDetailsPage(
              key: Key(name + isFavourite.toString()),
              name: name,
              details: details,
            ),
          );
        },
      ),
    );
  }
}

class _LoadedListTile extends StatelessWidget {
  const _LoadedListTile({
    super.key,
    required this.name,
    required this.pokemonDetails,
    required this.isFavourite,
  });

  final String name;

  final PokemonDetails pokemonDetails;

  final bool isFavourite;

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
      child: Stack(
        children: [
          Align(
            alignment: const FractionalOffset(0.1, 0.6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  toBeginningOfSentenceCase(name) ?? name,
                  style: theme.textStyle.cardTitle,
                ),
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
                      const SizedBox(width: AppDimensions.spacer2x),
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
          Positioned(
            top: AppDimensions.spacer4x,
            right: AppDimensions.spacer4x,
            child: IconButton(
              onPressed: () => context.read<PokemonListTileBloc>().add(
                    PokemonChangeFavouriteEvent(isFavourite: !isFavourite),
                  ),
              icon: Icon(
                isFavourite ? Icons.star : Icons.star_border_outlined,
                color: theme.colors.iconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TileLoadingPlaceholder extends StatelessWidget {
  const TileLoadingPlaceholder({super.key});

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
      margin: const EdgeInsets.fromLTRB(
        AppDimensions.spacer4x,
        AppDimensions.spacer4x,
        AppDimensions.spacer4x,
        0,
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
      margin: const EdgeInsets.fromLTRB(
        AppDimensions.spacer4x,
        AppDimensions.spacer4x,
        AppDimensions.spacer4x,
        0,
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
