import 'package:flutter/foundation.dart';

class Pesan {
  final String teks;
  final bool dariWarga;
  final DateTime waktu;
  Pesan({
    required this.teks,
    required this.dariWarga,
    DateTime? waktu,
  }) : waktu = waktu ?? DateTime.now();
}

class ChatModel extends ChangeNotifier {
  final List<Pesan> _pesan = [];

  List<Pesan> get pesan => List.unmodifiable(_pesan);

  void kirim(String teks) {
    if (teks.trim().isEmpty) return;
    _pesan.add(Pesan(teks: teks.trim(), dariWarga: true));
    notifyListeners();

    // Balasan otomatis dari petugas setelah jeda singkat (simulasi).
    Future.delayed(const Duration(milliseconds: 800), () {
      _pesan.add(Pesan(
        teks: 'Terima kasih, pesan Anda sudah kami terima.',
        dariWarga: false,
      ));
      notifyListeners();
    });
  }
}