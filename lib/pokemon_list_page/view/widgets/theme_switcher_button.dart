import 'package:app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon_app/src/generated/assets.gen.dart';
import 'package:pokemon_app/theme/bloc/theme_bloc.dart';

class ThemeSwitcherButton extends StatefulWidget {
  const ThemeSwitcherButton({
    super.key,
    required this.isLightTheme,
  });

  final bool isLightTheme;

  @override
  State<ThemeSwitcherButton> createState() => _ThemeSwitcherButtonState();
}

class _ThemeSwitcherButtonState extends State<ThemeSwitcherButton>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  static const double switcherHeight = 40;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      value: widget.isLightTheme ? 0 : 0.8,
      vsync: this,
      duration: const Duration(milliseconds: 500),
      upperBound: 0.8,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ThemeBloc>().add(
              ThemeChanged(
                appTheme:
                    widget.isLightTheme ? AppTheme.dark() : AppTheme.light(),
              ),
            );

        widget.isLightTheme ? _controller.forward() : _controller.reverse();
      },
      child: SizedBox(
        height: switcherHeight,
        child: LottieBuilder.asset(
          Assets.lottie.themeSwitcherLottie,
          controller: _controller,
        ),
      ),
    );
  }
}
