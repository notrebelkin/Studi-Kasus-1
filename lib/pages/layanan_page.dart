import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorit_bloc.dart';
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
                return _KartuLayanan(layanan: l, bidang: kategori);
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _KartuLayanan extends StatelessWidget {
  final Layanan layanan;
  final String bidang;
  const _KartuLayanan({required this.layanan, required this.bidang});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.description),
      title: Text(layanan.nama),
      subtitle: Text(layanan.dinas),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // BlocBuilder dengan buildWhen hanya rebuild saat status favorit
          // layanan ini berubah.
          BlocBuilder<FavoritBloc, Set<String>>(
            buildWhen: (prev, curr) =>
                prev.contains(layanan.nama) != curr.contains(layanan.nama),
            builder: (context, favorit) {
              final sudah = favorit.contains(layanan.nama);
              return IconButton(
                icon: Icon(
                  sudah ? Icons.star : Icons.star_border,
                  color: sudah ? Colors.amber : null,
                ),
                tooltip: sudah ? 'Batalkan favorit' : 'Tandai favorit',
                onPressed: () {
                  final bloc = context.read<FavoritBloc>();
                  if (sudah) {
                    bloc.add(BatalTandaiLayanan(layanan.nama));
                  } else {
                    bloc.add(TandaiLayanan(layanan.nama));
                  }
                },
              );
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