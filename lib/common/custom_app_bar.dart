import 'package:app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/l10n/l10n.dart';
import 'package:pokemon_app/theme/view/app_theme_wrapper.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  static const double appBarHeight = 100;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;

    return Container(
      height: appBarHeight,
      decoration: BoxDecoration(
        color: theme.colors.accentColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppDimensions.borderRadius2x),
          bottomRight: Radius.circular(AppDimensions.borderRadius2x),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const SizedBox(width: AppDimensions.spacer4x),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: theme.colors.iconColor,
                    ),
                    onPressed: Navigator.of(context).pop,
                  ),
                  Text(
                    l10n.myFavourites,
                    style: theme.textStyle.homeTitle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
