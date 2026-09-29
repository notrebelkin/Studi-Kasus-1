import 'package:flutter/material.dart';

class DetailLayananPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const DetailLayananPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
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
                icon: const Icon(Icons.send),
                label: const Text('Ajukan Permohonan'),
                onPressed: () {
                  Navigator.pop(
                    context,
                    'Permohonan ${data['nama']} telah diajukan',
                  );
                },
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
              style: const TextStyle(
                  fontSize: 12, color: Colors.grey)),
          Text(nilai, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}