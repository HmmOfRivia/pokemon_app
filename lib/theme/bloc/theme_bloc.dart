import 'package:app_theme/app_theme.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pokemon_app/theme/repository/theme_repository.dart';
import 'package:storage/storage.dart';

part 'theme_event.dart';
part 'theme_state.dart';

@singleton
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(this._themeRepository)
      : super(ThemeState(appTheme: AppTheme.light())) {
    on<ThemeChanged>(_onThemeChangedEvent);
    on<ThemeLoad>(_onThemeLoadEvent);
  }

  final ThemeRepository _themeRepository;

  void _onThemeChangedEvent(ThemeChanged event, Emitter<ThemeState> emit) {
    try {
      _themeRepository.saveThemeToStorage(event.appTheme);
    } on StorageException catch (error, stackTrace) {
      onError(error, stackTrace);
    }

    emit(ThemeState(appTheme: event.appTheme));
  }

  Future<void> _onThemeLoadEvent(
    ThemeLoad event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      final theme = await _themeRepository.getThemeFromStorage();

      if (theme != null) {
        emit(ThemeState(appTheme: theme));
      }
    } on StorageException catch (error, stackTrace) {
      onError(error, stackTrace);
    }
  }
}
