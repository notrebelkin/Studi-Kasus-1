import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pengajuan_model.dart';

class DetailLayananPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const DetailLayananPage({super.key, required this.data});

  @override
  State<DetailLayananPage> createState() => _DetailLayananPageState();
}

class _DetailLayananPageState extends State<DetailLayananPage> {
  final _namaCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  bool _setuju = false;
  String _sesi = 'Pagi';
  bool _sedangMengirim = false;

  @override
  void dispose() {
    _namaCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  /// Validasi: semua kolom terisi, email mengandung "@", checkbox dicentang.
  bool get _formValid {
    final namaOk = _namaCtrl.text.trim().isNotEmpty;
    final emailOk = _emailCtrl.text.contains('@') &&
        _emailCtrl.text.trim().isNotEmpty;
    return namaOk && emailOk && _setuju;
  }

  Future<void> _kirim() async {
    setState(() => _sedangMengirim = true);

    // Simulasi pengiriman.
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;

    // Simpan ke PengajuanModel.
    context.read<PengajuanModel>().tambah(Pengajuan(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      namaLayanan: widget.data['nama'],
      bidang: widget.data['bidang'] ?? 'Perizinan',
      namaLengkap: _namaCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      sesiKunjungan: _sesi,
    ));

    setState(() => _sedangMengirim = false);

    if (!mounted) return;
    Navigator.pop(context, 'Pengajuan ${widget.data['nama']} berhasil dikirim');
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      appBar: AppBar(title: Text(data['nama'] ?? 'Detail Layanan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(data['nama'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _infoBaris('Dinas Penanggung Jawab', data['dinas'] ?? '-'),
          _infoBaris('Jam Operasional', data['jam'] ?? '-'),
          _infoBaris('Keterangan', data['keterangan'] ?? '-'),
          const Divider(height: 32),

          const Text('Formulir Pengajuan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          TextField(
            controller: _namaCtrl,
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              helperText: 'Harus mengandung karakter @',
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),

          const Text('Sesi Kunjungan',
              style: TextStyle(fontWeight: FontWeight.bold)),
          RadioListTile<String>(
            title: const Text('Pagi (08.00 - 11.00)'),
            value: 'Pagi',
            groupValue: _sesi,
            onChanged: (v) => setState(() => _sesi = v!),
          ),
          RadioListTile<String>(
            title: const Text('Siang (11.00 - 14.00)'),
            value: 'Siang',
            groupValue: _sesi,
            onChanged: (v) => setState(() => _sesi = v!),
          ),
          RadioListTile<String>(
            title: const Text('Sore (14.00 - 16.00)'),
            value: 'Sore',
            groupValue: _sesi,
            onChanged: (v) => setState(() => _sesi = v!),
          ),

          CheckboxListTile(
            title: const Text('Saya menyetujui penggunaan data pribadi'),
            value: _setuju,
            onChanged: (v) => setState(() => _setuju = v ?? false),
          ),

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: _sedangMengirim
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.send),
              label: Text(_sedangMengirim ? 'Mengirim...' : 'Kirim Pengajuan'),
              onPressed: (_formValid && !_sedangMengirim) ? _kirim : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBaris(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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