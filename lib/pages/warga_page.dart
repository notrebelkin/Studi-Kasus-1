import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';
import '../models/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Card(
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Budi Santoso'),
            subtitle: Text('NIK: 3201xxxxxxxxxxxx'),
          ),
        ),
        const SizedBox(height: 16),

        // ================= Layanan Favorit =================
        const Text('Layanan Favorit',
            style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Consumer<FavoritModel>(
          builder: (context, favorit, _) {
            if (favorit.daftarFavorit.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(Icons.star_border),
                  title: Text('Belum ada layanan favorit'),
                  subtitle: Text(
                      'Tandai layanan dari tab Layanan untuk menambahkannya.'),
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
                      tooltip: 'Hapus dari favorit',
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
        const SizedBox(height: 16),

        // ================= Keranjang Pengajuan =================
        const Text('Pengajuan Aktif',
            style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Consumer<PengajuanModel>(
          builder: (context, pengajuan, _) {
            if (pengajuan.totalPengajuan == 0) {
              return const Card(
                child: ListTile(
                  leading: Icon(Icons.inbox_outlined),
                  title: Text('Belum ada pengajuan'),
                  subtitle: Text(
                      'Ajukan layanan dari halaman rincian layanan.'),
                ),
              );
            }

            return Card(
              child: Column(
                children: [
                  ...pengajuan.daftarPengajuan.map((nama) {
                    return ListTile(
                      leading: const Icon(Icons.send_outlined),
                      title: Text(nama),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => context
                            .read<PengajuanModel>()
                            .hapus(nama),
                      ),
                    );
                  }),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Text(
                          'Total: ${pengajuan.totalPengajuan} layanan',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () {
                            context
                                .read<PengajuanModel>()
                                .kosongkan();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Pengajuan dikirim ke dinas terkait'),
                              ),
                            );
                          },
                          child: const Text('Kirim'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        // ================= Tombol Riwayat =================
        FilledButton.icon(
          icon: const Icon(Icons.history),
          label: const Text('Riwayat Laporan'),
          onPressed: () =>
              Navigator.pushNamed(context, AppRoutes.riwayatLaporan),
        ),
      ],
    );
  }
}