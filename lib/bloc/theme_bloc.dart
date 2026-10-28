import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// --- Event ---
abstract class ThemeEvent {}
class UbahTema extends ThemeEvent {
  final bool modeGelap;
  UbahTema(this.modeGelap);
}

// --- BLoC ---
class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.light) {
    on<UbahTema>((event, emit) {
      emit(event.modeGelap ? ThemeMode.dark : ThemeMode.light);
    });
  }
}