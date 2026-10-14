import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';
import 'layanan_page.dart';

class FormPengajuanPage extends StatelessWidget {
  const FormPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final semuaLayanan = dataLayanan.entries.expand((e) {
      return e.value.map((l) => MapEntry(e.key, l));
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Layanan')),
      body: ListView(
        children: semuaLayanan.map((entry) {
          final bidang = entry.key;
          final l = entry.value;
          return ListTile(
            leading: const Icon(Icons.description),
            title: Text(l.nama),
            subtitle: Text('$bidang • ${l.dinas}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.detailLayanan,
              arguments: {
                'nama': l.nama,
                'dinas': l.dinas,
                'jam': l.jam,
                'keterangan': l.keterangan,
                'bidang': bidang,
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}