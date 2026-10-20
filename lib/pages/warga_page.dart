import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorit_bloc.dart';
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

        const Text('Layanan Favorit',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        BlocBuilder<FavoritBloc, Set<String>>(
          builder: (context, favorit) {
            if (favorit.isEmpty) {
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
                children: favorit.map((nama) {
                  return ListTile(
                    leading: const Icon(Icons.star, color: Colors.amber),
                    title: Text(nama),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      tooltip: 'Hapus dari favorit',
                      onPressed: () => context
                          .read<FavoritBloc>()
                          .add(BatalTandaiLayanan(nama)),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
        const SizedBox(height: 16),

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