import 'package:flutter_bloc/flutter_bloc.dart';

// ---------- Event ----------
abstract class PengajuanEvent {
  const PengajuanEvent();
}

class TambahPengajuan extends PengajuanEvent {
  final String namaLayanan;
  final String bidang;   // opsional, untuk statistik
  const TambahPengajuan(this.namaLayanan, {this.bidang = 'Perizinan'});
}

class HapusPengajuan extends PengajuanEvent {
  final String namaLayanan;
  const HapusPengajuan(this.namaLayanan);
}

class KosongkanPengajuan extends PengajuanEvent {
  const KosongkanPengajuan();
}

// ---------- State ----------
class PengajuanState {
  final List<String> daftar;
  const PengajuanState(this.daftar);

  int get totalPengajuan => daftar.length;

  List<String> get daftarPengajuan => List.unmodifiable(daftar);
}

// ---------- BLoC ----------
class PengajuanBloc extends Bloc<PengajuanEvent, PengajuanState> {
  PengajuanBloc() : super(const PengajuanState([])) {
    on<TambahPengajuan>((event, emit) {
      if (state.daftar.contains(event.namaLayanan)) return; // no duplikat
      final baru = [...state.daftar, event.namaLayanan];
      emit(PengajuanState(baru));
    });

    on<HapusPengajuan>((event, emit) {
      final baru = state.daftar
          .where((n) => n != event.namaLayanan)
          .toList();
      emit(PengajuanState(baru));
    });

    on<KosongkanPengajuan>((event, emit) {
      emit(const PengajuanState([]));
    });
  }
}