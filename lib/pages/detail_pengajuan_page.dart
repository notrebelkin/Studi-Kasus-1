import 'package:flutter/material.dart';
import '../models/pengajuan_model.dart';

class DetailPengajuanPage extends StatelessWidget {
  final Pengajuan pengajuan;
  const DetailPengajuanPage({super.key, required this.pengajuan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengajuan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _baris('Layanan', pengajuan.namaLayanan),
          _baris('Bidang', pengajuan.bidang),
          _baris('Nama Lengkap', pengajuan.namaLengkap),
          _baris('Email', pengajuan.email),
          _baris('Sesi Kunjungan', pengajuan.sesiKunjungan),
          _baris('Status',
              pengajuan.selesai ? 'Selesai ditindaklanjuti' : 'Menunggu'),
          _baris('Dibuat', pengajuan.dibuatPada.toString().substring(0, 19)),
        ],
      ),
    );
  }

  Widget _baris(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(nilai, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}