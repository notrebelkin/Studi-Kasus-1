import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class RouteTidakDikenalPage extends StatelessWidget {
  final String namaRoute;
  const RouteTidakDikenalPage({super.key, required this.namaRoute});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Route Tidak Dikenal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 12),
            Text('Route "$namaRoute" tidak terdaftar.'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.beranda, (_) => false),
              child: const Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }
}