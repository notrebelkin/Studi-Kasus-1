import 'package:flutter_bloc/flutter_bloc.dart';

// --- Event ---
abstract class FavoritEvent {}
class TandaiLayanan extends FavoritEvent {
  final String namaLayanan;
  TandaiLayanan(this.namaLayanan);
}
class BatalTandaiLayanan extends FavoritEvent {
  final String namaLayanan;
  BatalTandaiLayanan(this.namaLayanan);
}

// --- BLoC ---
class FavoritBloc extends Bloc<FavoritEvent, Set<String>> {
  FavoritBloc() : super(const <String>{}) {
    on<TandaiLayanan>((event, emit) {
      emit({...state, event.namaLayanan}); // Emit Set baru
    });
    on<BatalTandaiLayanan>((event, emit) {
      final baru = {...state}..remove(event.namaLayanan);
      emit(baru);
    });
  }
}