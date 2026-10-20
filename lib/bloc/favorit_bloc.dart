import 'package:flutter_bloc/flutter_bloc.dart';

// ---------- Event ----------
abstract class FavoritEvent {
  const FavoritEvent();
}

class TandaiLayanan extends FavoritEvent {
  final String namaLayanan;
  const TandaiLayanan(this.namaLayanan);
}

class BatalTandaiLayanan extends FavoritEvent {
  final String namaLayanan;
  const BatalTandaiLayanan(this.namaLayanan);
}

// ---------- State ----------
// State cukup berupa Set<String>. Kita bisa memakai tipe langsung
// atau wrapper class. Di sini memakai Set<String> agar ringkas.
class FavoritBloc extends Bloc<FavoritEvent, Set<String>> {
  FavoritBloc() : super(const <String>{}) {
    on<TandaiLayanan>((event, emit) {
      emit({...state, event.namaLayanan});
    });

    on<BatalTandaiLayanan>((event, emit) {
      final baru = {...state}..remove(event.namaLayanan);
      emit(baru);
    });
  }
}