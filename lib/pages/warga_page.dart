import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';
import '../models/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Warga')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        children: [
          const Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Budi Santoso'),
              subtitle: Text('NIK: 3201xxxxxxxxxxxx'),
            ),
          ),
          const SizedBox(height: 12),

          // Pintasan ke fitur baru
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _pintasan(context, Icons.chat, 'Tanya Petugas',
                  AppRoutes.tanyaPetugas),
              _pintasan(context, Icons.location_on, 'Lokasi Kantor',
                  AppRoutes.lokasiKantor),
              _pintasan(context, Icons.bar_chart, 'Statistik',
                  AppRoutes.statistikLayanan),
            ],
          ),
          const SizedBox(height: 20),

          // Favorit
          const Text('Layanan Favorit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Consumer<FavoritModel>(
            builder: (context, favorit, _) {
              if (favorit.daftarFavorit.isEmpty) {
                return const Card(
                  child: ListTile(
                    leading: Icon(Icons.star_border),
                    title: Text('Belum ada layanan favorit'),
                  ),
                );
              }
              return Card(
                child: Column(
                  children: favorit.daftarFavorit.map((nama) {
                    return ListTile(
                      leading:
                          const Icon(Icons.star, color: Colors.amber),
                      title: Text(nama),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => context
                            .read<FavoritModel>()
                            .batalTandai(nama),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // Riwayat pengajuan
          const Text('Riwayat Pengajuan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Consumer<PengajuanModel>(
            builder: (context, model, _) {
              if (model.daftarPengajuan.isEmpty) {
                return const Card(
                  child: ListTile(
                    leading: Icon(Icons.inbox_outlined),
                    title: Text('Belum ada pengajuan'),
                    subtitle: Text('Tekan tombol + untuk membuat pengajuan.'),
                  ),
                );
              }
              return Column(
                children: model.daftarPengajuan.map((p) {
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.detailPengajuan,
                      arguments: p,
                    ),
                    onLongPress: () {
                      context.read<PengajuanModel>().tandaiSelesai(p.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${p.namaLayanan} ditandai selesai'),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: Icon(
                          p.selesai
                              ? Icons.check_circle
                              : Icons.pending_actions,
                          color: p.selesai ? Colors.green : Colors.orange,
                        ),
                        title: Text(p.namaLayanan),
                        subtitle: Text(
                            '${p.bidang} • ${p.sesiKunjungan} • ${p.namaLengkap}'),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Pengajuan Baru'),
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.formPengajuan),
      ),
    );
  }

  Widget _pintasan(BuildContext context, IconData icon, String label, String route) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: () => Navigator.pushNamed(context, route),
    );
  }
}