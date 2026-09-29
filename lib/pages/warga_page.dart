import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Warga')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Budi Santoso'),
              subtitle: Text('NIK: 3201xxxxxxxxxxxx'),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            icon: const Icon(Icons.history),
            label: const Text('Riwayat Laporan'),
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.riwayatLaporan),
          ),
        ],
      ),
    );
  }
}