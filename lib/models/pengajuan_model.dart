import 'package:flutter/material.dart';

class PengajuanModel extends ChangeNotifier {
  final List<String> _pengajuan = [];

  /// Daftar layanan yang sedang diajukan (read-only).
  List<String> get daftarPengajuan => List.unmodifiable(_pengajuan);

  /// Jumlah pengajuan aktif — dipakai badge.
  int get totalPengajuan => _pengajuan.length;

  /// Tambah layanan ke keranjang pengajuan.
  /// Kalau sudah ada, tidak ditambahkan dua kali.
  void tambah(String namaLayanan) {
    if (!_pengajuan.contains(namaLayanan)) {
      _pengajuan.add(namaLayanan);
      notifyListeners();
    }
  }

  /// Hapus satu layanan dari keranjang.
  void hapus(String namaLayanan) {
    if (_pengajuan.remove(namaLayanan)) {
      notifyListeners();
    }
  }

  /// Kosongkan keranjang setelah dikirim ke dinas.
  void kosongkan() {
    if (_pengajuan.isNotEmpty) {
      _pengajuan.clear();
      notifyListeners();
    }
  }
}