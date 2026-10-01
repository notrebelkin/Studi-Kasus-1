import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/favorit_model.dart';
import '../navigation/app_routes.dart';

class Layanan {
  final String nama;
  final String dinas;
  final String jam;
  final String keterangan;
  const Layanan(this.nama, this.dinas, this.jam, this.keterangan);
}

const Map<String, List<Layanan>> dataLayanan = {
  'Perizinan': [
    Layanan('Izin Usaha Mikro', 'Dinas Penanaman Modal & PTSP',
        '08.00 - 15.00', 'Pengajuan izin usaha mikro dan kecil.'),
    Layanan('Izin Mendirikan Bangunan', 'Dinas Tata Ruang',
        '08.00 - 14.00', 'Persetujuan konstruksi bangunan.'),
    Layanan('Izin Keramaian', 'Satpol PP', '24 Jam',
        'Izin kegiatan keramaian.'),
  ],
  'Kesehatan': [
    Layanan('Pendaftaran Vaksin', 'Dinas Kesehatan', '07.00 - 13.00',
        'Pendaftaran vaksinasi gratis.'),
    Layanan('Cek Kesehatan Gratis', 'Puskesmas Kota', '08.00 - 12.00',
        'Pemeriksaan kesehatan dasar.'),
    Layanan('Ambulans Darurat', 'Dinas Kesehatan', '24 Jam',
        'Layanan ambulans cepat.'),
  ],
  'Transportasi': [
    Layanan('Kartu Bus Kota', 'Dinas Perhubungan', '08.00 - 16.00',
        'Pembuatan kartu langganan bus.'),
    Layanan('Parkir Berlangganan', 'Dinas Perhubungan', '08.00 - 15.00',
        'Langganan parkir bulanan.'),
    Layanan('Pengaduan Lalu Lintas', 'Dinas Perhubungan', '24 Jam',
        'Laporkan masalah lalu lintas.'),
  ],
};

class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Layanan Publik'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _bukaDrawer(context),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Perizinan'),
              Tab(text: 'Kesehatan'),
              Tab(text: 'Transportasi'),
            ],
          ),
        ),
        body: TabBarView(
          children: dataLayanan.keys.map((kategori) {
            return ListView(
              children: dataLayanan[kategori]!.map((l) {
                return _KartuLayanan(layanan: l);
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _bukaDrawer(BuildContext context) {
    // Akses drawer induk lewat static scaffold key.
    // Perlu import kerangka_navigasi.dart bila belum.
    // (Lihat Modul II.)
  }
}

class _KartuLayanan extends StatelessWidget {
  final Layanan layanan;
  const _KartuLayanan({required this.layanan});

  @override
  Widget build(BuildContext context) {
    // watch: rebuild saat status favorit berubah.
    final favoritModel = context.watch<FavoritModel>();
    final sudahFavorit = favoritModel.apakahFavorit(layanan.nama);

    return ListTile(
      leading: const Icon(Icons.description),
      title: Text(layanan.nama),
      subtitle: Text(layanan.dinas),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ikon bintang favorit.
          IconButton(
            icon: Icon(
              sudahFavorit ? Icons.star : Icons.star_border,
              color: sudahFavorit ? Colors.amber : null,
            ),
            tooltip: sudahFavorit
                ? 'Batalkan favorit'
                : 'Tandai favorit',
            onPressed: () {
              // read: hanya memanggil aksi, tidak ikut rebuild.
              context
                  .read<FavoritModel>()
                  .toggle(layanan.nama);
            },
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: () async {
        final hasil = await Navigator.pushNamed(
          context,
          AppRoutes.detailLayanan,
          arguments: {
            'nama': layanan.nama,
            'dinas': layanan.dinas,
            'jam': layanan.jam,
            'keterangan': layanan.keterangan,
          },
        );
        if (hasil != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(hasil.toString())),
          );
        }
      },
    );
  }
}