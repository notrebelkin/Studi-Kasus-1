import 'package:flutter/material.dart';
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
    Layanan('Izin Usaha Mikro', 'Dinas Penanaman Modal & PTSP', '08.00 - 15.00',
        'Pengajuan izin usaha mikro dan kecil.'),
    Layanan('Izin Mendirikan Bangunan', 'Dinas Tata Ruang', '08.00 - 14.00',
        'Persetujuan konstruksi bangunan.'),
    Layanan('Izin Keramaian', 'Satpol PP', '24 Jam', 'Izin kegiatan keramaian.'),
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
                return ListTile(
                  leading: const Icon(Icons.description),
                  title: Text(l.nama),
                  subtitle: Text(l.dinas),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    final hasil = await Navigator.pushNamed(
                      context,
                      AppRoutes.detailLayanan,
                      arguments: {
                        'nama': l.nama,
                        'dinas': l.dinas,
                        'jam': l.jam,
                        'keterangan': l.keterangan,
                      },
                    );
                    if (hasil != null && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(hasil.toString())),
                      );
                    }
                  },
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}