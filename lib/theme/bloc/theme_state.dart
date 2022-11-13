part of 'theme_bloc.dart';

@immutable
class ThemeState extends Equatable {
  const ThemeState({
    required this.appTheme,
  });

  final AppTheme appTheme;

  @override
  List<Object?> get props => [appTheme];
}
