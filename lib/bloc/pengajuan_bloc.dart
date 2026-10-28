import 'package:flutter_bloc/flutter_bloc.dart';

// --- Event ---
abstract class PengajuanEvent {}
class TambahPengajuan extends PengajuanEvent {
  final String namaLayanan;
  TambahPengajuan(this.namaLayanan);
}
class KosongkanPengajuan extends PengajuanEvent {}

// --- State ---
class PengajuanState {
  final List<String> daftar;
  const PengajuanState(this.daftar);
  int get totalPengajuan => daftar.length;
}

// --- BLoC ---
class PengajuanBloc extends Bloc<PengajuanEvent, PengajuanState> {
  PengajuanBloc() : super(const PengajuanState([])) {
    on<TambahPengajuan>((event, emit) {
      if (state.daftar.contains(event.namaLayanan)) return;
      emit(PengajuanState([...state.daftar, event.namaLayanan]));
    });
    on<KosongkanPengajuan>((event, emit) {
      emit(const PengajuanState([]));
    });
  }
}