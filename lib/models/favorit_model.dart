import 'package:flutter/material.dart';

class FavoritModel extends ChangeNotifier {
  final Set<String> _favorit = {};

  /// Kumpulan nama layanan favorit (read-only).
  Set<String> get daftarFavorit => _favorit;

  /// Cek apakah sebuah layanan sudah ditandai favorit.
  bool apakahFavorit(String namaLayanan) => _favorit.contains(namaLayanan);

  /// Tandai layanan sebagai favorit.
  void tandai(String namaLayanan) {
    if (_favorit.add(namaLayanan)) {
      notifyListeners();
    }
  }

  /// Batalkan tanda favorit.
  void batalTandai(String namaLayanan) {
    if (_favorit.remove(namaLayanan)) {
      notifyListeners();
    }
  }

  /// Toggle: tandai kalau belum, batalkan kalau sudah.
  void toggle(String namaLayanan) {
    if (_favorit.contains(namaLayanan)) {
      batalTandai(namaLayanan);
    } else {
      tandai(namaLayanan);
    }
  }
}