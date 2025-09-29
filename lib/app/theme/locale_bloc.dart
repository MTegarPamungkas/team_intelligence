import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:team_intelligence/core/storage/local_storage.dart';

// Events
abstract class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object> get props => [];
}

class LoadLocale extends LocaleEvent {}

class ChangeLocale extends LocaleEvent {
  final String languageCode;

  const ChangeLocale(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}

// State
class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState(this.locale);

  @override
  List<Object> get props => [locale];
}

// Bloc
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final LocalStorage localStorage = GetIt.instance<LocalStorage>();
  static const String _localeKey = 'locale';

  LocaleBloc() : super(const LocaleState(Locale('en'))) {
    on<LoadLocale>(_onLoadLocale);
    on<ChangeLocale>(_onChangeLocale);
  }

  Future<void> _onLoadLocale(
    LoadLocale event,
    Emitter<LocaleState> emit,
  ) async {
    final languageCode = localStorage.getString(_localeKey) ?? 'en';
    emit(LocaleState(Locale(languageCode)));
  }

  Future<void> _onChangeLocale(
    ChangeLocale event,
    Emitter<LocaleState> emit,
  ) async {
    await localStorage.setString(_localeKey, event.languageCode);
    emit(LocaleState(Locale(event.languageCode)));
  }
}
