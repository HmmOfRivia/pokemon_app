// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:pokemon_api/pokemon_api.dart';

import 'package:pokemon_app/theme/view/app_theme_wrapper.dart';

class PokemonDetailsPage extends StatelessWidget {
  const PokemonDetailsPage({
    super.key,
    required this.name,
    required this.details,
  });

  final String name;
  final PokemonDetails details;

  static const double imageSize = 300;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final height = MediaQuery.of(context).size.height * 0.5;

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height,
            padding: const EdgeInsets.all(AppDimensions.spacer4x),
            decoration: BoxDecoration(
              color: theme.colors.backgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppDimensions.borderRadius4x),
              ),
            ),
            child: ListView(
              children: [
                for (final stat in details.stats) ...[
                  const SizedBox(height: AppDimensions.spacer5x),
                  _StatsRow(
                    name: toBeginningOfSentenceCase(stat.name) ?? stat.name,
                    value: stat.value,
                  ),
                ],
                const SizedBox(height: AppDimensions.spacer5x),
                _StatsRow(
                  name: 'Weight',
                  value: details.weight,
                  maxValue: 1000,
                ),
                const SizedBox(height: AppDimensions.spacer5x),
                _StatsRow(
                  name: 'Experience',
                  value: details.baseExperience,
                  maxValue: 300,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: height - 50,
          child: Image.network(
            details.sprite,
            height: imageSize,
            width: imageSize,
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
          top: 50,
          left: 20,
          right: 20,
          child: _PokemonDetailsTitleBar(name: name),
        )
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({
    required this.name,
    required this.value,
    this.maxValue = 100,
  });

  final String name;
  final int value;
  final int maxValue;

  static const double proggressHeight = 20;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Row(
      children: [
        Expanded(
          flex: 35,
          child: Text(name, style: theme.textStyle.statsRow),
        ),
        Expanded(
          flex: 65,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            tween: Tween<double>(
              begin: 0,
              end: value / maxValue,
            ),
            builder: (context, value, _) => ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius2x),
              child: SizedBox(
                height: proggressHeight,
                child: LinearProgressIndicator(value: value),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _PokemonDetailsTitleBar extends StatelessWidget {
  const _PokemonDetailsTitleBar({
    required this.name,
  });

  final String name;

  static const double titleBarHeight = 50;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return SizedBox(
      height: titleBarHeight,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: theme.colors.iconColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.star_border_outlined,
              color: theme.colors.iconColor,
            ),
          ),
          Center(
            child: Text(
              toBeginningOfSentenceCase(name) ?? name,
              style: theme.textStyle.detailTitle,
            ),
          ),
        ],
      ),
    );
  }
}
