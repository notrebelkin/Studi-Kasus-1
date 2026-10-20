import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/pengajuan_bloc.dart';

class DetailLayananPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const DetailLayananPage({super.key, required this.data});

  @override
  State<DetailLayananPage> createState() => _DetailLayananPageState();
}

class _DetailLayananPageState extends State<DetailLayananPage> {
  bool _sedangMengirim = false; // state lokal via setState

  Future<void> _ajukan() async {
    setState(() => _sedangMengirim = true);

    // Simulasi pengiriman.
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;

    // Kirim event ke BLoC (BUKAN panggil method model langsung).
    context
        .read<PengajuanBloc>()
        .add(TambahPengajuan(widget.data['nama']));

    setState(() => _sedangMengirim = false);

    if (!mounted) return;
    Navigator.pop(
      context,
      'Permohonan ${widget.data['nama']} telah diajukan',
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      appBar: AppBar(title: Text(data['nama'] ?? 'Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data['nama'],
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _baris('Dinas Penanggung Jawab', data['dinas']),
            _baris('Jam Operasional', data['jam']),
            _baris('Keterangan', data['keterangan']),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: _sedangMengirim
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.send),
                label: Text(_sedangMengirim
                    ? 'Mengirim...'
                    : 'Ajukan Permohonan'),
                onPressed: _sedangMengirim ? null : _ajukan,
              ),
            ),
          ],
        ),
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