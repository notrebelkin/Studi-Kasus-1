import 'package:flutter/foundation.dart';

/// Model satu pengajuan layanan.
class Pengajuan {
  final String id;
  final String namaLayanan;
  final String bidang;      // Perizinan / Kesehatan / Transportasi
  final String namaLengkap;
  final String email;
  final String sesiKunjungan; // Pagi / Siang / Sore
  bool selesai;
  final DateTime dibuatPada;

  Pengajuan({
    required this.id,
    required this.namaLayanan,
    required this.bidang,
    required this.namaLengkap,
    required this.email,
    required this.sesiKunjungan,
    this.selesai = false,
    DateTime? dibuatPada,
  }) : dibuatPada = dibuatPada ?? DateTime.now();
}

class PengajuanModel extends ChangeNotifier {
  final List<Pengajuan> _daftar = [];

  List<Pengajuan> get daftarPengajuan => List.unmodifiable(_daftar);

  int get totalPengajuan => _daftar.length;

  /// Jumlah pengajuan per bidang — dipakai BarChart di Statistik.
  Map<String, int> get jumlahPerBidang {
    final hasil = <String, int>{
      'Perizinan': 0,
      'Kesehatan': 0,
      'Transportasi': 0,
    };
    for (final p in _daftar) {
      hasil[p.bidang] = (hasil[p.bidang] ?? 0) + 1;
    }
    return hasil;
  }

  void tambah(Pengajuan pengajuan) {
    _daftar.add(pengajuan);
    notifyListeners();
  }

  void tandaiSelesai(String id) {
    final index = _daftar.indexWhere((p) => p.id == id);
    if (index == -1) return;
    _daftar[index].selesai = true;
    notifyListeners();
  }

  void kosongkan() {
    if (_daftar.isEmpty) return;
    _daftar.clear();
    notifyListeners();
  }
}